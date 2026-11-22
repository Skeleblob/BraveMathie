extends Node2D
var a: int = 1
var b: int = 0
var c: int = 0
var functionType = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _draw():
	var points = PackedVector2Array()
	match functionType:
		"ax+b":
			for x in range(0,350,50):
				var y = (a * x + b*50)
				points.append(Vector2(x,-y))
		"ax^2+bx+c":
			for x in range(0,400,50):
				var y = (a * pow(x,2) + (b*50) * x + c*50)
				points.append(Vector2(x,-y/150))
	draw_polyline(points, Color.RED, 3.0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
