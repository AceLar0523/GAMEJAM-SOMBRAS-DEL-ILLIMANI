extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/juego.tscn")
	
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Opciones.tscn")

func _on_exit_pressed() -> void:

	get_tree().quit()
