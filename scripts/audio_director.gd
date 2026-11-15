extends Node

const MUSIC_TRACKS := {
	"main": "res://assets/audio/music/first_light_particles.wav",
	"player": "res://assets/audio/music/daydream.mp3",
}

const SFX_SOUNDS := {
	"ui_soft": "res://assets/audio/sfx/ui_soft.mp3",
	"ui_primary": "res://assets/audio/sfx/ui_primary.mp3",
	"dialogue_choice": "res://assets/audio/sfx/ui_soft.mp3",
	"memory_reward": "res://assets/audio/sfx/memory_reward.wav",
}

const SFX_TRIM_DB := {
	"ui_soft": -8.0,
	"ui_primary": -7.0,
	"dialogue_choice": -8.0,
}

const MUSIC_BUS := "Music"
const SFX_BUS := "SFX"
const DEFAULT_MUSIC_VOLUME_DB := -7.0
const DIALOGUE_DUCK_DB := -5.0
const DEFAULT_CROSSFADE_SECONDS := 1.4
const SFX_VOICE_COUNT := 8

var _music_players: Array[AudioStreamPlayer] = []
var _music_resources: Dictionary = {}
var _sfx_players: Array[AudioStreamPlayer] = []
var _sfx_resources: Dictionary = {}
var _next_sfx_voice := 0
var _active_music_index := 0
var _current_track_id := ""
var _music_transition: Tween
var _dialogue_ducked := false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_ensure_audio_bus(MUSIC_BUS)
	_ensure_audio_bus(SFX_BUS)
	_build_music_players()
	_build_sfx_players()
	_load_music_resources()
	_load_sfx_resources()
	_apply_music_bus_volume()


func play_music(track_id: String, fade_seconds := DEFAULT_CROSSFADE_SECONDS) -> void:
	if track_id == _current_track_id:
		return
	var stream := _music_resources.get(track_id) as AudioStream
	if stream == null:
		push_warning("AudioDirector: music track is unavailable: " + track_id)
		return
	if _music_players.is_empty():
		_build_music_players()
	if _music_players.is_empty():
		return

	if _music_transition != null and _music_transition.is_valid():
		_music_transition.kill()

	var previous_index := _active_music_index
	_active_music_index = 1 - _active_music_index
	var previous := _music_players[previous_index]
	var next := _music_players[_active_music_index]

	next.stop()
	next.stream = stream
	next.volume_db = -45.0
	next.play()
	_current_track_id = track_id

	if fade_seconds <= 0.0:
		previous.stop()
		next.volume_db = 0.0
		return

	_music_transition = create_tween().set_parallel(true)
	_music_transition.tween_property(
		previous,
		"volume_db",
		-45.0,
		fade_seconds
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_music_transition.tween_property(
		next,
		"volume_db",
		0.0,
		fade_seconds
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_music_transition.chain().tween_callback(
		func() -> void:
			if previous_index != _active_music_index:
				previous.stop()
	)


func set_dialogue_duck(enabled: bool) -> void:
	if _dialogue_ducked == enabled:
		return
	_dialogue_ducked = enabled
	var music_index := AudioServer.get_bus_index(MUSIC_BUS)
	if music_index < 0:
		return
	var target_db := (
		DEFAULT_MUSIC_VOLUME_DB + DIALOGUE_DUCK_DB
		if enabled
		else DEFAULT_MUSIC_VOLUME_DB
	)
	var tween := create_tween()
	tween.tween_method(
		func(value: float) -> void:
			AudioServer.set_bus_volume_db(music_index, value),
		AudioServer.get_bus_volume_db(music_index),
		target_db,
		0.24
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func is_music_playing() -> bool:
	return (
		not _music_players.is_empty()
		and _music_players[_active_music_index].playing
	)


func play_sfx(
	sound_id: String,
	volume_db := 0.0,
	pitch_scale := 1.0
) -> void:
	var stream := _sfx_resources.get(sound_id) as AudioStream
	if stream == null:
		return
	if _sfx_players.is_empty():
		_build_sfx_players()
	if _sfx_players.is_empty():
		return
	var player := _sfx_players[_next_sfx_voice]
	_next_sfx_voice = (_next_sfx_voice + 1) % _sfx_players.size()
	player.stop()
	player.stream = stream
	player.volume_db = volume_db + float(SFX_TRIM_DB.get(sound_id, 0.0))
	player.pitch_scale = pitch_scale
	player.play()


func _build_music_players() -> void:
	_music_players.clear()
	for index in 2:
		var player := AudioStreamPlayer.new()
		player.name = "MusicPlayer%d" % (index + 1)
		player.bus = MUSIC_BUS
		player.volume_db = -45.0
		add_child(player)
		_music_players.append(player)


func _build_sfx_players() -> void:
	_sfx_players.clear()
	for index in SFX_VOICE_COUNT:
		var player := AudioStreamPlayer.new()
		player.name = "SfxPlayer%d" % (index + 1)
		player.bus = SFX_BUS
		add_child(player)
		_sfx_players.append(player)


func _load_music_resources() -> void:
	for track_id in MUSIC_TRACKS:
		var path := String(MUSIC_TRACKS[track_id])
		if not ResourceLoader.exists(path):
			push_warning("AudioDirector: missing music resource: " + path)
			continue
		var stream := load(path) as AudioStream
		if stream == null:
			push_warning("AudioDirector: failed to load music resource: " + path)
			continue
		_enable_native_loop(stream)
		_music_resources[track_id] = stream


func _load_sfx_resources() -> void:
	for sound_id in SFX_SOUNDS:
		var path := String(SFX_SOUNDS[sound_id])
		if not ResourceLoader.exists(path):
			push_warning("AudioDirector: missing sound effect: " + path)
			continue
		var stream := load(path) as AudioStream
		if stream == null:
			push_warning("AudioDirector: failed to load sound effect: " + path)
			continue
		_sfx_resources[sound_id] = stream


func _enable_native_loop(stream: AudioStream) -> void:
	if stream is AudioStreamWAV:
		var wav := stream as AudioStreamWAV
		wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
		wav.loop_begin = 0
		wav.loop_end = int(round(wav.get_length() * float(wav.mix_rate)))
	elif stream is AudioStreamMP3:
		(stream as AudioStreamMP3).loop = true
	elif stream is AudioStreamOggVorbis:
		(stream as AudioStreamOggVorbis).loop = true


func _ensure_audio_bus(bus_name: String) -> void:
	if AudioServer.get_bus_index(bus_name) >= 0:
		return
	AudioServer.add_bus()
	var index := AudioServer.bus_count - 1
	AudioServer.set_bus_name(index, bus_name)
	AudioServer.set_bus_send(index, "Master")


func _apply_music_bus_volume() -> void:
	var music_index := AudioServer.get_bus_index(MUSIC_BUS)
	if music_index >= 0:
		AudioServer.set_bus_volume_db(music_index, DEFAULT_MUSIC_VOLUME_DB)
