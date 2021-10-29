extends KinematicBody2D

const MAX_SPEED = 150

var vel = Vector2.ZERO

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	inputVector.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		vel = inputVector
	else:
		vel = Vector2.ZERO
	
	move_and_collide(vel * delta * MAX_SPEED)
#Hello
