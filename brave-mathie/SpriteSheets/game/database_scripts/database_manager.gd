extends Node

func collect_number(number: int) -> void:
	print("Collecting number: ", number)

	var task = Supabase.database.Rpc(
		"collect_number",
		{"p_number": number}
	)

	task.completed.connect(_on_collect_completed)


func _on_collect_completed(task: BaseTask) -> void:
	if task.error != null:
		print("DATABASE ERROR: ", task.error)
	else:
		print("DATABASE SUCCESS!")
		print("Response: ", task.data)
