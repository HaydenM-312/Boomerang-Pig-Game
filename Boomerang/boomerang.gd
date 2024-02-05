extends Node2D
@export var damage : float = 10
enum {IDLE, FLY, STICK}
var acceleration: float = 1 * 60
@export var throw_speed: float = 25 * 60
@export var return_speed: float = 1.5 * 60
var parent
var can_return: bool = true
var state: int = IDLE 
var velocity: = Vector2.ZERO
var pos: = Vector2.ZERO
var speed:float

func _ready():
	parent = get_parent()
	idle_position()
	
func _physics_process(delta):
	match state:
		IDLE:
			idle()
		FLY:
			fly(delta)
		STICK:
			stick()

func idle():
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		throw()
		
		
func fly(delta:float):
	velocity += (get_target() - pos).normalized() * speed
	velocity = velocity.limit_length(throw_speed)
	pos += velocity*delta #variable for disconnecting from parent movement
	global_position = pos
	rotation_degrees += 360*delta*4
	if can_return && pos.distance_to(get_target()) < 100:
		state = STICK

func stick():
	#place for your solution
	global_position = global_position.lerp(get_target() + Vector2(20,0), 0.2)
	var dist = global_position.distance_to(get_target() + Vector2(20,0))
	if dist < 25:
		idle_position()

func throw():
	state = FLY
	can_return = false
	$Timer.start()
	velocity = (get_global_mouse_position() - global_position).normalized() * throw_speed
	speed = acceleration
	pos = global_position #variable for disconnecting from parent movement

func idle_position():
	state = IDLE
	global_position = get_target()

func get_target()->Vector2:
	return parent.global_position + Vector2(20,0)

func _on_timer_timeout():
	can_return = true
	speed = return_speed




func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("attackable"):
		body.get_child("/Health")._damage(damage)
		print(body.get_child("Health"))
