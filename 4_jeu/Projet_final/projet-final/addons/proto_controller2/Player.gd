# Pour la téléportation : voir tuto "Godot Quick Tip - Teleporting" de MThelen
extends CharacterBody3D

# réglages
const SPEED := 5.0
const JUMP_VELOCITY := 4.5
const MOUSE_SENSIBILITY := 0.002

# gravité
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# ...
@onready var pivot_camera = $PivotCamera
@onready var camera = $PivotCamera/Camera3D

var rotation_x := 0.0 # rotation camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # capture la souris dans la fenêtre
	
	$CanvasLayer/FadeAnimationPlayer.play("FadeIn")





	
func _unhandled_input(event):
	if event is InputEventMouseMotion: # mouvement souris
		rotate_y(-event.relative.x * MOUSE_SENSIBILITY)
		
		rotation_x -= event.relative.y * MOUSE_SENSIBILITY
		rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
		
		pivot_camera.rotation.x = rotation_x
	
	if event.is_action_pressed("ui_cancel"): # Echap = libérer la souris
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
 
func _physics_process(delta):

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")

	var direction = Vector3.ZERO

	if input_dir != Vector2.ZERO:

		input_dir = input_dir.normalized()

		var forward = -transform.basis.z
		var right = transform.basis.x

		direction = (forward * input_dir.y + right * input_dir.x).normalized()

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	else:

		velocity.x = 0
		velocity.z = 0

	# téléportation dans "transition_histoire"
	if Input.is_action_just_pressed("teleport1"):
		teleport_to("TeleportPoint1")

		
	if Input.is_action_just_pressed("teleport2"):
		teleport2_to("TeleportPoint2")

		
		

	move_and_slide()

func teleport_to(TeleportPoint1):

	# fade noir
	$CanvasLayer/FadeAnimationPlayer.play("FadeOut")

	# attendre fin animation
	await $CanvasLayer/FadeAnimationPlayer.animation_finished

	# arrêter le mouvement
	velocity = Vector3.ZERO

	# téléporter
	global_position = get_parent().get_node(TeleportPoint1).global_position

	# fade retour
	$CanvasLayer/FadeAnimationPlayer.play("FadeIn")
	
func teleport2_to(TeleportPoint2):

	# fade noir
	$CanvasLayer/FadeAnimationPlayer.play("FadeOut")

	# attendre fin animation
	await $CanvasLayer/FadeAnimationPlayer.animation_finished

	# arrêter le mouvement
	velocity = Vector3.ZERO

	# téléporter
	global_position = get_parent().get_node(TeleportPoint2).global_position

	# fade retour
	$CanvasLayer/FadeAnimationPlayer.play("FadeIn")
