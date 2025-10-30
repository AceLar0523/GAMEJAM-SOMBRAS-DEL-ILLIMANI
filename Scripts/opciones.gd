extends Control


# Called when the node enters the scene tree for the first time.


func _on_volumen_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Menu.tscn")


func _on_brillo_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Menu.tscn")


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Menu.tscn")
