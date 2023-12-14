extends CanvasLayer
signal update_stamina(value)

func update_health(health):
	$MarginContainer/TextureProgressBar.value = health

func _on_player_health_changed(value):
	update_health(value)

func _on_player_stamina_changed(value):
	update_stamina.emit(value)
