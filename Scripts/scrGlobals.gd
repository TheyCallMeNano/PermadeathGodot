extends Node

#Controllers
var gameSaveSlot = 0

#Player Vars
#Int to name ID: -1 = N/A, 0 = Assassin, 1 = Alchemist, 2 = Dualist, 3 = Paladin
var classInt = -1
var className = ""
var plrHP = 100
var plrMaxStamina = 100.0
var plrStamina = 100.0
var plrStaminaRecharge = 1.0
var plrStaminaRechargeDelay = 0.0
var plrStaminaDelayTime = 120
var baseDMG = 15
#Elemental Int to name ID: -1 = Base, 0 = Poison, 1 = Acid, 2 = Molten // More at some point
var elementalInt = -1
var elementalName = ""
#This var is for both class ints 1 and 2; if the var is 0 the potion is POISON/SHORTBOW
#If the var is 1 the potion is ACID/BROADSWORD and if the var is 3 the potion is MOLTEN
#The -1 value is to assign a default non-intrusive value
var styleEquipped = -1

func _process(_delta):
	if Input.get_action_strength("styleOne"):
		styleEquipped = 0
	elif Input.get_action_strength("styleTwo"):
		styleEquipped = 1
	elif Input.get_action_strength("styleThree") && classInt == 1:
		styleEquipped = 2
