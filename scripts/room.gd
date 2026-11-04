extends Node2D



func _ready() -> void:
	$Switch.state_changed.connect(_on_switch_state_changed)
	$Door/AnimatedSprite2D.animation_finished.connect(_on_door_animation_finished)


func _process(delta: float) -> void:
	pass

func _on_switch_state_changed(is_activated: bool) -> void:
	if $Door.is_animating:
		return
		
	$Door.is_animating = true
		
	if is_activated:
		$Door/AnimatedSprite2D.play("open")
	else:
		$Door/AnimatedSprite2D.play("close")
		
		
func _on_door_animation_finished() -> void:
	$Door/CollisionShape2D.set_deferred("disabled", $Switch.is_activated)
	$Door.is_animating = false
