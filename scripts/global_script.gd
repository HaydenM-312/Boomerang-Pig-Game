extends Node

var enemy_can_shoot

func _input(event):
	if event.is_action_pressed("debug_console"):
		get_tree().change_scene_to_file("res://hud_menus/debug.tscn")
