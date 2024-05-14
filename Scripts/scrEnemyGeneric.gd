extends CharacterBody2D
## Enemy Controller for generic/non boss or special enemies


# Animation Manager
@onready var animationPlayer = $AnimationPlayer

# Controllers
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

var dmgTaken = 0

func _ready():
	if self.name == "Dummy":
		eHealth = 9999

func handleHit():
	velocity = Vector2.ZERO # Might remove this if it becomes too unbalanced
	
	## Assassin Damage Handling
	if global.classInt == 0:
		animationPlayer.play("Hit")
		eHealth -= global.baseDMG
		print("Health: " + str(eHealth))
		dmgTaken = global.baseDMG
		$dmgDisplay.displayDamage(dmgTaken)
		beingHit = false
	
	## Alchemist Damage Handling
	elif global.classInt == 1:
		# Acid State
		if acidActive == true:
			# Acid should reduce "accuracy" or make the enemy attack slower
			acidCounter += 1
			if acidCounter == 30 || acidCounter == 60:
				animationPlayer.play("Hit")
				# Change these to modular values later, calculated by difficulty and plrLvl
				attackSpeed -= 0.5
				eHealth -= 12/eDefense
				dmgTaken = 12/eDefense
				$dmgDisplay.displayDamage(dmgTaken)
				print("Acid Inflicted! Attack Speed: " + str(attackSpeed) + " Health: " + str(eHealth))
			if acidCounter == 60:
				attackSpeed += 1
				acidCounter = 0
				acidActive = false
				beingHit = false
		
		# Poison State
		elif poisonActive == true:
			# Poison should give the enemy weakness or less damage
			poisonCounter += 1
			if poisonCounter == 30 || poisonCounter == 60:
				animationPlayer.play("Hit")
				# Change these to modular values later, calculated by difficulty and plrLvl
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
		elif moltenActive == true:
			# Molten should slow the enemy and deal massive damage to health/armor
			moltenCounter += 1
			if moltenCounter == 30 || moltenCounter == 60:
				animationPlayer.play("Hit")
				# Change these to modular values later, calculated by difficulty and plrLvl
				eDefense -= 3
				eHealth -= 21/eDefense
				dmgTaken = 21/eDefense
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
	
	if beingHit == true:
		handleHit()
	
	if eHealth <= 0:
		velocity = Vector2.ZERO
		animationPlayer.play("Death")

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
