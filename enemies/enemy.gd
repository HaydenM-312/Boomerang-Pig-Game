extends Area2D

signal enemy_dead

@export var health = 3
@export var shoot_cooldown = 2
@export var bullet_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$GunCooldown.wait_time = shoot_cooldown

func take_damage(amount):
	$AnimationPlayer.play("flash")
	health -= amount
	if health <= 0:
		die()

func shoot():
	$GunCooldown.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start($Muzzle.global_transform)

func die():
	enemy_dead.emit()
	queue_free()

func _on_gun_cooldown_timeout():
	shoot()

