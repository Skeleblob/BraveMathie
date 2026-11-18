extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _draw():
	var grid_size = 50
	var width = 350
	var height = 350
	# Draw vertical and horizontal lines
	for x in range(0, width + 1, grid_size):
		draw_line(Vector2(x, 0), Vector2(x, height), Color.BLACK)
		draw_line(Vector2(0, x), Vector2(width, x), Color.BLACK)
	# Draw x- and y-axis
	draw_line(Vector2(100,0),Vector2(100,350), Color.BLACK, 4)
	draw_line(Vector2(0,250),Vector2(350,250), Color.BLACK, 4)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
