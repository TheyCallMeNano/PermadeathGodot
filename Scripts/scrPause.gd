extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var pauseState = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = pauseState
