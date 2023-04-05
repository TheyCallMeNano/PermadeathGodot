extends StaticBody2D

#Animation Manager
@onready var animationPlayer = $AnimationPlayer
var active = false

func handleHit():
	animationPlayer.play("Hit")

func _process(delta):
	if active == true && global.styleEquipped == 0:
		Poison()

func Acid():
	#Acid should reduce "accuracy" or make the enemy attack slower
	pass

func Poison():
	#Poison should give the enemy weakness or less defense
	pass

func Molten():
	#Molten should slow the enemy and deal massive damage to health/armor
	pass
