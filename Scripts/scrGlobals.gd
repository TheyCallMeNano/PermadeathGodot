extends Node

#Controllers
var gameSaveSlot = 0
var path = 0
var eID = [0,1]
var randEID:int = randi() % eID.size()
var version = "PREVIEW 0.0.0.8"

#Player Vars
## Int to name ID: -1 = N/A, 0 = Assassin, 1 = Alchemist, 2 = Dualist, 3 = Paladin
var classInt = -1
var className = ""
var plrHP = 100
var plrMaxStamina = 100.0
var plrStamina = 100.0
var plrAttackSpd = 10
var plrDefense = 10
var plrStaminaRecharge = 1.0
var plrStaminaRechargeDelay = 0.0
var plrStaminaDelayTime = 120
var baseDMG = 15
## Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten // More at some point
var elementalInt = 0
var elementalName = ""
## Status Int to Name ID: Buffs: Health = 0, AttackSpeed = 1, Defense = 2, Damage = 3;
## Debuffs: Speed = 4, Weakness = 5, Slowness = 6
var statusInt = -1
var statusName = ""
## This var is for both class ints 1 and 2; if the var is 0 the potion is POISON/SHORTBOW
## If the var is 1 the potion is ACID/BROADSWORD and if the var is 3 the potion is MOLTEN
## This var can also be used to determine the alt style for Alchemist
## See dictionary above for differnt types of stat effects and modifications
var styleEquipped = 0
## This var defines if alt fire modes are enabled, useful for the alchemist; which has two attack styles
## 0 = Potion Throwing and Effect Managment, 1 = Status Effects and debuffs for AoE of the Alchemist
var attackMode = 0
var toggled = false

func _process(_delta):
	if Input.get_action_strength("styleOne"):
		styleEquipped = 0
	elif Input.get_action_strength("styleTwo"):
		styleEquipped = 1
	elif Input.get_action_strength("styleThree") && classInt == 1 && attackMode != 1:
		styleEquipped = 2
	if Input.is_action_just_released("changeStatusUp") && statusInt != 7:
		statusInt += 1
	elif Input.is_action_just_released("changeStatusDown") && statusInt != 7:
		statusInt -= 1
	if statusInt > 6:
		statusInt = 0
	elif statusInt < 0:
		statusInt = 6
	if Input.is_action_just_pressed("switchMode") && toggled == true:
		attackMode = 1
		toggled = false
	elif toggled == false && Input.is_action_just_pressed("switchMode"):
		attackMode = 0
		toggled = true
	if plrHP == 0:
		plrHP = 100
		global.path = 0
		get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")
