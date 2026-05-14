@tool
extends CSGBox3D

@export var amplitude := 1.0
@export var frequence := 1.0

var t := 0.0
var start_z := 0.0
var initialized := false

func _process(delta: float) -> void:

	# Initialisation UNE seule fois
	if not initialized:
		start_z = position.z
		initialized = true

	t += delta

	position.z = start_z + sin(t * frequence * 2.0 * PI) * amplitude
