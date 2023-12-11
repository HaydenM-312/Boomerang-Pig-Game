extends CharacterBody2D

var max_health := 10
var health := max_health

var speed := 1000.0

func _ready() -> void:
	pass
	
# The physics process runs 60 times a second, regardless of framerate
func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector(
		"walk_left", "walk_right",
		"walk_up", "walk_down")
	
	var target_velocity = input_vector.normalized() * speed;
	velocity = lerp(velocity, target_velocity, 0.6);
	
	move_and_slide()
