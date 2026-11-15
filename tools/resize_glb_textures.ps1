param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    [int]$Size = 512
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$inputFullPath = (Resolve-Path -LiteralPath $InputPath).Path
$inputBytes = [System.IO.File]::ReadAllBytes($inputFullPath)
if (
    $inputBytes.Length -lt 20 -or
    [System.BitConverter]::ToUInt32($inputBytes, 0) -ne 0x46546C67
) {
    throw "Input is not a valid GLB 2.0 file: $inputFullPath"
}

$jsonLength = [System.BitConverter]::ToUInt32($inputBytes, 12)
$jsonType = [System.BitConverter]::ToUInt32($inputBytes, 16)
if ($jsonType -ne 0x4E4F534A) {
    throw "The first GLB chunk is not JSON."
}

$jsonText = [System.Text.Encoding]::UTF8.GetString($inputBytes, 20, $jsonLength)
$document = $jsonText | ConvertFrom-Json

$binaryHeaderOffset = 20 + $jsonLength
$binaryLength = [System.BitConverter]::ToUInt32($inputBytes, $binaryHeaderOffset)
$binaryType = [System.BitConverter]::ToUInt32($inputBytes, $binaryHeaderOffset + 4)
if ($binaryType -ne 0x004E4942) {
    throw "The second GLB chunk is not BIN."
}
$binaryOffset = $binaryHeaderOffset + 8
$sourceBinary = New-Object byte[] $binaryLength
[System.Array]::Copy(
    $inputBytes,
    $binaryOffset,
    $sourceBinary,
    0,
    $binaryLength
)

function Resize-EmbeddedImage {
    param(
        [byte[]]$Source,
        [string]$MimeType,
        [int]$TargetSize
    )

    $sourceStream = [System.IO.MemoryStream]::new($Source, $false)
    try {
        $sourceImage = [System.Drawing.Image]::FromStream(
            $sourceStream,
            $true,
            $true
        )
        try {
            $bitmap = [System.Drawing.Bitmap]::new(
                $TargetSize,
                $TargetSize,
                [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
            )
            try {
                $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
                try {
                    $graphics.Clear([System.Drawing.Color]::Transparent)
                    $graphics.CompositingQuality =
                        [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
                    $graphics.InterpolationMode =
                        [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
                    $graphics.SmoothingMode =
                        [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
                    $graphics.PixelOffsetMode =
                        [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
                    $graphics.DrawImage(
                        $sourceImage,
                        0,
                        0,
                        $TargetSize,
                        $TargetSize
                    )
                }
                finally {
                    $graphics.Dispose()
                }

                $outputStream = [System.IO.MemoryStream]::new()
                try {
                    $format = if ($MimeType -eq "image/png") {
                        [System.Drawing.Imaging.ImageFormat]::Png
                    }
                    else {
                        [System.Drawing.Imaging.ImageFormat]::Jpeg
                    }
                    $bitmap.Save($outputStream, $format)
                    return ,$outputStream.ToArray()
                }
                finally {
                    $outputStream.Dispose()
                }
            }
            finally {
                $bitmap.Dispose()
            }
        }
        finally {
            $sourceImage.Dispose()
        }
    }
    finally {
        $sourceStream.Dispose()
    }
}

$imageBufferViews = @{}
for ($imageIndex = 0; $imageIndex -lt $document.images.Count; $imageIndex++) {
    $image = $document.images[$imageIndex]
    if ($null -ne $image.bufferView) {
        $imageBufferViews[[int]$image.bufferView] = $imageIndex
    }
}
if ($imageBufferViews.Count -eq 0) {
    throw "No embedded images were found in this GLB."
}

$newBinaryStream = [System.IO.MemoryStream]::new()
try {
    $orderedViews = @($document.bufferViews | Sort-Object { [int]$_.byteOffset })
    foreach ($view in $orderedViews) {
        $oldOffset = [int]$view.byteOffset
        $oldLength = [int]$view.byteLength
        if ($imageBufferViews.ContainsKey(
            [array]::IndexOf($document.bufferViews, $view)
        )) {
            $imageIndex = $imageBufferViews[
                [array]::IndexOf($document.bufferViews, $view)
            ]
            $source = New-Object byte[] $oldLength
            [System.Array]::Copy($sourceBinary, $oldOffset, $source, 0, $oldLength)
            $newBytes = Resize-EmbeddedImage `
                -Source $source `
                -MimeType ([string]$document.images[$imageIndex].mimeType) `
                -TargetSize $Size
        }
        else {
            $newBytes = New-Object byte[] $oldLength
            [System.Array]::Copy(
                $sourceBinary,
                $oldOffset,
                $newBytes,
                0,
                $oldLength
            )
        }

        $view.byteOffset = [int]$newBinaryStream.Length
        $view.byteLength = $newBytes.Length
        $newBinaryStream.Write($newBytes, 0, $newBytes.Length)
        while (($newBinaryStream.Length % 4) -ne 0) {
            $newBinaryStream.WriteByte(0)
        }
    }
    $newBinary = $newBinaryStream.ToArray()
}
finally {
    $newBinaryStream.Dispose()
}
$document.buffers[0].byteLength = $newBinary.Length

$newJsonBytes = [System.Text.Encoding]::UTF8.GetBytes(
    ($document | ConvertTo-Json -Depth 100 -Compress)
)
$jsonPadding = (4 - ($newJsonBytes.Length % 4)) % 4
$binaryPadding = (4 - ($newBinary.Length % 4)) % 4
$totalLength = 12 + 8 + $newJsonBytes.Length + $jsonPadding +
    8 + $newBinary.Length + $binaryPadding
$outputBytes = New-Object byte[] $totalLength

[System.Array]::Copy(
    [System.BitConverter]::GetBytes([uint32]0x46546C67),
    0,
    $outputBytes,
    0,
    4
)
[System.Array]::Copy(
    [System.BitConverter]::GetBytes([uint32]2),
    0,
    $outputBytes,
    4,
    4
)
[System.Array]::Copy(
    [System.BitConverter]::GetBytes([uint32]$totalLength),
    0,
    $outputBytes,
    8,
    4
)
[System.Array]::Copy(
    [System.BitConverter]::GetBytes(
        [uint32]($newJsonBytes.Length + $jsonPadding)
    ),
    0,
    $outputBytes,
    12,
    4
)
[System.Array]::Copy(
    [System.BitConverter]::GetBytes([uint32]0x4E4F534A),
    0,
    $outputBytes,
    16,
    4
)
[System.Array]::Copy($newJsonBytes, 0, $outputBytes, 20, $newJsonBytes.Length)
for ($index = 0; $index -lt $jsonPadding; $index++) {
    $outputBytes[20 + $newJsonBytes.Length + $index] = 0x20
}

$newBinaryHeaderOffset = 20 + $newJsonBytes.Length + $jsonPadding
[System.Array]::Copy(
    [System.BitConverter]::GetBytes(
        [uint32]($newBinary.Length + $binaryPadding)
    ),
    0,
    $outputBytes,
    $newBinaryHeaderOffset,
    4
)
[System.Array]::Copy(
    [System.BitConverter]::GetBytes([uint32]0x004E4942),
    0,
    $outputBytes,
    $newBinaryHeaderOffset + 4,
    4
)
$newBinaryOffset = $newBinaryHeaderOffset + 8
[System.Array]::Copy(
    $newBinary,
    0,
    $outputBytes,
    $newBinaryOffset,
    $newBinary.Length
)

$outputFullPath = [System.IO.Path]::GetFullPath($OutputPath)
$outputDirectory = [System.IO.Path]::GetDirectoryName($outputFullPath)
[System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
[System.IO.File]::WriteAllBytes($outputFullPath, $outputBytes)

Write-Output "Wrote $outputFullPath"
Write-Output "Images: $($document.images.Count), target size: ${Size}x${Size}"
Write-Output "File size: $((Get-Item -LiteralPath $outputFullPath).Length) bytes"
