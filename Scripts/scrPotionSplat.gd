extends Node2D

var counter = 0

##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _ready():
	$sndGlassBreak.play()
	global.elementalInt = global.styleEquipped
	if global.styleEquipped == 0:
		$Sprite.set_modulate("00ff00")
	if global.styleEquipped == 1:
		$Sprite.set_modulate("63009e")
	if global.styleEquipped == 2:
		$Sprite.set_modulate("ee6800")

func _process(delta):
	counter += 1 * delta
	if counter >= 1.5:
		counter = 0
		queue_free()

func _on_area_2d_body_entered(body):
	print("Body: " + str(body))
	if body.is_in_group("enemys"):
		if global.styleEquipped == 0:
			body.chasing = true
			body.Poison()
		if global.styleEquipped == 1:
			body.chasing = true
			body.Acid()
		if global.styleEquipped == 2:
			body.chasing = true
			body.Molten()
