extends Area2D

@onready var anim = $AnimationPlayer

func attack():
	anim.play("Slash")

func _on_Slash_body_entered(body: Node) -> void:
	if body.has_method("handleHit"):
		body.handleHit()
