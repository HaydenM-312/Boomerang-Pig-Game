extends CanvasLayer
signal update_stamina(value)

func _on_gui_update_stamina(value):
	update_stamina.emit(value)
