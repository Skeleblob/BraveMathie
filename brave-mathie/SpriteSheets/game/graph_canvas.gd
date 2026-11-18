extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _draw():
	var points = PackedVector2Array()
	var a = 1
	var b = 0
	for x in range(0,400,50):
		var y = (a * x + b)
		points.append(Vector2(x,-y))
	draw_polyline(points, Color.RED, 3.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
