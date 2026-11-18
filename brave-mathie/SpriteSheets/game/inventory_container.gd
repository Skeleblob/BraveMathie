extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Graph.position = Vector2(575,75)	
	$ItemGridContainer.position = Vector2(50,50)
