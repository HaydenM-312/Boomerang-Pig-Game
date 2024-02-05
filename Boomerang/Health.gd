extends Node2D

@export var max_health : float = 100
var health : float
func _ready():
	health = max_health
	print(health)

func _damage(damage : float):
	health-=damage
	print(health)
	if(health < 0):
		_death()
func _death():
	pass
