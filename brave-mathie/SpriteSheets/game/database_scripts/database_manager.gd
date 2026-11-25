extends Node

var inventory: Array[int] = []
var active_numbers: Dictionary = {}

signal inventory_updated
signal active_numbers_updated	
signal login_succeeded

func load_player_data() -> void:
	if not AuthManager.is_logged_in:
		await AuthManager.login_succeeded

	get_inventory()
	get_active_numbers()


# INVENTORY ------------------------------------------------

func get_inventory() -> void:
	var query = SupabaseQuery.new()
	query.from("inventory").select()

	var task = Supabase.database.query(query)
	task.completed.connect(_on_inventory_received)


func _on_inventory_received(task: BaseTask) -> void:
	if task.error != null:
		print("INVENTORY ERROR: ", task.error)
		return

	inventory.clear()

	for item in task.data:
		inventory.append(int(item["number"]))

	print("PLAYER INVENTORY: ", inventory)
	inventory_updated.emit()
	
func collect_number(number: int) -> void:
	if not AuthManager.is_logged_in:
		print("Waiting for login...")
		return

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


# ACTIVE NUMBERS -------------------------------------------

func get_active_numbers() -> void:
	var query = SupabaseQuery.new()
	query.from("active_numbers").select()

	var task = Supabase.database.query(query)
	task.completed.connect(_on_active_numbers_received)


func _on_active_numbers_received(task: BaseTask) -> void:
	if task.error != null:
		print("ACTIVE NUMBERS ERROR: ", task.error)
		return

	active_numbers.clear()

	for item in task.data:
		var slot = int(item["slot"])
		var number = int(item["number"])

		active_numbers[slot] = number

	print("ACTIVE NUMBERS: ", active_numbers)
	active_numbers_updated.emit()
	
