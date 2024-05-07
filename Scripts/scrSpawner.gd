extends Area2D

var xRange = randi_range(-828,540)
var yRange = randi_range(-316,292)
var spawning = true
var spawnTotal = 25
var spawned = 0
var region = null
var enemy = null
var stuck = false

var enemyDict = {"enemy0" : preload("res://Objects/Enemys/objSkeletonMelee.tscn"),
				"enemy1" : preload("res://Objects/Enemys/objSkeletonRanged.tscn")}


func _on_area_entered(area):
	region = area

func _ready():
	randomize()
	position.x = xRange
	position.y = yRange

func _physics_process(delta):
	if spawning == true && region == $/root/Hub/spawningZone && spawned != spawnTotal:
		global.randEID = randi() % global.eID.size()
		enemy = enemyDict["enemy" + str(global.randEID)]
		print("Enemy ID: " + str(global.randEID) + "\nEnemy Scene: " + str(enemy))
		var enemyInst = enemy.instantiate()
		enemyInst.position = position
		$/root/Hub/YSort.add_child(enemyInst)
		print("Spawned at: " + str(position) + "\n" + str(region))
		spawned += 1
		stuck = false
	elif spawning == true && region != $/root/Hub/spawningZone && stuck == false:
		print("Rerolling!")
		stuck = true
	if spawned == spawnTotal:
		spawning = false
	if spawning == true:
		xRange = randi_range(828,-540)
		yRange = randi_range(316,-292)
		position.x = xRange
		position.y = yRange


func _on_area_exited(area):
	region = null
