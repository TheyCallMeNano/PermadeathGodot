extends Area2D

var xRange = randi_range(-828,540)
var yRange = randi_range(-316,292)
var spawning = true
var spawnTotal = 25
var spawned = 0
var region = null
var enemy = null

func _on_area_entered(area):
	region = area

func _ready():
	randomize()
	position.x = xRange
	position.y = yRange

func _physics_process(delta):
	if spawning == true && region == $/root/Hub/spawningZone && spawned != spawnTotal:
		if global.randEID == 0:
			enemy = preload("res://Objects/Enemys/objSkeletonMelee.tscn")
			print("Enemy ID: " + str(global.randEID))
			global.randEID = randi() % global.eID.size()
		elif global.randEID == 1:
			enemy = preload("res://Objects/Enemys/objSkeletonRanged.tscn")
			print("Enemy ID: " + str(global.randEID))
			global.randEID = randi() % global.eID.size()
		var enemyInst = enemy.instantiate()
		enemyInst.position = position
		$/root/Hub/YSort.add_child(enemyInst)
		print("Spawned at: " + str(position) + "\n" + str(region))
		spawned += 1
	elif spawning == true && region != $/root/Hub/spawningZone:
		print("Rerolling!")
	if spawned == spawnTotal:
		spawning = false
	if spawning == true:
		xRange = randi_range(828,-540)
		yRange = randi_range(316,-292)
		position.x = xRange
		position.y = yRange


func _on_area_exited(area):
	region = null
