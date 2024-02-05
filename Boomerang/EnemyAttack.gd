extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D
@export var move_speed : float = 100
var follow_range : float
var player : CharacterBody2D
var range : float = 40

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	follow_range = enemy.follow_range

func Exit():
	pass
	
func Update(delta : float):
	pass
	
func PhysicsUpdate(delta : float):
	var direction = player.position - enemy.position
	enemy.velocity = direction.normalized() * move_speed
	if(direction.length() > follow_range):
		Transitioned.emit(self, "idle")
