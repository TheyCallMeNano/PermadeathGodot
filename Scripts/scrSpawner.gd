extends Area2D

var xRange = randi_range(-828,540)
var yRange = randi_range(-316,292)
var spawning = false
var spawnTotal = 25
var spawned = 0
var region = null
var enemy1 = preload("res://Objects/objSkeleton.tscn")

func _on_area_entered(area):
	spawning = true
	region = area

func _ready():
	randomize()
	position.x = xRange
	position.y = yRange

func _process(delta):
	if spawning == true && region == $/root/Hub/spawningZone && spawned != spawnTotal:
		xRange = randi_range(-828,540)
		yRange = randi_range(-316,292)
		var enemyInst = enemy1.instantiate()
		enemyInst.position = get_global_position()
		$/root/Hub/YSort.add_child(enemyInst)
		spawned += 1
		region = null
		position.x = xRange
		position.y = yRange
	elif spawning == true && region != $/root/Hub/spawningZone:
		xRange = randi_range(-828,540)
		yRange = randi_range(-316,292)
		position.x = xRange
		position.y = yRange
	elif spawning != true && region != $/root/Hub/spawningZone:
		xRange = randi_range(-828,540)
		yRange = randi_range(-316,292)
		position.x = xRange
		position.y = yRange
	if spawned == spawnTotal:
		spawning = false


func _on_area_exited(area):
	region = null
