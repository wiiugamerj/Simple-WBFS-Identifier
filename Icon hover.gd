extends TextureButton




func _on_mouse_entered():
	$Hover.play("Hover")


func _on_mouse_exited():
	$Hover.play_backwards("Hover")
