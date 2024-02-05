extends CharacterBody2D

var speed:float = 300.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = lerp(velocity, direction * speed, .8)
	move_and_slide()
