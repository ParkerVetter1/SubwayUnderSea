extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_button_pressed() -> void:
	get_tree().quit()