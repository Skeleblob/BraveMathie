extends Node

signal inventory_updated


func collect_number(number: int) -> void:
	var arguments = {
		"p_number": number
	}

	Supabase.database.Rpc("collect_number", arguments)


func replace_number(slot: int, new_number: int) -> void:
	var arguments = {
		"p_slot": slot,
		"p_new_number": new_number
	}

	Supabase.database.Rpc("replace_active_number", arguments)
