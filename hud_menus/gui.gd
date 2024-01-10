extends CanvasLayer
# Cant directly root signals in instantated GUI so this will foward the signals
signal stamina_update(value)
#signal unpause
signal settings
signal exit
var paused = false
func _on_player_health_changed(health):
	$HUD/MarginContainer/TextureProgressBar.value = health

func _on_player_stamina_changed(value):
	stamina_update.emit(value)

func _input(event):
	if event.is_action_pressed('pause'):
		if not paused:
			pause()
		else:
			unpause()
	

func pause():
	paused = true
	if paused:
		get_tree().paused = true
		$PauseMenu.show()

func unpause():
	paused = false
	get_tree().paused = false
	$PauseMenu.hide()


func _on_pause_menu_unpause():
	unpause()
