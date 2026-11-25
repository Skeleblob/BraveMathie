extends Node

var inventory: Array[int] = [5, 12, 37]
signal inventory_updated

func collect_number(number: int) -> void:

	if not AuthManager.is_logged_in:
		print("Waiting for login...")
		await AuthManager.login_succeeded

	print("Collecting number: ", number)

	var task = Supabase.database.Rpc(
		"collect_number",
		{"p_number": number}
	)

	task.completed.connect(_on_collect_completed.bind(number))


func _on_collect_completed(task: BaseTask, number: int) -> void:

	if task.error != null:
		print("DATABASE ERROR: ", task.error)
		return

	if task.data == true:
		if not inventory.has(number):
			inventory.append(number)

		print("NUMBER COLLECTED: ", number)
		print("CURRENT INVENTORY: ", inventory)

		inventory_updated.emit()
	else:
		print("Number already collected!")


func get_inventory() -> void:

	if not AuthManager.is_logged_in:
		print("Waiting for login...")
		await AuthManager.login_succeeded

	var query = SupabaseQuery.new()
	query.from("inventory").select()

	var task = Supabase.database.query(query)
	task.completed.connect(_on_inventory_received)


func _on_inventory_received(task: BaseTask) -> void:

	if task.error != null:
		print("INVENTORY ERROR: ", task.error)
		return

	inventory.clear()

	for row in task.data:
		inventory.append(int(row["number"]))

	print("PLAYER INVENTORY: ", inventory)

	inventory_updated.emit()
	print(DatabaseManager.inventory)
