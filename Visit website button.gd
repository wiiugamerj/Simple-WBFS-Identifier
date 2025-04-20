extends TextureButton




func _on_mouse_entered():
	$Hover.play("Hover")


func _on_mouse_exited():
	$Hover.play_backwards("Hover")


func _on_button_down():
	$Pressed.play("Pressed")


func _on_button_up():
	$Pressed.play_backwards("Pressed")


func _on_pressed():
	OS.shell_open("https://github.com/wiiugamerj/Simple-WBFS-Identifier")
