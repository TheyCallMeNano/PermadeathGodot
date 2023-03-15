extends RigidBody2D
var counter = 0
var splatter = preload("res://Objects/objPotionSplat.tscn")

func _process(delta):
	counter += 1 * delta
	rotation_degrees += 10
	if counter >= 0.75:
		counter = 0
		var splatInst = splatter.instantiate()
		splatInst.position = get_global_position()
		splatInst.rotation_degrees = rotation_degrees
		$/root/Hub/Decals.add_child(splatInst)
		queue_free()

func _on_body_entered(body):
	var splatInst = splatter.instantiate()
	splatInst.position = get_global_position()
	splatInst.rotation_degrees = rotation_degrees
	$/root/Hub/Decals.add_child(splatInst)
	queue_free()

