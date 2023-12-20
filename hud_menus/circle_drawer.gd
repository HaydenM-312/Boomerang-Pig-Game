extends Node2D
var rad = 50
var cen = Vector2(-30,50)
var col = Color(0,0,255)


func _draw():
	draw_circle(cen,rad,col)

func _on_ui_update_stamina(value):
	rad = value
	queue_redraw()
