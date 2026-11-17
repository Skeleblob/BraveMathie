extends CharacterBody2D


@export var speed: float = 100
var player_chase = false
var player = null

func _physics_process(delta: float):
	if player_chase and is_instance_valid(player):
		var direction := global_position.direction_to(player.global_position)
		position += (player.position - position)/speed
		
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
		
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
