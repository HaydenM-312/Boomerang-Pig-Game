extends CharacterBody2D

@export var detection_range : float
@export var follow_range : float
func _process(delta):
	move_and_slide()
