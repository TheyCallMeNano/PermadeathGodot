extends CanvasLayer

signal sceneChanged()

onready var animationPlayer = $AnimationPlayer
onready var black = $Control/Black

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animationPlayer.play("Fadeout")
	yield(animationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animationPlayer.play_backwards("Fadeout")
	yield(animationPlayer, "animation_finished")
	emit_signal("scene_changed")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			change_scene("Underground.tscn", 1)
