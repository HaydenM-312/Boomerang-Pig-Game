extends Node


func _input(event):# A list of valid commands and what to do if they are entered
	if event is InputEventKey:
		if event.key_label == KEY_ENTER:
			match $TextEdit.text:
				"load_level(lvl_test_01)":
					get_tree().change_scene_to_file("res://levels/level_1.tscn")
				"quit":
					get_tree().quit()
