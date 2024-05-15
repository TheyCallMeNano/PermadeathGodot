extends Area2D

var statActive = false
var statIntPrev = 0
var entityDict = {}
var entityAmt = 0

# Status Int to Name ID: Buffs: Health = 0, AttackSpeed = 1, Defense = 2, Damage = 3;
# Debuffs: Speed = 4, Weakness = 5, Slowness = 6
var atkSpdDebuff = 2
var defenseDebuff = 5
var spdDebuff = 25

func active():
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
		if entityDict.is_empty():
			entityAmt = 0

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


func _on_area_entered(area):
	if area.name == "Hurtbox":
		entityDict[entityAmt] = area.get_parent()
		entityAmt += 1
		print("Entity Dict: " + str(entityDict))


func _on_area_exited(area):
	var entityTotal = 0
	while entityTotal != entityAmt:
		if area.get_parent() == entityDict.get(entityTotal):
			if statIntPrev == 4:
				area.get_parent().attackSpeed += 2
				print(area.get_parent().attackSpeed)
			elif statIntPrev == 5:
				area.get_parent().eDefense += 2
				print(area.get_parent().eDefense)
			elif statIntPrev == 6:
				area.get_parent().moveSpd += 15
				print(area.get_parent().moveSpd)
			entityDict.erase(entityTotal)
			print("Entity Dict: " + str(entityDict))
		else:
			entityTotal += 1
