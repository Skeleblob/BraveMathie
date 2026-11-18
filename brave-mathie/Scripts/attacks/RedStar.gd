extends Area2D

class_name EnemyProjectile

@export var speed: float = 300.0
@export var damage: float = 10.0
var direction: Vector2 = Vector2.ZERO
var lifetime: float = 3.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func _physics_process(_delta: float) -> void:
	if direction != Vector2.ZERO:
		global_position += direction * speed * _delta


	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
