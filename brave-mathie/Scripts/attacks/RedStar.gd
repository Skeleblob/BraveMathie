extends Area2D

class_name EnemyProjectile

@export var speed: float = 300.0
@export var damage: float = 2.0
var direction: Vector2 = Vector2.ZERO
var lifetime: float = 3.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	await get_tree().create_timer(lifetime).timeout
	if is_inside_tree():
		queue_free()

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * _delta


func _on_area_entered(area: Area2D) -> void:
	var player := area.get_parent()
	
	if not player.is_in_group("player"):
		return
		
	if player.has_method("take_damage"):
		player.take_damage(damage)
		queue_free()
