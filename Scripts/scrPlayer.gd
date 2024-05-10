# This is essentially what we are modifiying
extends CharacterBody2D

## scrPlayer ties directly to the player object and modifies everything the player uses
##
## The script can modifiy: movement speed, attack states, weapons, health, and damage/classes

## These vars configure how ice like the surface is
## Maximum speed that the player can reach
@export var MAX_SPEED = 150
const ACCELERATION = 500

## Friction acts at the rate the speed decreases
@export var FRICTION = 1000

# Different States, adding a "," followed by a parameter adds a new state
enum{
	MOVE,
	DASH,
	ATTACK
}

## Stealth
@export var detected = false

## Manages what state we are in
var state = MOVE

## This is the velocity calculation
var vel = Vector2.ZERO

var inputVector = Vector2.ZERO

## Which direction to dash in
var dashVector = Vector2.RIGHT

## Grab the weapon and get it ready for the Attack state
@onready var weapon = $AoE/Weapon

## Animation Manager
@onready var animationPlayer = $AnimationPlayer

var walking = false
var on = false


func _ready():
	classAssignment()
	print(get_tree().get_nodes_in_group("enemys"))
	global.plrStamina = global.plrMaxStamina
	if global.path == 1:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false

## Assigns the Players class at start of a new run.
##
## Reassignment from default values for different class types.
## Default variables are for Assassin.
## Int to name ID: -1 = N/A, 0 = Assassin, 1 = Alchemist, 2 = Dualist, 3 = Paladin
func classAssignment():
	if global.classInt == 0:
		global.plrHP = 90
		global.plrMaxStamina = 125.0
		global.plrStaminaRecharge = 2.0
		hidden()
	if global.classInt == 1:
		global.plrHP = 100
		global.plrMaxStamina = 100.0
		global.plrStaminaRecharge = 1.0

# Check state and run according functions
func _physics_process(delta):
	if global.attackMode == 1 && on == false:
		on = true
		$AoE.monitoring = true
		$AoE/Sprite2D.visible = true
	if global.attackMode == 0 && on == true:
		$AoE.monitoring = false
		$AoE/Sprite2D.visible = false
		on = false
	
	if Input.is_action_pressed("switchMode") && $AoE.statActive == false:
		$AoE.active()
	
	if Input.is_action_pressed("zoomOut"):
		$Camera2D.zoom.x -= .02
		$Camera2D.zoom.y -= .02
	if Input.is_action_pressed("zoomIn"):
		$Camera2D.zoom.x += .02
		$Camera2D.zoom.y += .02
	
	
	match state:
		MOVE:
			moveState(delta)
		DASH:
			dashState(delta)
		ATTACK:
			attackState()
			

## Calculate Movement when in the right state
func moveState(delta):
	inputVector.x = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	inputVector.y = Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
	inputVector = inputVector.normalized()
	
	# Check if we're moving then play running animation
	if inputVector != Vector2.ZERO:
		dashVector = inputVector
		if inputVector.x > 0 && FRICTION != 5000 && walking == false:
			get_node("Sprite2D").set_flip_h(false)
			animationPlayer.play("Run")
		elif inputVector.x > 0 && FRICTION == 5000 && global.plrStamina != 0:
			get_node("Sprite2D").set_flip_h(false)
			animationPlayer.play("Sprint")
		elif global.plrStamina == 0 && walking == false:
			get_node("Sprite2D").set_flip_h(false)
			animationPlayer.play("Run")
		if inputVector.x < 0 && FRICTION != 5000 && walking == false:
			get_node("Sprite2D").set_flip_h(true)
			animationPlayer.play("Run")
		elif inputVector.x < 0 && FRICTION == 5000 && global.plrStamina != 0:
			get_node("Sprite2D").set_flip_h(true)
			animationPlayer.play("Sprint")
		elif global.plrStamina == 0 && walking == false:
			get_node("Sprite2D").set_flip_h(true)
			animationPlayer.play("Run")
		if inputVector.y > 0 && walking == false:
			animationPlayer.play("RunDown")
		if inputVector.y < 0 && walking == false:
			animationPlayer.play("RunUp")
			
		walking = true
		
		# Check if we're sprinting, then manage all movement in that state until end (Perhaps speed up run animation?)
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
			# We aren't sprinting
			vel = vel.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		walking = false
		animationPlayer.play("Idle")
		vel = vel.move_toward(Vector2.ZERO, FRICTION * delta)
	
	# Check if dashing and if we have enough stamina to dash
	if Input.is_action_just_pressed("dash") && global.plrStamina > global.plrStaminaRecharge*30:
		state = DASH
	
	move()
	stamina()

## What to do when the player attacks
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("primaryAttack"):
			state = ATTACK
	
## Attack Extended
func attackState():
	animationPlayer.play("Throwing")
	if global.attackMode == 0:
		weapon.attack()
	if global.classInt != 1:
		vel = vel.move_toward(Vector2.ZERO, 60)
		animationPlayer.play("Idle")
	attackStateFinished()

## Reset the player to the moving state
func attackStateFinished():
	state = MOVE
	
func move():
	# Apply movement
	set_velocity(vel)
	move_and_slide()
	vel = velocity
	
## What to do when dashing
@warning_ignore("unused_parameter")
func dashState(delta):
	$sndDash.play()
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

## Reset to normal state
# For I-Frames use an if statement to avoid deloading and loading the player object
func dashStateFinished():
	state = MOVE

## Run these checks to refill stamina
func stamina():
	# Is the player running?
	if Input.is_action_pressed("sprint") && global.plrStamina != 0:
			FRICTION = 5000
			if Input.is_action_pressed("moveDown") || Input.is_action_pressed("moveLeft") || Input.is_action_pressed("moveUp") || Input.is_action_pressed("moveRight"):
				global.plrStaminaRechargeDelay = 0
				global.plrStamina -= global.plrStaminaRecharge/2.0
			
	# Have they stopped running?
	if global.plrStamina != global.plrMaxStamina && !Input.is_action_pressed("sprint") && global.plrStaminaRechargeDelay != global.plrStaminaDelayTime:
		global.plrStaminaRechargeDelay += global.plrStaminaRecharge
		FRICTION = 1000
	
	# Give them more stamina
	if global.plrStaminaRechargeDelay == global.plrStaminaDelayTime && global.plrStamina != global.plrMaxStamina:
		global.plrStamina += global.plrStaminaRecharge
	
	# Reset the recharge to prevent overflow
	if global.plrStamina >= global.plrMaxStamina:
		global.plrStaminaRechargeDelay = 0
		global.plrStamina = global.plrMaxStamina

## Player is in a sightline
func seen():
	detected = true
	global.baseDMG = 15
	stealth()

## Player is not in a sightline
func hidden():
	detected = false
	global.baseDMG = 15
	stealth()

## Modify based on status of sightline/stealth
func stealth():
	if detected == false:
		global.baseDMG = global.baseDMG*3 # global.baseDMG = global.baseDMG + lvlDMG * 3
	elif detected == true:
		global.baseDMG = global.baseDMG*0.85 # global.baseDMG = global.baseDMG + lvlDMG * 0.85

func _on_sight_box_area_entered(area):
	print("Area: " + str(area))
	if area.name == "Sight":
		seen()

func _on_sight_box_area_exited(area):
	if area.name == "Sight":
		hidden()
