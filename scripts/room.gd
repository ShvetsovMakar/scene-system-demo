extends Node2D

@onready var interaction_label = $CanvasLayer/InteractionLabel
@onready var switch = $Switch

@export var collectible_scene: PackedScene
@export var collectible_texture: Texture2D

var can_spawn_collectible = true
var spawned_collectible: Node2D

func _ready() -> void:
	switch.body_entered.connect(_on_switch_body_entered)
	switch.body_exited.connect(_on_switch_body_exited)
	
	switch.state_changed.connect(_on_switch_state_changed)
	$Building/Door/AnimatedSprite2D.animation_finished.connect(_on_door_animation_finished)
	
	for child in $Collectibles.get_children():
		child.collected.connect(_on_collectible_collected)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_spawn_collectible:
		can_spawn_collectible = false
		
		spawned_collectible = collectible_scene.instantiate()
		spawned_collectible.texture = collectible_texture
		spawned_collectible.scale = Vector2(10, 10)
		$Collectibles.add_child(spawned_collectible)
		spawned_collectible.position = Vector2(300, 200)
		
		spawned_collectible.collected.connect(_on_collectible_collected)
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
		
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
	if collectible == spawned_collectible:
		can_spawn_collectible = true
		spawned_collectible = null
		
	collectible.queue_free()
