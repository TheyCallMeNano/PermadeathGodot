extends RigidBody2D
var counter = 0


func _process(delta):
	counter += 1
	if counter == 1000:
		counter = 0
		queue_free()
