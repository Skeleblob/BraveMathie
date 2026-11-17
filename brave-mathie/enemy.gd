extends CharacterBody2D

var speed: float = 100.0
var backup_speed: float = 100.0
var min_chase_distance: float = 200.0
var player_chase: bool = false
var player: Node2D = null
var shoot_cooldown: float = 0.0


const EnemyAttackScene = preload("res://Scripts/attacks/enemyattacks.tscn")

func _physics_process(_delta: float) -> void:
	if not player_chase or not is_instance_valid(player):
		return

	shoot_cooldown -= _delta
	if shoot_cooldown <= 0 and player != null:
		shoot()
		shoot_cooldown = 1.5

	var to_player: Vector2 = player.global_position - global_position
	var distance = to_player.length()
	if distance > min_chase_distance:
		global_position += to_player / speed
	elif distance > 0:
		global_position -= to_player / speed * (backup_speed / speed)


func shoot() -> void:
	var projectile = EnemyAttackScene.instantiate()
	projectile.direction = (player.global_position - global_position).normalized()
	projectile.position = global_position
	get_tree().root.add_child(projectile)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return
	player = body
	player_chase = true
