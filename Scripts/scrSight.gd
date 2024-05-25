extends Area2D

var inSightAmt = 0
var player = null
@onready var timer = $Timer
@onready var sightDict = {0 : $Cone1, 1 : $Cone2, 2 : $Cone3, 3 : $Cone4,
				4 : $Cone5, 5 : $Cone6, 6 : $Cone7, 7 : $Cone8, 8 : $Cone9}

func _process(delta):
	if inSightAmt >= 9/2:
		global.plrSpotted = true
	elif player == null && inSightAmt < 9/2:
		global.plrSpotted = false

func inSightCheck():
	var cones = 9
	inSightAmt = 0
	for i in cones:
		if sightDict[i].is_colliding() && sightDict[i].get_collider().name == "SightBox":
			inSightAmt += 1


func _on_timer_timeout():
	inSightCheck()
	timer.start()


func _on_area_entered(area):
	if area.name == "SightBox":
		player = area
		global.plrSpotted = true


func _on_area_exited(area):
	if area.name == "SightBox" && inSightAmt < 9/2:
		player = null
		global.plrSpotted = false
