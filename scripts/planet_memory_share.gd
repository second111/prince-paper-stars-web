extends Node


const DEFAULT_PORT := 47831
const MAX_SHARES := 12
const MAX_REQUEST_BYTES := 16384


var _server := TCPServer.new()
var _clients: Array[Dictionary] = []
var _shares: Dictionary = {}
var _share_order: Array[String] = []
var _port := DEFAULT_PORT
var _lan_ip := "127.0.0.1"
var _running := false
var _serial := 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_start_local_server()


func _exit_tree() -> void:
	stop()


func is_running() -> bool:
	return _running


func create_memory(
	planet_name: String,
	classification: String,
	narrative: String,
	action: String,
	echo: String
) -> String:
	_serial += 1
	var memory_id := "%d%s" % [
		int(Time.get_unix_time_from_system()),
		_base36(_serial),
	]
	_shares[memory_id] = {
		"planet_name": planet_name,
		"classification": classification,
		"narrative": narrative,
		"action": action,
		"echo": echo,
		"date": Time.get_date_string_from_system(false),
		"image": PackedByteArray(),
	}
	_share_order.append(memory_id)
	while _share_order.size() > MAX_SHARES:
		var removed := String(_share_order.pop_front())
		_shares.erase(removed)
	return memory_id


func attach_image(memory_id: String, image: Image) -> void:
	if image == null or image.is_empty() or not _shares.has(memory_id):
		return
	_shares[memory_id]["image"] = image.save_png_to_buffer()


func get_share_url(memory_id: String) -> String:
	return "http://%s:%d/m/%s" % [_lan_ip, _port, memory_id]


func stop() -> void:
	if _server != null and _server.is_listening():
		_server.stop()
	for state in _clients:
		var peer := state.get("peer") as StreamPeerTCP
		if peer != null:
			peer.disconnect_from_host()
	_clients.clear()
	_running = false


func _process(_delta: float) -> void:
	if not _running:
		return
	while _server.is_connection_available():
		var peer := _server.take_connection()
		if peer == null:
			continue
		peer.set_no_delay(true)
		_clients.append({
			"peer": peer,
			"buffer": PackedByteArray(),
			"started": Time.get_ticks_msec(),
		})

	var next_clients: Array[Dictionary] = []
	for state in _clients:
		var peer := state.get("peer") as StreamPeerTCP
		if peer == null:
			continue
		peer.poll()
		if peer.get_status() != StreamPeerTCP.STATUS_CONNECTED:
			continue
		var buffer: PackedByteArray = state.get("buffer", PackedByteArray())
		var available := peer.get_available_bytes()
		if available > 0:
			var read_size := mini(available, MAX_REQUEST_BYTES - buffer.size())
			if read_size > 0:
				var result := peer.get_partial_data(read_size)
				if int(result[0]) == OK:
					buffer.append_array(result[1] as PackedByteArray)
		if _header_end(buffer) >= 0:
			_handle_request(peer, buffer.get_string_from_utf8())
			continue
		var age := Time.get_ticks_msec() - int(state.get("started", 0))
		if buffer.size() >= MAX_REQUEST_BYTES or age > 4000:
			peer.disconnect_from_host()
			continue
		state["buffer"] = buffer
		next_clients.append(state)
	_clients = next_clients


func _start_local_server() -> void:
	_lan_ip = _preferred_lan_ip()
	for offset in 12:
		var candidate := DEFAULT_PORT + offset
		if _server.listen(candidate, "*") == OK:
			_port = candidate
			_running = true
			return
	_running = false
	push_warning("Planet memory share page could not start a local HTTP server.")


func _preferred_lan_ip() -> String:
	var chosen := "127.0.0.1"
	var best_rank := 0
	for address_value in IP.get_local_addresses():
		var address := String(address_value)
		if address.contains(":") or address.begins_with("169.254."):
			continue
		var rank := 0
		if address.begins_with("192.168."):
			rank = 4
		elif address.begins_with("10."):
			rank = 3
		elif address.begins_with("172."):
			var second := int(address.split(".")[1])
			if second >= 16 and second <= 31:
				rank = 2
		elif address.begins_with("127."):
			rank = 0
		else:
			rank = 1
		if rank > best_rank:
			best_rank = rank
			chosen = address
	return chosen


func _header_end(buffer: PackedByteArray) -> int:
	var marker := "\r\n\r\n".to_utf8_buffer()
	if buffer.size() < marker.size():
		return -1
	for index in buffer.size() - marker.size() + 1:
		var matches := true
		for marker_index in marker.size():
			if buffer[index + marker_index] != marker[marker_index]:
				matches = false
				break
		if matches:
			return index + marker.size()
	return -1


func _handle_request(peer: StreamPeerTCP, request_text: String) -> void:
	var first_line := request_text.get_slice("\r\n", 0)
	var parts := first_line.split(" ", false)
	if parts.size() < 2 or String(parts[0]) != "GET":
		_respond_text(peer, 405, "Method Not Allowed", "Method Not Allowed")
		return
	var path := String(parts[1]).get_slice("?", 0)
	if not path.begins_with("/m/"):
		_respond_text(peer, 404, "Not Found", "Not Found")
		return
	var memory_path := path.trim_prefix("/m/")
	if memory_path.ends_with(".png"):
		var image_id := memory_path.trim_suffix(".png")
		_respond_image(peer, image_id)
		return
	_respond_page(peer, memory_path)


func _respond_page(peer: StreamPeerTCP, memory_id: String) -> void:
	if not _shares.has(memory_id):
		_respond_text(peer, 404, "Not Found", "这张星球手记已经离开页面了。")
		return
	var memory: Dictionary = _shares[memory_id]
	var planet_name := _html_escape(String(memory.get("planet_name", "我的星球")))
	var classification := _html_escape(
		String(memory.get("classification", "星球手记"))
	)
	var narrative := _html_escape(String(memory.get("narrative", "")))
	var action := _html_escape(String(memory.get("action", "")))
	var echo := _html_escape(String(memory.get("echo", "")))
	var date_text := _html_escape(String(memory.get("date", "")))
	var image_url := "/m/%s.png" % memory_id
	var html := """<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>%s | 星球手记</title>
<style>
:root{color-scheme:dark;--ink:#432f23;--paper:#f2e6c8;--gold:#aa7d3d;--night:#10243d;--fog:#6f8396}
*{box-sizing:border-box}html,body{margin:0;min-height:100%%}
body{padding:28px 16px 44px;background:radial-gradient(circle at 18%% 12%%,#2d4560 0,#14283f 42%%,#081523 100%%);font-family:"Noto Serif SC","Songti SC",serif;color:var(--paper)}
.card{width:min(920px,100%%);margin:auto;padding:clamp(20px,4vw,42px);border:1px solid rgba(229,201,139,.48);border-radius:22px;background:linear-gradient(145deg,rgba(33,57,82,.96),rgba(18,35,55,.97));box-shadow:0 24px 70px rgba(0,0,0,.42)}
.eyebrow{color:#d7bd80;letter-spacing:.16em;font-size:13px}.title{font-size:clamp(34px,7vw,62px);margin:10px 0 4px;font-weight:500;color:#f4e7c9}
.class{color:#a9c995;font-size:clamp(18px,3.8vw,26px);font-weight:700;margin-bottom:22px}
.letter{display:block;width:100%%;height:auto;border-radius:10px;box-shadow:0 12px 34px rgba(0,0,0,.38)}
.copy{margin-top:26px;padding:24px clamp(18px,4vw,34px);background:var(--paper);color:var(--ink);border-radius:16px;box-shadow:inset 0 0 0 1px rgba(170,125,61,.4)}
.copy p{font-size:16px;line-height:1.9;margin:0 0 18px;font-weight:700}.copy p:last-child{margin-bottom:0}
.copy strong{display:block;color:#996c34;margin-bottom:5px}.date{margin-top:15px;color:#9fb0c2;font-size:13px;text-align:right}
</style>
</head>
<body><main class="card">
<div class="eyebrow">THE LITTLE PRINCE | PLANET MEMORY</div>
<h1 class="title">%s</h1>
<div class="class">%s</div>
<img class="letter" src="%s" alt="%s的星球纪念信">
<section class="copy">
<p>%s</p>
<p><strong>星球手记</strong>%s</p>
<p><strong>此刻的星球</strong>%s</p>
</section>
<div class="date">%s</div>
</main></body></html>""" % [
		planet_name,
		planet_name,
		classification,
		image_url,
		planet_name,
		narrative,
		action,
		echo,
		date_text,
	]
	_respond(peer, 200, "OK", "text/html; charset=utf-8", html.to_utf8_buffer())


func _respond_image(peer: StreamPeerTCP, memory_id: String) -> void:
	if not _shares.has(memory_id):
		_respond_text(peer, 404, "Not Found", "Not Found")
		return
	var image: PackedByteArray = _shares[memory_id].get(
		"image",
		PackedByteArray()
	)
	if image.is_empty():
		_respond_text(peer, 503, "Preparing", "星球手记正在装订，请稍后刷新。")
		return
	_respond(peer, 200, "OK", "image/png", image)


func _respond_text(
	peer: StreamPeerTCP,
	status: int,
	reason: String,
	message: String
) -> void:
	_respond(
		peer,
		status,
		reason,
		"text/plain; charset=utf-8",
		message.to_utf8_buffer()
	)


func _respond(
	peer: StreamPeerTCP,
	status: int,
	reason: String,
	content_type: String,
	body: PackedByteArray
) -> void:
	if peer == null:
		return
	var headers := (
		"HTTP/1.1 %d %s\r\n"
		+ "Content-Type: %s\r\n"
		+ "Content-Length: %d\r\n"
		+ "Cache-Control: no-store\r\n"
		+ "Connection: close\r\n\r\n"
	) % [status, reason, content_type, body.size()]
	peer.put_data(headers.to_utf8_buffer())
	peer.put_data(body)
	peer.disconnect_from_host()


func _html_escape(text_value: String) -> String:
	return (
		text_value
		.replace("&", "&amp;")
		.replace("<", "&lt;")
		.replace(">", "&gt;")
		.replace("\"", "&quot;")
	)


func _base36(value: int) -> String:
	const DIGITS := "0123456789abcdefghijklmnopqrstuvwxyz"
	if value <= 0:
		return "0"
	var result := ""
	var remaining := value
	while remaining > 0:
		result = DIGITS[remaining % 36] + result
		remaining /= 36
	return result
