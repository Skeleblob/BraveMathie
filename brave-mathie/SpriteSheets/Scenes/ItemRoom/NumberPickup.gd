extends Area2D

@export var number_value: int = 37

var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return

	if body is Player:
		collected = true
		DatabaseManager.collect_number(number_value, self)


func collection_finished(success: bool) -> void:
	if success:
		queue_free()
	else:
		collected = false
