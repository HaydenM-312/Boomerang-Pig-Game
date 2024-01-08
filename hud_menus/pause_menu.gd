extends Control
signal unpause
signal settings
signal quit



func _on_resume_button_pressed():
	unpause.emit()


func _on_settings_button_pressed():
	settings.emit()


func _on_exit_button_pressed():
	# do confirm popup
	pass # Replace with function body.
