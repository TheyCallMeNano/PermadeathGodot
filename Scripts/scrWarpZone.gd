extends Area2D

func _physics_process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && self.name == "toDungeon":
			global.path = 1
			get_tree().change_scene_to_file("res://Rooms/Underground.tscn")
		if body.name == "Player" && self.name == "toOverworld":
			global.path = 0
			get_tree().change_scene_to_file("res://Rooms/MainScene.tscn")
