extends Area2D

signal enemy_dead

@export var health = 3
@export var shoot_cooldown = 2
@export var damage = 15
@export var bullet_scene : PackedScene
var can_shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	$GunCooldown.wait_time = shoot_cooldown
	$GunCooldown.start()

func _process(delta):
	can_shoot = NewScript.enemy_can_shoot

func take_damage(amount):
	$AnimationPlayer.play("flash")
	health -= amount
	if health <= 0:
		die()

func shoot():
	$GunCooldown.start()
	if can_shoot:
		print('enemy shooting')
		$GunCooldown.start()
		var b = bullet_scene.instantiate()
		get_tree().root.add_child(b)
		b.start($Muzzle.global_transform, damage)

func die():
	enemy_dead.emit()
	queue_free()

func _on_gun_cooldown_timeout():
	print('timeout')
	shoot()

