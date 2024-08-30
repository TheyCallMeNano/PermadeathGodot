extends CharacterBody2D
## Enemy Controller for generic/non-boss or special enemies

# Animation Manager
@onready var animationPlayer = $AnimationPlayer

# Elemental States
var acidActive = false
var poisonActive = false
var moltenActive = false
const FRICTION = 1500
var acidCounter = 0
var poisonCounter = 0
var moltenCounter = 0
var beingHit = false
@onready var player = $"/root/Hub/YSort/Player/"
@export var previousState : State
var dir = Vector2.ZERO
var vel = Vector2.ZERO

# Stats
@export var attackSpeed = 5
@export var attackDMG = 5
@export var eHealth = 75
@export var eDefense = 7
@export var moveSpd = 100.0

var dmgTaken = 0

func _ready():
	$PointLight2D.visible = global.path == 1

func handleHit():
	velocity = Vector2.ZERO # Might remove if it unbalances gameplay
	
	# Assassin Damage Handling
	if global.classInt == 0:
		animationPlayer.queue("Hit")
		eHealth -= global.baseDMG
		dmgTaken = global.baseDMG
		$dmgDisplay.displayDamage(dmgTaken)
		beingHit = false
	
	# Alchemist Damage Handling
	elif global.classInt == 1:
		# Acid State
		if acidActive:
			acidCounter += 1
			if acidCounter in [30, 60]:
				animationPlayer.queue("Hit")
				attackSpeed -= 0.5
				@warning_ignore("integer_division")
				eHealth -= global.baseDMG / eDefense
				@warning_ignore("integer_division")
				dmgTaken = global.baseDMG / eDefense
				$dmgDisplay.displayDamage(dmgTaken)
				print("Acid Inflicted! Attack Speed: " + str(attackSpeed) + " Health: " + str(eHealth))
			if acidCounter == 60:
				attackSpeed += 1
				acidCounter = 0
				acidActive = false
				beingHit = false
		
		# Poison State
		elif poisonActive:
			poisonCounter += 1
			if poisonCounter in [30, 60]:
				animationPlayer.queue("Hit")
				eDefense -= 2
				attackDMG -= 0.5
				print("Poison Inflicted! Defense: " + str(eDefense) + " Attack Damage: " + str(attackDMG))
			if poisonCounter == 60:
				eDefense += 4
				attackDMG += 1
				poisonCounter = 0
				poisonActive = false
				beingHit = false
			
		# Molten State
		elif moltenActive:
			moltenCounter += 1
			if moltenCounter in [30, 60]:
				animationPlayer.queue("Hit")
				eDefense -= 3
				@warning_ignore("integer_division")
				eHealth -= global.baseDMG / eDefense
				@warning_ignore("integer_division")
				dmgTaken = global.baseDMG / eDefense
				$dmgDisplay.displayDamage(dmgTaken)
				print("Molten Inflicted! Defense: " + str(eDefense) + " Health: " + str(eHealth))
			if moltenCounter == 60:
				eDefense += 6
				moltenCounter = 0
				moltenActive = false
				beingHit = false

##### ELEMENTAL DICTIONARY #####
# Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _physics_process(delta):
	if beingHit:
		handleHit()
	
	if eHealth <= 0:
		velocity = Vector2.ZERO
		animationPlayer.queue("Death")

func Acid():
	acidActive = true
	beingHit = true
	handleHit()

func Poison():
	poisonActive = true
	beingHit = true
	handleHit()

func Molten():
	moltenActive = true
	beingHit = true
	handleHit()

func _on_weapon_area_entered(area):
	if player == area.get_parent():
		global.plrHP -= attackDMG
