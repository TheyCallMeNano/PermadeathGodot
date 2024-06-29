extends Sprite2D

var counter = 0

func _ready():
	if global.path == 1:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false

func _process(delta):
	counter += 1 * delta
	if counter >= 0.5:
		queue_free()
