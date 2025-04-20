extends Control


var game_count = 0

var folder = "Placeholder, user should enter a folder path"

func _ready():
	$StartAnimation/AnimationPlayer.play("Start")
	$"Game count".text = "Drag your USB's WBFS folder path (for ex. D:/wbfs)"
	check_files()

func check_files():
	var dir = DirAccess.open(folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".wbfs") and not dir.current_is_dir():
				var game_code = file_name.replace(".wbfs", "")
				var game_name = GameCodes.game_codes.get(game_code, "Juego desconocido")
#GameCodes.game_codes is an AutoLoad for game_codes.gd which is GameTDB's Wii database
				var new_button = $SmoothScrollContainer/VBoxContainer/Button.duplicate()
				new_button.visible = true

				var label = new_button.get_node("Label")
				label.text = "%s - %s" % [game_code, game_name]
				$UpdateListAnimation/UpdateListAnimator.play("UpdateListAnimation")
				$SmoothScrollContainer/VBoxContainer.add_child(new_button)
				game_count += 1
				$"Game count".text = str(game_count)+" games detected"
			file_name = dir.get_next()
			$UpdateListAnimation/UpdateListAnimator.play_backwards("UpdateListAnimation")


func _on_wgj_black_pressed():
	$Window.visible = true

func _on_window_close_requested():
	$Window.visible = false


func _on_line_edit_text_changed(new_text):
	folder = new_text
	game_count = 0
	var children = $SmoothScrollContainer/VBoxContainer.get_children()

	for i in range(1, children.size()):
		children[i].queue_free()
	$"Game count".text = "No games detected, choose a proper path"
	$SmoothScrollContainer/VBoxContainer/Button.visible = false
	check_files()


