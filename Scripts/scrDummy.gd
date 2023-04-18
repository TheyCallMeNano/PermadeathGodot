extends StaticBody2D

#Animation Manager
@onready var animationPlayer = $AnimationPlayer
var acidActive = false
var poisionActive = false
var moltenActive = false

func handleHit():
	animationPlayer.play("Hit")

var counter = 0

##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _process(delta):
	if acidActive == true:
		counter += 1
		if counter % 2:
			print("Damage Taken/Status Inflicted!")
		if counter == 20:
			acidActive = false
			counter = 0

func Acid():
	#Acid should reduce "accuracy" or make the enemy attack slower
	acidActive = true
	pass

func Poison():
	#Poison should give the enemy weakness or less defense
	poisionActive = true
	pass

func Molten():
	#Molten should slow the enemy and deal massive damage to health/armor
	moltenActive = true
	pass
