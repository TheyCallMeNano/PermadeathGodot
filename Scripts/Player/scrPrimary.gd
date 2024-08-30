extends Area2D

@onready var anim = $AnimationPlayer
var potion = preload("res://Objects/Player/Projectiles/objPotion.tscn")
## Speed at which the potion travels
@export var potionSpeed = 200
var counter = 0

func attack():
	# Assassin
	if global.classInt == 0:
		anim.play("Slash")
	# Alchemist
	if global.classInt == 1 && global.attackMode == 0:
		position.x = 0
		position.y = 0
		var potionInst = potion.instantiate()
		potionInst.rotation = rotation
		potionInst.position = global_position
		potionInst.velocity = Vector2(get_global_mouse_position() - potionInst.position)
		if counter == 30:
			get_tree().get_root().call_deferred("add_child", potionInst)
			counter = 0

func _physics_process(_delta):
	$"..".look_at(get_global_mouse_position())
	if counter != 30:
		counter += 1


func _on_area_entered(area):
	if area.get_parent().has_method("handleHit"):
		area.get_parent().handleHit()
