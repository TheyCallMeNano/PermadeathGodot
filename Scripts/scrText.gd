extends Label
var on = false

func _process(delta):
	##Print debug variables for in game tracking.
	## This is super messy and requires one giant set_text function decreasing framerate. This is terrible, too bad!
	## Debug key is "F4" (Check Project > Project Settings for all keybindings)
	if get_name() == "Debug Menu":
		if on == true:
			set_text("Max Stamina: " + str(global.plrMaxStamina) + 
			"\nRecharge Rate: " + str(global.plrStaminaRecharge) + 
			"\nRecharge Delay: " + str(global.plrStaminaRechargeDelay) + 
			"\nMouse X/Y: " + str(get_viewport().get_mouse_position()) + 
			"\nFPS: " + str(Performance.get_monitor(Performance.TIME_FPS)) +
			"\nRaw Damage: " + str(global.baseDMG) + 
			"\nVersion: " + str(global.version) +
			"\nClassInt: " + str(global.classInt))
		if Input.is_action_just_pressed("debugMenu") && on == false:
			on = true
		#Reset text to nothing so that the player doesn't have the debug info
		elif on == true && Input.is_action_just_pressed("debugMenu"):
			set_text("")
			on = false
			
	if get_name() == "Stamina":
		#Print text as white
		if global.plrStamina > 0.0:
			add_theme_color_override("font_color", Color(1,1,1,1))
			set_text("Stamina: " + str(global.plrStamina))
		#Print text as red when stamina is empty and sprinting/dashing
		elif global.plrStamina == 0.0 && Input.is_action_pressed("sprint") || global.plrStamina < global.plrStaminaRecharge*30 && Input.is_action_pressed("dash"):
			add_theme_color_override("font_color", Color(255,0,0,1))
			set_text("Stamina: " + str(global.plrStamina))
		#Reset to normal when not active
		else:
			add_theme_color_override("font_color", Color(1,1,1,1))
