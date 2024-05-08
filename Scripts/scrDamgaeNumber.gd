extends Sprite2D
var counter = 0


func _process(delta):
	counter += 1 * delta
	if counter >= 2:
		queue_free()
