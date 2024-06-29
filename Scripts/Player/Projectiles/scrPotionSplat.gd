extends Node2D

var counter = 0
var element

##### ELEMENTAL DICTIONARY #####
# Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _ready():
	$sndGlassBreak.play()
	if element == 0:
		$Sprite.set_modulate("00ff00")
	if element == 1:
		$Sprite.set_modulate("63009e")
	if element == 2:
		$Sprite.set_modulate("ee6800")
	if global.path == 1:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false

func _process(delta):
	counter += 1 * delta
	if counter >= 1.5:
		counter = 0
		queue_free()

func _on_area_2d_body_entered(body):
	print("Body: " + str(body))
	if body.is_in_group("enemys"):
		if element == 0:
			body.Poison()
		if element == 1:
			body.Acid()
		if element == 2:
			body.Molten()
