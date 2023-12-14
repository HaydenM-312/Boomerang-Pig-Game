extends Area2D

@export var timeline : DialogicTimeline
@export var next_label := ""
@export var indicator_color := Color.SANDY_BROWN
@export var character :DialogicCharacter = null

var _player :CharacterBody2D = null

var counter := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body:PhysicsBody2D) -> void:
	if body is CharacterBody2D:
		var indicator := Sprite2D.new()
		indicator.name = "InteractionIndicator"
		indicator.texture = preload("res://assets/sprites/ui/interaction.png")
		indicator.modulate = indicator_color
		indicator.scale = Vector2(50,50)/indicator.texture.get_size()
		add_child(indicator)
		indicator.position = Vector2(0,-100)

		_player = body
		
func _on_body_exited(body:PhysicsBody2D) -> void:
	if body is CharacterBody2D:
		if has_node('InteractionIndicator'):
			get_node('InteractionIndicator').queue_free()
			
func _input(event: InputEvent):
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		if has_node("InteractionIndicator"):
			Dialogic.start("hotdogman.dtl")
			get_viewport().set_input_as_handled()

