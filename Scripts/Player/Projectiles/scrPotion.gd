extends CharacterBody2D

var speed = 500
var counter = 0
var element
var splatter = preload("res://Objects/Player/Projectiles/objPotionSplat.tscn")

func _ready():
	if global.path == 1:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false
	element = global.elementalInt

func _physics_process(delta):
	position += velocity/30
	counter += 1
	rotation_degrees += 10
	$Sprite2D.scale -= Vector2(counter * delta/500, counter * delta/500)
	if counter >= 75:
		counter = 0
		var splatInst = splatter.instantiate()
		splatInst.position = get_global_position()
		splatInst.rotation_degrees = rotation_degrees
		splatInst.element = element
		$/root/Hub/Decals.add_child(splatInst)
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemys"):
		var splatInst = splatter.instantiate()
		splatInst.position = get_global_position()
		splatInst.rotation_degrees = rotation_degrees
		splatInst.element = element
		$/root/Hub/Decals.call_deferred("add_child" , splatInst)
		queue_free()
