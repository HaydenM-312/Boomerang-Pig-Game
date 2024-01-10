extends CanvasLayer
signal unpause
signal settings
signal quit

func _on_resume_button_pressed():
	unpause.emit()

func _on_settings_button_pressed():
	pass

func _on_exit_button_pressed():
	quit.emit()
