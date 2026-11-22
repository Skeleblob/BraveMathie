extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InventoryContainer.visible = not $InventoryContainer.visible
	$InventoryContainer/Graph/GraphCanvas.functionType = str($InventoryContainer/ItemGridContainer/FunctionOptionButton.text)
	$InventoryContainer/Graph/GraphCanvas.a = $InventoryContainer/ItemGridContainer/aValueOptionButton.text
	$InventoryContainer/Graph/GraphCanvas.b = $InventoryContainer/ItemGridContainer/bValueOptionButton.text
	$InventoryContainer/Graph/GraphCanvas.c = $InventoryContainer/ItemGridContainer/cValueOptionButton.text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
			$InventoryContainer.visible = not $InventoryContainer.visible
	

func _on_function_option_button_item_selected(index: int) -> void:
	$InventoryContainer/Graph/GraphCanvas.functionType = str($InventoryContainer/ItemGridContainer/FunctionOptionButton.text)


func _on_a_value_option_button_item_selected(index: int) -> void:
	$InventoryContainer/Graph/GraphCanvas.a = $InventoryContainer/ItemGridContainer/aValueOptionButton.text


func _on_b_value_option_button_item_selected(index: int) -> void:
	$InventoryContainer/Graph/GraphCanvas.b = $InventoryContainer/ItemGridContainer/bValueOptionButton.text

func _on_c_value_option_button_item_selected(index: int) -> void:
	$InventoryContainer/Graph/GraphCanvas.c = $InventoryContainer/ItemGridContainer/cValueOptionButton.text
