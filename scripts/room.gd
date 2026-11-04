extends Node2D



func _ready() -> void:
	$Switch.state_changed.connect(_on_switch_state_changed)
	$Building/Door/AnimatedSprite2D.animation_finished.connect(_on_door_animation_finished)


func _process(delta: float) -> void:
	pass

func _on_switch_state_changed(is_activated: bool) -> void:
	if $Building/Door.is_animating:
		return
		
	$Building/Door.is_animating = true
		
	if is_activated:
		$Building/Door/AnimatedSprite2D.play("open")
	else:
		$Building/Door/AnimatedSprite2D.play("close")
		
		
func _on_door_animation_finished() -> void:
	$Building/Door/CollisionShape2D.set_deferred("disabled", $Switch.is_activated)
	$Building/Door.is_animating = false
