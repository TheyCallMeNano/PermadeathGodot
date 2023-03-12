extends Area2D

@onready var anim = $AnimationPlayer

func attack():
	if global.classInt == 0:
		anim.play("Slash")

func _on_body_entered(body: Node) -> void:
	if body.has_method("handleHit"):
		body.handleHit()
