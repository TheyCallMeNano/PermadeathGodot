extends Area2D
#This is horrible and requires finding the directory of the Player node with a fixed directory
#Is the player colliding with any of the sightline?
##Player is colliding with the sightline
func _on_Area2D_area_entered(area):
	if area.has_method("seen"):
		$"/root/Hub/YSort/Player".seen()

##Player is not colliding with the sightline
func _on_Area2D_area_exited(area):
	if area.has_method("hidden"):
		$"/root/Hub/YSort/Player".hidden()
