extends Area2D

@onready var anim = $AnimationPlayer
var potion = preload("res://Objects/objPotion.tscn")
var potionSpeed = 200

func attack():
	if global.classInt == 0:
		anim.play("Slash")
	if global.classInt == 1:
		var potionInst = potion.instantiate()
		potionInst.position = get_global_position()
		potionInst.rotation_degrees = rotation_degrees
		if position.x == 20:
			potionInst.apply_impulse(Vector2(potionSpeed,-potionSpeed+get_global_mouse_position().y),Vector2(potionSpeed,0).rotated(rotation))
		elif position.x == -20:
			potionInst.apply_impulse(Vector2(-potionSpeed,-potionSpeed+get_global_mouse_position().y),Vector2(potionSpeed,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child", potionInst)

func _on_body_entered(body: Node) -> void:
	if body.has_method("handleHit"):
		body.handleHit()

func _process(delta):
	if global.classInt == 1:
		look_at(get_global_mouse_position())
