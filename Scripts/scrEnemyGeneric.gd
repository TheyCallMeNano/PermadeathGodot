extends CharacterBody2D
## Enemy Controller for generic/non boss or special enemies


#Animation Manager
@onready var animationPlayer = $AnimationPlayer

#Controllers
var acidActive = false
var poisonActive = false
var moltenActive = false
const FRICTION = 1000
var acidCounter = 0
var poisonCounter = 0
var moltenCounter = 0
@onready var player = $"/root/Hub/YSort/Player/"
var dir = Vector2.ZERO
var vel = Vector2.ZERO

#Stats
var attackSpeed = 5
var attackDMG = 5
var eHealth = 75
var eDefense = 7

func _ready():
	if self.name == "Dummy":
		eHealth = 9999


func handleHit():
	animationPlayer.play("Hit")
	if global.classInt == 0:
		eHealth -= global.baseDMG
		print("Health: " + str(eHealth))

##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _physics_process(delta):
	move_and_slide()
	
	if acidActive == true:
		#Acid should reduce "accuracy" or make the enemy attack slower
		acidCounter += 1
		if acidCounter == 30 || acidCounter == 60:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			attackSpeed -= 0.5
			eHealth -= 12/eDefense
			print("Acid Inflicted! Attack Speed: " + str(attackSpeed) + " Health: " + str(eHealth))
		if acidCounter == 60:
			acidActive = false
			acidCounter = 0
			attackSpeed += 1
			
	if poisonActive == true:
		#Poison should give the enemy weakness or less damage
		poisonCounter += 1
		if poisonCounter == 30 || poisonCounter == 60:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 2
			attackDMG -= 0.5
			print("Poison Inflicted! Defense: " + str(eDefense) + " Attack Damage: " + str(attackDMG))
		if poisonCounter == 60:
			poisonActive = false
			eDefense += 4
			attackDMG += 1
			poisonCounter = 0
			
	if moltenActive == true:
		#Molten should slow the enemy and deal massive damage to health/armor
		moltenCounter += 1
		if moltenCounter == 30 || moltenCounter == 60:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 3
			eHealth -= 21/eDefense
			print("Molten Inflicted! Defense: " + str(eDefense) + " Health: " + str(eHealth))
		if moltenCounter == 60:
			moltenActive = false
			moltenCounter = 0
			eDefense += 6
	
	if eHealth <= 0:
		print("Dead!")
		queue_free()

func Acid():
	acidActive = true

func Poison():
	poisonActive = true

func Molten():
	moltenActive = true
