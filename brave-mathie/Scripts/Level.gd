extends Node2D


func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		await get_tree().process_frame
		_on_level_spawn(NavigationManager.spawn_door_tag)


func _on_level_spawn(_destination_tag: String) -> void:
	var door: Door = _find_door(get_tree().current_scene)

	if door == null:
		push_error("Could not find a door to spawn the player at")
		return

	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	door.grant_spawn_immunity(0.4)

	NavigationManager.spawn_door_tag = null


func _find_door(node: Node) -> Door:
	if node is Door:
		return node
	for child: Node in node.get_children():
		var found: Door = _find_door(child)
		if found != null:
			return found
	return null
