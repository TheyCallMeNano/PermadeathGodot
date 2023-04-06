extends CharacterBody2D

var speed = 500
var counter = 0
var splatter = preload("res://Objects/objPotionSplat.tscn")

func _physics_process(delta):
	position += velocity/30

func _process(delta):
	counter += 1 * delta
	rotation_degrees += 10
	$Sprite2D.scale -= Vector2(counter * delta/2, counter * delta/2)
	if counter >= 0.75:
		counter = 0
		var splatInst = splatter.instantiate()
		splatInst.position = get_global_position()
		splatInst.rotation_degrees = rotation_degrees
		$/root/Hub/Decals.add_child(splatInst)
		queue_free()

func _on_area_2d_body_entered(body):
	var splatInst = splatter.instantiate()
	splatInst.position = get_global_position()
	splatInst.rotation_degrees = rotation_degrees
	$/root/Hub/Decals.add_child(splatInst)
	queue_free()
