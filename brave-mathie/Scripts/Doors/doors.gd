extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Spawn

# The player can spawn overlapping the door it arrived at (its collision shape
# sits below the origin), so ignore triggers for a moment to avoid bouncing
# straight back to the room we just came from.
var _immune_until_ms: int = 0


func _on_body_entered(body: Node2D) -> void:
	if not (body is Player):
		return
	if Time.get_ticks_msec() < _immune_until_ms:
		return
	NavigationManager.go_to_level(destination_level_tag, destination_door_tag)


func grant_spawn_immunity(seconds: float) -> void:
	_immune_until_ms = Time.get_ticks_msec() + int(seconds * 1000.0)
