extends SceneTree

const SHARE_SCRIPT := preload("res://scripts/planet_memory_share.gd")
const QR := preload("res://addons/specqr/specqr.gd")
const SHARE_BASE_URL := "https://second111.github.io/prince-paper-stars-web/share.html"
const OUTPUT_PATH := "res://tools/test_output/web_share_qr_test.png"


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var share = SHARE_SCRIPT.new()
	root.add_child(share)
	var memory_id := share.create_memory(
		"第七颗星",
		"温柔 | 好奇星球",
		"你把一路收集来的纸灯、花束和书页放进这里，让这颗星球慢慢有了自己的样子。",
		"你搭起小屋、帐篷与长桌，又把茶具、野餐篮和一小束麦子留在周围。",
		"你最后停在一盏灯旁边，像是在为这段旅程留下一个发光的标点。"
	)
	var shares: Dictionary = share.get("_shares")
	var memory: Dictionary = shares[memory_id]
	var encoded := String(share.call("_encode_web_payload", memory))
	var url := SHARE_BASE_URL + "?d=" + encoded
	var qr_data = QR.generate(url, {
		"errorCorrectionLevel": "M",
		"margin": 4,
	})
	if QR.is_error(qr_data):
		push_error(String(qr_data.get("message", "QR generation failed")))
		quit(1)
		return
	var image = QR.to_image(qr_data, {
		"margin": 4,
		"scale": 12,
		"foreground": "#241a14",
		"background": "#f2e5c4",
	})
	if QR.is_error(image):
		push_error(String(image.get("message", "QR image failed")))
		quit(1)
		return
	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path("res://tools/test_output")
	)
	var save_error: Error = (image as Image).save_png(OUTPUT_PATH)
	if save_error != OK:
		push_error("Could not save QR image: %s" % error_string(save_error))
		quit(1)
		return
	print(
		"WEB_SHARE_QR url_length=",
		url.length(),
		" path=",
		ProjectSettings.globalize_path(OUTPUT_PATH),
		" url=",
		url
	)
	quit(0)
