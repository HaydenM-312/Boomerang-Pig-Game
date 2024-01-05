extends Area2D

@export var speed = 1000
var damage

var velocity = Vector2.ZERO

func start(_transform, value):
	transform = _transform
	velocity = transform.x * speed
	damage = value
	
func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		return
	if body.is_in_group("player"):
		body.health -= damage
		pass
	queue_free()
