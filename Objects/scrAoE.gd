extends Area2D

var style = global.statusInt

#Status Int to Name ID: Buffs: Health = 0, AttackSpeed = 1, Defense = 3, Damage = 4;
#Debuffs: Speed = 5, Weakness = 6, Slowness = 7

func active():
	print("ran")
	if style == 0:
		global.plrHP += 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
