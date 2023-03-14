extends Node

#Controllers
var gameSaveSlot = 0

#Player Vars
var classInt = -1; #Int to name ID: -1 = N/A, 0 = Assassin, 1 = Alchemist, 2 = Dualist, 3 = Paladin
var className = "";
var plrHP = 100;
var plrMaxStamina = 100;
var plrStamina = 100;
var plrStaminaRecharge = 0.5;
var plrStaminaRechargeDelay = 0;
var plrStaminaDelayTime = 120;
var baseDMG = 15;
var styleEquipped = -1

func _process(_delta):
	if Input.get_action_strength("styleOne"):
		styleEquipped = 0
	elif Input.get_action_strength("styleTwo"):
		styleEquipped = 1
	elif Input.get_action_strength("styleThree") && classInt == 1:
		styleEquipped = 2
