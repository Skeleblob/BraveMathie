extends Node2D


func _ready() -> void:
	
	if NavigationManager.spawn_door_tag == null:
		return

	
	call_deferred("_spawn_player_at_door")


func _spawn_player_at_door() -> void:
	var destination_tag: String = NavigationManager.spawn_door_tag

	var door: Door = _find_door(
		get_tree().current_scene,
		destination_tag
	)

	if door == null:
		push_error(
			"Could not find door with tag: " + destination_tag
		)
		return

	NavigationManager.trigger_player_spawn(
		door.spawn.global_position,
		door.spawn_direction
	)

	door.grant_spawn_immunity(0.4)

	
	NavigationManager.spawn_door_tag = null


func _find_door(node: Node, target_tag: String) -> Door:
	if node is Door and node.door_tag == target_tag:
		return node

	for child: Node in node.get_children():
		var found: Door = _find_door(child, target_tag)

		if found != null:
			return found

	return null
