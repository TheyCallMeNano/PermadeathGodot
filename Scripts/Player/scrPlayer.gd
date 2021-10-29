extends KinematicBody2D

# These vars configure how ice like the surface is
const MAX_SPEED = 150
const ACCELERATION = 500
#Friction acts at the rate the speed decreases
const FRICTION = 1000

# This is the velocity calculation
var vel = Vector2.ZERO

#Animation Manager
onready var animationPlayer = $AnimationPlayer

#Grab movement speed and direction
func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	inputVector.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		if inputVector.x > 0:
			get_node("Sprite").set_flip_h(false)
			animationPlayer.play("Run")
		else:
			get_node("Sprite").set_flip_h(true)
			animationPlayer.play("Run")
			
		vel = vel.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("Idle")
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#Apply movement
	vel = move_and_slide(vel)
