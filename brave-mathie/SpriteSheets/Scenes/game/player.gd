class_name Player
extends CharacterBody2D

var animSprite : AnimatedSprite2D

func _ready() -> void:
	animSprite = $AnimatedSprite2D
	
	

func _process(delta: float) -> void:
	velocity = Vector2()
	
	if Input.is_action_pressed("walk_front"):
		velocity.y += 1
	if Input.is_action_pressed("walk_back"):
		velocity.y -= 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	
	if velocity.length_squared() == 0:
		animSprite.play("front")
	elif velocity.x != 0:
		if velocity.x > 0:
			animSprite.play("walk_right")
		else:
			animSprite.play("walk_left")
	else:
		if velocity.y > 0:
			animSprite.play("walk_front")
		else:
			animSprite.play("walk_back")
	
	velocity = velocity.normalized()
	velocity *= 175 * scale.x
	move_and_slide()

	
	
