extends CanvasLayer

var updating_inventory := false

@onready var graph = $InventoryContainer/Graph/GraphCanvas
@onready var function_button = $InventoryContainer/ItemGridContainer/FunctionOptionButton

func _ready() -> void:

	DatabaseManager.inventory_updated.connect(_refresh_inventory)
	DatabaseManager.active_numbers_updated.connect(_refresh_inventory)

	$InventoryContainer.visible = not $InventoryContainer.visible

	# Set the selected function
	graph.functionType = str(function_button.text)
	GameData.functionType = str(function_button.text)

	_refresh_inventory()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		$InventoryContainer.visible = not $InventoryContainer.visible


func _on_function_option_button_item_selected(_index: int) -> void:
	graph.functionType = str(function_button.text)
	GameData.functionType = str(function_button.text)
	graph.queue_redraw()


func _on_a_value_option_button_item_selected(index: int) -> void:
	if updating_inventory or index == 0:
		return

	var button = $InventoryContainer/ItemGridContainer/aValueOptionButton
	var number = int(button.get_item_text(index))

	if DatabaseManager.active_numbers.get(1, -1) == number:
		return

	graph.a = number
	GameData.a = number
	graph.queue_redraw()

	DatabaseManager.replace_active_number(1, number)


func _on_b_value_option_button_item_selected(index: int) -> void:
	if updating_inventory or index == 0:
		return

	var button = $InventoryContainer/ItemGridContainer/bValueOptionButton
	var number = int(button.get_item_text(index))

	if DatabaseManager.active_numbers.get(2, -1) == number:
		return

	graph.b = number
	GameData.b = number
	graph.queue_redraw()

	DatabaseManager.replace_active_number(2, number)


func _on_c_value_option_button_item_selected(index: int) -> void:
	if updating_inventory or index == 0:
		return

	var button = $InventoryContainer/ItemGridContainer/cValueOptionButton
	var number = int(button.get_item_text(index))

	if DatabaseManager.active_numbers.get(3, -1) == number:
		return

	graph.c = number
	GameData.c = number
	graph.queue_redraw()

	DatabaseManager.replace_active_number(3, number)



func _refresh_inventory() -> void:
	updating_inventory = true

	var buttons = [
		$InventoryContainer/ItemGridContainer/aValueOptionButton,
		$InventoryContainer/ItemGridContainer/bValueOptionButton,
		$InventoryContainer/ItemGridContainer/cValueOptionButton
	]

	for slot in range(1, 4):
		var button = buttons[slot - 1]
		button.clear()

		# Show the equipped number as the selected item
		if DatabaseManager.active_numbers.has(slot):
			var active_number = DatabaseManager.active_numbers[slot]
			button.add_item(str(active_number))
			button.select(0)
		else:
			button.add_item("Select number")

		# Add all available inventory numbers
		for number in DatabaseManager.inventory:
			button.add_item(str(number))

	# Update graph and damage values
	if DatabaseManager.active_numbers.has(1):
		graph.a = DatabaseManager.active_numbers[1]
		GameData.a = graph.a

	if DatabaseManager.active_numbers.has(2):
		graph.b = DatabaseManager.active_numbers[2]
		GameData.b = graph.b

	if DatabaseManager.active_numbers.has(3):
		graph.c = DatabaseManager.active_numbers[3]
		GameData.c = graph.c

	updating_inventory = false
	graph.queue_redraw()
