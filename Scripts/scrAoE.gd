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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.attackMode == 1:
		if statIntPrev != global.statusInt && Input.is_action_just_released("changeStatusUp") || statIntPrev != global.statusInt && Input.is_action_just_released("changeStatusDown"):
			if !entityDict.is_empty() && statIntPrev > 3:
				for i in entityDict.size():
					statPositive(entityDict[i])
					statChange(entityDict[i])
			elif statIntPrev < 4 && entityDict.is_empty():
				statPositive(null)
				statChange(null)
			else:
				statIntPrev = global.statusInt
			statActive = true
			print("Status is changing!\n" + str(global.statusName[global.statusInt]))
		if monitoring == false && statActive == true:
			statActive = false
			#statChange()
		if entityDict.is_empty():
			entityAmt = 0

func statPositive(target):
	if target == null:
		if statIntPrev == 0:
			global.plrHP += 20
		elif statIntPrev == 1:
			global.plrAttackSpd += 5
		elif statIntPrev == 2:
			global.plrDefense += 2
		elif statIntPrev == 3:
			global.baseDMG += 10
	else:
		if statIntPrev == 4:
			target.attackSpeed += 2
			print("Atk Speed: " + str(target.attackSpeed))
		elif statIntPrev == 5:
			target.eDefense += 2
			print("Defense: " + str(target.eDefense))
		elif statIntPrev == 6:
			target.moveSpd += 15
			print("Move Speed: " + str(target.moveSpd))
	statIntPrev = global.statusInt

func statChange(target):
	if target == null:
		if statIntPrev == 0:
			global.plrHP -= 20
		elif statIntPrev == 1:
			global.plrAttackSpd -= 5
		elif statIntPrev == 2:
			global.plrDefense -= 2
		elif statIntPrev == 3:
			global.baseDMG -= 10
	else:
		if statIntPrev == 4:
			target.attackSpeed -= 2
			print("Atk Speed: " + str(target.attackSpeed))
		elif statIntPrev == 5:
			target.eDefense -= 2
			print("Defense: " + str(target.eDefense))
		elif statIntPrev == 6:
			target.moveSpd -= 15
			print("Move Speed: " + str(target.moveSpd))


func _on_area_entered(area):
	if area.name == "Hurtbox":
		entityDict[entityAmt] = area.get_parent()
		statChange(entityDict[entityAmt])
		entityAmt += 1
		print("Entity Dict: " + str(entityDict))


func _on_area_exited(area):
	var entityTotal = 0
	while entityTotal != entityAmt:
		if area.get_parent() == entityDict.get(entityTotal):
			statChange(entityDict[entityTotal])
			entityDict.erase(entityTotal)
			print("Entity Dict: " + str(entityDict))
		else:
			entityTotal += 1
