extends StaticBody2D

#Animation Manager
@onready var animationPlayer = $AnimationPlayer


var acidActive = false
var poisonActive = false
var moltenActive = false
var acidCounter = 0
var poisonCounter = 0
var moltenCounter = 0

#Stats
var attackSpeed = 5
var attackDMG = 5
var speed = 100
var eHealth = 75
var eDefense = 10

func handleHit():
	animationPlayer.play("Hit")

##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _process(delta):
	if acidActive == true:
		#Acid should reduce "accuracy" or make the enemy attack slower
		acidCounter += 1
		if acidCounter == 1000 || acidCounter == 2000:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			attackSpeed -= 0.5
			eHealth -= 5
			print("Acid Inflicted! " + str(attackSpeed) + " " + str(eHealth))
		if acidCounter == 2000:
			acidActive = false
			acidCounter = 0
			attackSpeed += 1
			
	if poisonActive == true:
		#Poison should give the enemy weakness or less damage
		poisonCounter += 1
		if poisonCounter == 1000 || poisonCounter == 2000:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 2
			attackDMG -= 0.5
			print("Poison Inflicted! " + str(eDefense) + " " + str(attackDMG))
		if poisonCounter == 2000:
			poisonActive = false
			eDefense += 4
			attackDMG += 1
			poisonCounter = 0
			
	if moltenActive == true:
		#Molten should slow the enemy and deal massive damage to health/armor
		moltenCounter += 1
		if moltenCounter == 1000 || moltenCounter == 2000:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 3
			eHealth -= 7
			print("Molten Inflicted! " + str(eDefense) + " " + str(eHealth))
		if moltenCounter == 2000:
			moltenActive = false
			moltenCounter = 0
			eDefense += 6

func Acid():
	acidActive = true

func Poison():
	poisonActive = true

func Molten():
	moltenActive = true
