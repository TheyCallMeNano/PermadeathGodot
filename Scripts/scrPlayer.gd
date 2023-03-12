#This is essentially what we are modifiying
extends CharacterBody2D

# These vars configure how ice like the surface is
const MAX_SPEED = 150
const ACCELERATION = 500

#Friction acts at the rate the speed decreases
const FRICTION = 1000

#Different States, adding a "," followed by a parameter adds a new state
enum{
	MOVE,
	DASH,
	ATTACK
}

#Stealth
var detected = false

#Manages what state we are in
var state = MOVE

# This is the velocity calculation
var vel = Vector2.ZERO

var inputVector = Vector2.ZERO

#Which direction to dash in
var dashVector = Vector2.RIGHT

#Grab the weapon and get it ready for the Attack state
@onready var slash = $Slash

#Animation Manager
@onready var animationPlayer = $AnimationPlayer

func _ready():
	classAssignment()
	global.plrStamina = global.plrMaxStamina

func classAssignment():
	if global.classInt == 0:
		global.plrHP = 90
		global.plrMaxStamina = 125
		global.plrStaminaRecharge = 1
		#hidden()

#Check state and run according funcitons
func _physics_process(delta):
	match state:
		MOVE:
			moveState(delta)
		DASH:
			dashState(delta)
		ATTACK:
			attackState(delta)

#Calculate Movement when in the right state
func moveState(delta):
	inputVector.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	inputVector.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	inputVector = inputVector.normalized()
	
	#Check if we're moving then play running animation
	if inputVector != Vector2.ZERO:
		dashVector = inputVector
		if inputVector.x > 0:
			get_node("Sprite2D").set_flip_h(false)
			animationPlayer.play("Run")
		if inputVector.x < 0:
			get_node("Sprite2D").set_flip_h(true)
			animationPlayer.play("Run")
		if inputVector.y > 0:
			animationPlayer.play("Run")
		if inputVector.y < 0:
			animationPlayer.play("Run")
			
		if Input.is_action_pressed("moveLeft"):
			slash.position.x = -20
			slash.scale.x = -1
		if Input.is_action_pressed("moveRight"):
			slash.position.x = 20
			slash.scale.x = 1
			
		#Check if we're sprinting, then manage all movement in that state until end (Perhaps speed up run animation?)
		if Input.is_action_pressed("sprint") && global.plrStamina != 0:
			if Input.is_action_pressed("moveDown"):
				vel = vel.move_toward(inputVector * MAX_SPEED * 2, ACCELERATION * delta)
			elif Input.is_action_pressed("moveLeft"):
				vel = vel.move_toward(inputVector * MAX_SPEED * 2, ACCELERATION * delta)
			elif Input.is_action_pressed("moveUp"):
				vel = vel.move_toward(inputVector * MAX_SPEED * 2, ACCELERATION * delta)
			elif Input.is_action_pressed("moveRight"):
				vel = vel.move_toward(inputVector * MAX_SPEED * 2, ACCELERATION * delta)
		else:
			#We aren't sprinting
			vel = vel.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("Idle")
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#Check if attacking
	if Input.is_action_just_pressed("primaryAttack"):
		state = ATTACK
	
	#Check if dashing and if we have enough stamina to dash
	if Input.is_action_just_pressed("dash") && global.plrStamina > global.plrStaminaRecharge*30:
		state = DASH
	
	move()
	stamina()

#What to do when the player attacks
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("primaryAttack"):
			slash.attack()
	
#Attack Extended
@warning_ignore("unused_parameter")
func attackState(delta):
	vel = Vector2.ZERO
	animationPlayer.play("Idle")
	attackStateFinished()

#Reset the player to the moving state
func attackStateFinished():
	state = MOVE
	
func move():
	#Apply movement
	set_velocity(vel)
	move_and_slide()
	vel = velocity
	
#What to do when dashing
@warning_ignore("unused_parameter")
func dashState(delta):
	if global.classInt == 0:
		vel = dashVector * MAX_SPEED * 3
		global.plrStaminaRechargeDelay = 0
		global.plrStamina -= global.plrStaminaRecharge*15
		move()
		dashStateFinished()
		
	else:
		vel = dashVector * MAX_SPEED * 2.5
		global.plrStaminaRechargeDelay = 0
		global.plrStamina -= global.plrStaminaRecharge*30
		move()
		dashStateFinished()

#Reset to normal state
#For I-Frames use an if statement to avoid deloading and loading the player object
func dashStateFinished():
	state = MOVE

#Run these checks to refill stamina
func stamina():
	#Is the player running?
	if Input.is_action_pressed("sprint") && global.plrStamina != 0:
			if Input.is_action_pressed("moveDown"):
				global.plrStaminaRechargeDelay = 0
				global.plrStamina -= global.plrStaminaRecharge 
			elif Input.is_action_pressed("moveLeft"):
				global.plrStaminaRechargeDelay = 0
				global.plrStamina -= global.plrStaminaRecharge
			elif Input.is_action_pressed("moveUp"):
				global.plrStaminaRechargeDelay = 0
				global.plrStamina -= global.plrStaminaRecharge
			elif Input.is_action_pressed("moveRight"):
				global.plrStaminaRechargeDelay = 0
				global.plrStamina -= global.plrStaminaRecharge
	
	#Have they stopped running?
	if global.plrStamina != global.plrMaxStamina && !Input.is_action_pressed("sprint") && global.plrStaminaRechargeDelay != global.plrStaminaDelayTime:
		global.plrStaminaRechargeDelay += global.plrStaminaRecharge
	
	#Give them more stamina
	if global.plrStaminaRechargeDelay == global.plrStaminaDelayTime && global.plrStamina != global.plrMaxStamina:
		global.plrStamina += global.plrStaminaRecharge
	
	#Reset the recharge to prevent overflow
	if global.plrStamina == global.plrMaxStamina:
		global.plrStaminaRechargeDelay = 0

#Player is in a sightline
func seen():
	detected = true
	global.baseDMG = 15
	stealth()

#Player is not in a sightline
func hidden():
	detected = false
	global.baseDMG = 15
	stealth()

#Modify based on status of sightline/stealth
func stealth():
	if detected == false:
		global.baseDMG = global.baseDMG*3 #global.baseDMG = global.baseDMG + lvlDMG * 3
	elif detected == true:
		global.baseDMG = global.baseDMG*0.85 #global.baseDMG = global.baseDMG + lvlDMG * 0.85

func _on_sight_box_area_entered(area):
	print("Area: " + str(area))
	if area == $/root/Hub/Node2D/Dummy/Sight:
		seen()

@warning_ignore("unused_parameter")
func _on_sight_box_area_exited(area):
	hidden()
