
extends CharacterBody2D

@export var speed = 200.0
var facing_direction = "down"

func _physics_process(delta):
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	direction = direction.normalized()
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			facing_direction = "right" if direction.x > 0 else "left"
		else:
			facing_direction = "down" if direction.y > 0 else "up"
	
	if direction == Vector2.ZERO:
		$AnimatedSprite2D.play("idle_" + facing_direction)
	else:
		$AnimatedSprite2D.play("walk_" + facing_direction)
	
	velocity = direction * speed
	move_and_slide()
