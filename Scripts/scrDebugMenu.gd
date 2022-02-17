extends Label

func _process(delta):
	#Print debug variables for in game tracking
	## This is super messy and requires one giant set_text function decreasing framerate
	## Debug key is "F4" (Check Project > Project Settings for all keybindings)
	if Input.is_action_pressed("debugMenu"):
		set_text("Max Stamina: " + str(global.plrMaxStamina) + 
		"\nRecharge Rate: " + str(global.plrStaminaRecharge) + 
		"\nRecharge Delay: " + str(global.plrStaminaRechargeDelay))
	#Reset text to nothing so that the player doesn't have the debug info
	else:
		set_text("")