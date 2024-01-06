extends CharacterBody2D

signal stamina_changed(value)
signal health_changed
signal player_dead

@export var max_health = 100
@export var speed = 400
@export var max_stamina = 50
@export var stamina_regen = 0.5
@export var dash_multiplier = 6
@export var bullet_scene : PackedScene

var invincible = false
var can_dash = true
var health = 0: set = set_health
var stamina = 50: set = set_stamina
var can_move = true
var can_shoot = true
var default_speed = null
enum{ALIVE, DEAD, DASHING}

func _ready():
	stamina = max_stamina
	default_speed = speed
	health = max_health


func change_state(new_state):
	match new_state:
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false)
			can_move = true
			can_shoot = true
			speed = default_speed
		DEAD: 
			$CollisionShape2D.set_deferred("disabled", true)
			can_move = false
			can_shoot = false
		DASHING:
			$CollisionShape2D.set_deferred("disabled", false)
			can_move = true
			can_shoot = true
			speed *= dash_multiplier


func _input(event):# Handles player input
	if event.is_action_pressed("dash"):
		dash()
	if event.is_action_pressed("shoot"):
		shoot()
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if can_move:
		velocity = input_direction * speed

func dash():#dashes and gives you I-frames
	if stamina >= 25 and can_dash:
		if velocity != Vector2(0,0):
			stamina -= 25
			change_state(DASHING)
			$DashTimer.start()
			$DashIframes.start()
			invincible = true
			can_dash = false

func _process(delta):# Regens stamina
	stamina += stamina_regen

func _physics_process(delta):# Handles physics calculations
	move_and_slide()
	if can_move:
		look_at(get_global_mouse_position())

func shoot(): # Lets you shoot and deletes any present boomerangs
	if can_shoot == false:
		return
	var boomerangs_present = get_tree().get_nodes_in_group("player_projectile").size();
	if boomerangs_present >= 1:#projectile detection
		for player_projectile in get_tree().get_nodes_in_group("player_projectile"):
			player_projectile.queue_free()
	can_shoot = false
	$Sprite2D2.hide()
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($Muzzle.global_transform)


func set_health(value):# Checks if health is more than max health and sets it accordingly
	# during I-frames you will not lose health
	if value < health and invincible:
		return
	value = min(value, max_health)
	health = value
	health_changed.emit(health)
	if health <= 0:
		die()


func _on_dash_timer_timeout():
	if can_move:
		change_state(ALIVE)
	$DashCooldown.start()


func set_stamina(value):# Same general logic as set health but for stamina
	value = min(value,max_stamina)
	stamina = value
	stamina_changed.emit(stamina)


func die():
	change_state(DEAD)


func _on_gun_cooldown_timeout():
	$Sprite2D2.show()
	can_shoot = true


func _on_dash_cooldown_timeout():
	can_dash = true


func _on_dash_iframes_timeout():
	invincible = false
