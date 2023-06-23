extends Area2D

var statActive = false
var statIntPrev = 0

#Status Int to Name ID: Buffs: Health = 0, AttackSpeed = 1, Defense = 3, Damage = 4;
#Debuffs: Speed = 5, Weakness = 6, Slowness = 7

func active():
	print("ran")
	statActive = true
	statIntPrev = global.statusInt
	statPositive()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.attackMode == 1:
		if statIntPrev != global.statusInt && Input.is_action_just_released("changeStatusUp") || statIntPrev != global.statusInt && Input.is_action_just_released("changeStatusDown"):
			statNegative()
			statIntPrev = global.statusInt
			active()
		if monitoring == false && statActive == true:
			statActive = false
			statNegative()

func statNegative():
		if statIntPrev == 0:
			global.plrHP -= 20
			print(global.plrHP)
		elif statIntPrev == 1:
			global.plrAttackSpd -= 5
			print(global.plrAttackSpd)
		elif statIntPrev == 2:
			global.plrDefense -= 2
			print(global.plrDefense)
		elif statIntPrev == 3:
			global.baseDMG -= 10
			print(global.baseDMG)
		elif statIntPrev == 4:
			pass
		elif statIntPrev == 5:
			pass
		elif statIntPrev == 6:
			pass
		elif statIntPrev == 7:
			pass

func statPositive():
	if statIntPrev == 0:
		global.plrHP += 20
		print(global.plrHP)
	elif statIntPrev == 1:
		global.plrAttackSpd += 5
		print(global.plrAttackSpd)
	elif statIntPrev == 2:
		global.plrDefense += 2
		print(global.plrDefense)
	elif statIntPrev == 3:
		global.baseDMG += 10
		print(global.baseDMG)
	elif statIntPrev == 4:
		pass
	elif statIntPrev == 5:
		pass
	elif statIntPrev == 6:
		pass
	elif statIntPrev == 7:
		pass
