@tool
extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var amplitude := 1
@export var frequence := 1

var t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	position.x = amplitude + sin(t * frequence * 2 * PI)
