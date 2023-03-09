extends CharacterBody2D

# These vars configure how ice like the surface is
const MAX_SPEED = 150
const ACCELERATION = 500

#Friction acts at the rate the speed decreases
const FRICTION = 1000

#Different States, adding a "," followed by a parameter adds a new state
enum{
	MOVE,
	STANDBY
}

var rng = RandomNumberGenerator.new()

#Manages what state we are in
var state = MOVE

# This is the velocity calculation
var vel = Vector2.ZERO

var inputVector = Vector2.ZERO

#Check state and run according funcitons
func _physics_process(delta):
	match state:
		MOVE:
			moveState(delta)
		STANDBY:
			standbyState()

#Calculate Movement when in the right state
func moveState(delta):
	rng.randomize()
	var leftNum = rng.randf_range(0, 1)
	var rightNum = rng.randf_range(0, 1)
	var upNum = rng.randf_range(0, 1)
	var downNum = rng.randf_range(0, 1)
	inputVector.x = rightNum - leftNum
	inputVector.y = downNum - upNum
	inputVector = inputVector.normalized()
	
	vel = vel.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	
	move()

func move():
	#Apply movement
	set_velocity(vel)
	move_and_slide()
	vel = velocity
	state = STANDBY

func standbyState():
	state = MOVE
