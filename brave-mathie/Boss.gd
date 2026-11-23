extends CharacterBody2D

var speed: float = 100.0
var backup_speed: float = 100.0
var min_chase_distance: float = 190.0
var player_chase: bool = false
var player: Node2D = null
var shoot_cooldown: float = 0.0
var attack_animation_timer: float = 0.0
var attack_animation_duration: float = 1.0
@export var health: float

const BossEnemyAttackScene = preload("res://Scripts/attacks/BossAttack.tscn")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("Idle")
	

func _physics_process(_delta: float) -> void:
	if attack_animation_timer > 0.0:
		attack_animation_timer -= _delta
		
		if animated_sprite.animation != "Attacking":
			animated_sprite.play("Attacking")
	else:
		if animated_sprite.animation != "Idle":
			animated_sprite.play("Idle")
		
	
	if not player_chase or not is_instance_valid(player):
		return

	shoot_cooldown -= _delta
	if shoot_cooldown <= 0 and player != null:
		shoot()
		shoot_cooldown = 3

	var to_player: Vector2 = player.global_position - global_position
	var distance = to_player.length()
	if distance > min_chase_distance:
		global_position += to_player / speed
	elif distance > 0:
		global_position -= to_player / speed * (backup_speed / speed)


func shoot() -> void:
	if not is_instance_valid(player):
		return
		
	attack_animation_timer = attack_animation_duration
		
	if animated_sprite.animation != "Attacking":
		animated_sprite.play("Attacking")
	
		
	var projectile = BossEnemyAttackScene.instantiate()
	projectile.direction = (player.global_position - global_position).normalized()
	projectile.position = global_position
	get_tree().root.add_child(projectile)



func _on_detection_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return
	player = body
	player_chase = true
