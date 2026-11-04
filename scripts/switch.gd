extends Area2D

var player_in_range = false
var is_activated = false
signal state_changed(is_activated: bool)


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		is_activated = not is_activated
		state_changed.emit(is_activated)
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
