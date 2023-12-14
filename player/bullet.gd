extends Area2D

@export var speed = 800

var velocity = Vector2.ZERO

func _ready():
	$Timer.start()

func start(_transform):
	transform = _transform
	velocity = transform.x * speed
	
func _process(delta):
	$Sprite2D.rotation += 0.3
	$CollisionShape2D.rotation += 0.3
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.take_damage(1)
		queue_free()


func _on_timer_timeout():
	queue_free()
