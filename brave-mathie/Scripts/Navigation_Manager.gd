extends Node


const scene_StarterRoom = preload("res://SpriteSheets/Scenes/StarterRoom/StarterRoom.tscn")
const scene_TopRoom = preload("res://SpriteSheets/Scenes/EnemyRoom/TopRoom.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"StarterRoom":
			scene_to_load = scene_StarterRoom
		"TopRoom":
			scene_to_load = scene_TopRoom
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed.call_deferred(scene_to_load)
		
func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
