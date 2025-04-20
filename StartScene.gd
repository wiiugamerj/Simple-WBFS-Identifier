extends Control


@onready var req := $HTTPRequest
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.2).timeout
	$TextureRect/StartScene.play("Fade")
	ProjectSettings.load_resource_pack("UpdateFile.pck")
	req.download_file = "UpdateFile.pck"
	req.request("https://github.com/wiiugamerj/SimpleWBFSIdentifier/releases/download/AutoUpdateFile/WBFSIdentifier.pck")
	print("Requesting file")

func _on_http_request_request_completed(result, response_code, headers, body):
	if result == OK: 
		await get_tree().create_timer(0.5).timeout
		$TextureRect/StartScene.play_backwards("Fade")
		await get_tree().create_timer(0.2).timeout
		ProjectSettings.load_resource_pack("UpdateFile.pck")
		get_tree().change_scene_to_file("res://GameList.tscn")
		print("App has been correctly updated")
	else:
		await get_tree().create_timer(1).timeout
		$TextureRect/StartScene.play_backwards("Fade")
		await get_tree().create_timer(0.2).timeout
		print("App hasn't been updated")
		ProjectSettings.load_resource_pack("UpdateFile.pck")
		get_tree().change_scene_to_file("res://GameList.tscn")

