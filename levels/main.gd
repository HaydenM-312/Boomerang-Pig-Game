extends Node

var player_present = false
func _physics_process(delta):
	pass
	if get_node_or_null('Enemy') and player_present:
		$Enemy.look_at($Player.global_position)
	if get_node_or_null('Enemy2') and player_present:
		$Enemy2.look_at($Player.global_position)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		NewScript.enemy_can_shoot = true
		player_present = true
		if get_node_or_null('Enemy'):
			$Enemy.show()
		if get_node_or_null('Enemy2'):
			$Enemy2.show()

func _process(delta):
	pass
	#if player_present == false:
		#for enemy_projectile in get_tree().get_nodes_in_group("enemy_projectile"):
			#enemy_projectile.queue_free()

func _on_area_2d_2_body_entered(body):
	if body.is_in_group('player'):
		player_present = false
		NewScript.enemy_can_shoot = false

