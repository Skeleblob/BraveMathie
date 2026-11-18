class_name Player
extends CharacterBody2D

const PLAYER_ATTACK = preload("res://SpriteSheets/game/player_attack.tscn")
var animSprite : AnimatedSprite2D
var can_shoot = true
var attack_cooldown = 0.5

func _ready() -> void:
	animSprite = $AnimatedSprite2D
	
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(spawn_position: Vector2, _direction: String) -> void:
	global_position = spawn_position

func _process(_delta: float) -> void:
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
	
	if Input.is_action_just_pressed("shoot_up") or Input.is_action_just_pressed("shoot_down") or Input.is_action_just_pressed("shoot_left") or Input.is_action_just_pressed("shoot_right"):
		shoot()

func shoot():
	if not can_shoot:
		return

	can_shoot = false

	await get_tree().create_timer(0.08).timeout

	var direction = Input.get_vector(
		"shoot_left",
		"shoot_right",
		"shoot_up",
		"shoot_down"
	)

	if direction != Vector2.ZERO:
		var attack = PLAYER_ATTACK.instantiate()

		attack.direction = direction.normalized()
		attack.global_position = global_position
		attack.rotation = direction.angle() + deg_to_rad(180)

		get_tree().current_scene.add_child(attack)

	await get_tree().create_timer(attack_cooldown).timeout
	can_shoot = true
	
	
