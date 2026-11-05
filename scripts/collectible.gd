extends Area2D

signal collected(collectible: Node2D)

@export var texture: Texture2D

var player_in_range = false


func _ready() -> void:
	$Sprite2D.texture = texture


func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		collected.emit(self)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
