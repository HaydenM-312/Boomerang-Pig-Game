extends Control


func _on_yes_button_pressed():
	print("Exiting game. Have a great day! :)")
	get_tree().quit()


func _on_no_button_pressed():
	hide()


func _on_pause_menu_quit():
	show()
