extends StaticBody2D

#Animation Manager
@onready var animationPlayer = $AnimationPlayer

func handleHit():
	animationPlayer.play("Hit")
