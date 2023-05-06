extends Area2D

#Status Int to Name ID: Buffs: Health = 0, AttackSpeed = 1, Defense = 3, Damage = 4;
#Debuffs: Speed = 5, Weakness = 6, Slowness = 7

func active():
	print("ran")
	if global.statusInt == 0:
		global.plrHP += 20
		print(global.plrHP)
	elif global.statusInt == 1:
		global.plrAttackSpd += 5
		print(global.plrAttackSpd)
	elif global.statusInt == 2:
		global.plrDefense += 2
		print(global.plrDefense)
	elif global.statusInt == 3:
		global.baseDMG += 10
		print(global.baseDMG)
	elif global.statusInt == 4:
		pass
	elif global.statusInt == 5:
		pass
	elif global.statusInt == 6:
		pass
	elif global.statusInt == 7:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
