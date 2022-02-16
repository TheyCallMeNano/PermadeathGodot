extends Label

func _process(delta):
	#Print text as white
	if global.plrStamina > 0:
		add_color_override("font_color", Color(1,1,1,1))
		set_text("Stamina: " + str(global.plrStamina))
	#Print text as red when stamina is empty and sprinting/dashing
	elif global.plrStamina == 0 && Input.is_action_pressed("sprint") || global.plrStamina == 0 && Input.is_action_pressed("dash"):
		add_color_override("font_color", Color(255,0,0,1))
		set_text("Stamina: " + str(global.plrStamina))
	#Reset to normal when not active
	else:
		add_color_override("font_color", Color(1,1,1,1))
