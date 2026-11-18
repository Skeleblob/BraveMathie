class_name Attack
extends Area2D

@export var speed: float = 600.0
@export var hit_damage: float = 10.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered (body: Node2D) -> void: 
	if body.is_in_group("Player"):
		return
	if body.has_method("take_damage"):
		body.take_damage(hit_damage)
	queue_free()
	
