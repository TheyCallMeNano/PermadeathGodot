extends Area2D

@onready var anim = $AnimationPlayer
var potion = preload("res://Objects/objPotion.tscn")
var potionSpeed = 200
var counter = 0

func attack():
	if global.classInt == 0:
		anim.play("Slash")
	if global.classInt == 1:
		position.x = 0
		position.y = 0
		var potionInst = potion.instantiate()
		potionInst.rotation = rotation
		potionInst.position = global_position
		potionInst.velocity = Vector2(get_global_mouse_position() - potionInst.position)
		if counter == 180:
			get_tree().get_root().call_deferred("add_child", potionInst)
			counter = 0

func _process(delta):
	if counter != 180:
		counter += 1
	if global.classInt == 1:
		look_at(get_global_mouse_position())


func _on_area_entered(area):
	if area.get_parent().has_method("handleHit"):
		area.get_parent().handleHit()
