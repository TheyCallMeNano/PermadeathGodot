extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var pauseState = not get_tree().paused
		get_tree().paused = not get_tree().paused
		visible = pauseState


func _on_Sight_body_entered(body):
	pass # Replace with function body.


func _on_Sight_body_exited(body):
	pass # Replace with function body.
