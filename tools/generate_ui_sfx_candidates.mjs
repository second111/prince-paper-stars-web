import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const sampleRate = 48000;
const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const outputDir = path.join(root, "assets", "audio", "candidates", "custom_round1");
fs.mkdirSync(outputDir, { recursive: true });

let randomState = 0x51f15e;
function randomSigned() {
	randomState = (Math.imul(randomState, 1664525) + 1013904223) >>> 0;
	return (randomState / 0xffffffff) * 2 - 1;
}

function makeBuffer(seconds) {
	return new Float32Array(Math.ceil(seconds * sampleRate));
}

function addSoftPaper(buffer, amount = 0.22) {
	let low = 0;
	let slower = 0;
	for (let i = 0; i < buffer.length; i++) {
		const t = i / sampleRate;
		const attack = Math.min(1, t / 0.0035);
		const decay = Math.exp(-t / 0.042);
		const noise = randomSigned();
		low += (noise - low) * 0.075;
		slower += (low - slower) * 0.018;
		const paper = (low - slower) * attack * decay;
		const body = Math.sin(Math.PI * 2 * (176 + 42 * Math.exp(-t / 0.025)) * t)
			* Math.exp(-t / 0.026) * 0.12;
		buffer[i] += (paper * 0.82 + body) * amount;
	}
}

function addFeltTap(buffer, amount = 0.18) {
	let low = 0;
	for (let i = 0; i < buffer.length; i++) {
		const t = i / sampleRate;
		const attack = Math.min(1, t / 0.006);
		const decay = Math.exp(-t / 0.035);
		low += (randomSigned() - low) * 0.035;
		const body = Math.sin(Math.PI * 2 * 138 * t) * Math.exp(-t / 0.05);
		buffer[i] += (low * 0.28 + body * 0.16) * attack * decay * amount;
	}
}

function addWarmWood(buffer, amount = 0.24) {
	let low = 0;
	for (let i = 0; i < buffer.length; i++) {
		const t = i / sampleRate;
		const attack = Math.min(1, t / 0.0028);
		low += (randomSigned() - low) * 0.055;
		const modeA = Math.sin(Math.PI * 2 * 178 * t) * Math.exp(-t / 0.075);
		const modeB = Math.sin(Math.PI * 2 * 356 * t + 0.35) * Math.exp(-t / 0.042);
		const modeC = Math.sin(Math.PI * 2 * 612 * t + 0.8) * Math.exp(-t / 0.021);
		const tap = low * Math.exp(-t / 0.018);
		buffer[i] += (
			modeA * 0.34
			+ modeB * 0.16
			+ modeC * 0.055
			+ tap * 0.32
		) * attack * amount;
	}
}

function addPaperPress(buffer, amount = 0.20) {
	let low = 0;
	let slower = 0;
	for (let i = 0; i < buffer.length; i++) {
		const t = i / sampleRate;
		const attack = Math.min(1, t / 0.008);
		const release = Math.exp(-t / 0.075);
		const noise = randomSigned();
		low += (noise - low) * 0.06;
		slower += (low - slower) * 0.015;
		const paper = (low - slower) * release;
		const press = Math.sin(Math.PI * 2 * 118 * t) * Math.exp(-t / 0.085);
		buffer[i] += (paper * 0.62 + press * 0.18) * attack * amount;
	}
}

function addMusicBox(buffer, notes, amount = 0.16, spacing = 0.07) {
	const partials = [1, 2.01, 2.73, 4.08];
	const partialGain = [1, 0.16, 0.065, 0.018];
	for (let n = 0; n < notes.length; n++) {
		const offset = n * spacing;
		const frequency = notes[n];
		const start = Math.floor(offset * sampleRate);
		for (let i = start; i < buffer.length; i++) {
			const t = (i - start) / sampleRate;
			const attack = Math.min(1, t / 0.008);
			const decay = Math.exp(-t / 0.32);
			const tremolo = 1 + Math.sin(Math.PI * 2 * 4.2 * t) * 0.025;
			let sample = 0;
			for (let p = 0; p < partials.length; p++) {
				sample += Math.sin(
					Math.PI * 2 * frequency * partials[p] * t
					+ 0.11 * p
				) * partialGain[p];
			}
			buffer[i] += sample * attack * decay * tremolo * amount;
		}
	}
}

function addWarmChime(buffer, notes, amount = 0.13, spacing = 0.11) {
	const partials = [1, 1.5, 2.0];
	const partialGain = [1, 0.22, 0.08];
	for (let n = 0; n < notes.length; n++) {
		const offset = n * spacing;
		const frequency = notes[n];
		const start = Math.floor(offset * sampleRate);
		for (let i = start; i < buffer.length; i++) {
			const t = (i - start) / sampleRate;
			const attack = Math.min(1, t / 0.012);
			const decay = Math.exp(-t / 0.27);
			let sample = 0;
			for (let p = 0; p < partials.length; p++) {
				sample += Math.sin(
					Math.PI * 2 * frequency * partials[p] * t
					+ 0.19 * p
				) * partialGain[p];
			}
			buffer[i] += sample * attack * decay * amount;
		}
	}
}

function finalize(buffer, peak, fadeSeconds = 0.012) {
	let sourcePeak = 0;
	for (const value of buffer) {
		sourcePeak = Math.max(sourcePeak, Math.abs(value));
	}
	const gain = sourcePeak > 0 ? peak / sourcePeak : 1;
	const fadeSamples = Math.max(1, Math.floor(fadeSeconds * sampleRate));
	for (let i = 0; i < buffer.length; i++) {
		let value = buffer[i] * gain;
		const remaining = buffer.length - 1 - i;
		if (remaining < fadeSamples) {
			value *= remaining / fadeSamples;
		}
		buffer[i] = value;
	}
	return buffer;
}

function writeWav(fileName, samples) {
	const dataSize = samples.length * 2;
	const output = Buffer.alloc(44 + dataSize);
	output.write("RIFF", 0);
	output.writeUInt32LE(36 + dataSize, 4);
	output.write("WAVE", 8);
	output.write("fmt ", 12);
	output.writeUInt32LE(16, 16);
	output.writeUInt16LE(1, 20);
	output.writeUInt16LE(1, 22);
	output.writeUInt32LE(sampleRate, 24);
	output.writeUInt32LE(sampleRate * 2, 28);
	output.writeUInt16LE(2, 32);
	output.writeUInt16LE(16, 34);
	output.write("data", 36);
	output.writeUInt32LE(dataSize, 40);
	for (let i = 0; i < samples.length; i++) {
		const clamped = Math.max(-1, Math.min(1, samples[i]));
		output.writeInt16LE(Math.round(clamped * 32767), 44 + i * 2);
	}
	fs.writeFileSync(path.join(outputDir, fileName), output);
}

const softA = makeBuffer(0.13);
addSoftPaper(softA);
writeWav("soft_paper_01.wav", finalize(softA, 0.22));

const softB = makeBuffer(0.11);
addFeltTap(softB);
writeWav("soft_felt_02.wav", finalize(softB, 0.20));

const primaryA = makeBuffer(0.22);
addWarmWood(primaryA);
writeWav("primary_wood_01.wav", finalize(primaryA, 0.23));

const primaryB = makeBuffer(0.20);
addPaperPress(primaryB);
writeWav("primary_paper_02.wav", finalize(primaryB, 0.21));

const rewardA = makeBuffer(0.92);
addMusicBox(rewardA, [523.25, 783.99], 0.15);
writeWav("reward_musicbox_01.wav", finalize(rewardA, 0.16, 0.05));

const rewardB = makeBuffer(0.82);
addWarmChime(rewardB, [392.0, 523.25], 0.14);
writeWav("reward_warmchime_02.wav", finalize(rewardB, 0.15, 0.05));

console.log(outputDir);
