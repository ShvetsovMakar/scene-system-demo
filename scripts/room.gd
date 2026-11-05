extends Node2D

@onready var interaction_label = $CanvasLayer/InteractionLabel
@onready var switch = $Switch

func _ready() -> void:
	switch.body_entered.connect(_on_switch_body_entered)
	switch.body_exited.connect(_on_switch_body_exited)
	
	switch.state_changed.connect(_on_switch_state_changed)
	$Building/Door/AnimatedSprite2D.animation_finished.connect(_on_door_animation_finished)
	
	for child in $Collectibles.get_children():
		child.collected.connect(_on_collectible_collected)


func _process(delta: float) -> void:
	pass
	
func _on_switch_body_entered(body: Node2D) -> void:
	if body == $Player:
		interaction_label.visible = true
		interaction_label.text = switch.interaction_data.interaction_text

func _on_switch_body_exited(body: Node2D) -> void:
	if body == $Player:
		interaction_label.visible = false
		interaction_label.text = ""


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
	
	
func _on_collectible_collected(collectible: Node2D) -> void:
	print(collectible)
	collectible.queue_free()
