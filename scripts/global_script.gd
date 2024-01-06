extends Node

var enemy_can_shoot
# DO NOT REMOVE BIGGIE_CHEESE.JPEG REQUIRED AS PLACEHOLDER
var core = preload("res://assets/sprites/core/biggie_cheese.jpeg")

func _input(event):
	if event.is_action_pressed("debug_console"):
		get_tree().change_scene_to_file("res://hud_menus/debug.tscn")
