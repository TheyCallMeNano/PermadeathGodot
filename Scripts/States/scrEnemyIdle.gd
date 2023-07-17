extends State
class_name EnemyIdle

var chasing = false
@export var enemy: CharacterBody2D
@export var moveSpd := 10.0
var player: CharacterBody2D

var moveDir : Vector2
var wanderTime : float

func randomizeWander():
	moveDir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wanderTime = randf_range(1,3)

func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomizeWander()

func Update(delta: float):
	if wanderTime > 0:
		wanderTime -= delta
	
	else:
		randomizeWander()

func physicsUpdate(delta: float):
	if enemy:
		enemy.velocity = moveDir * moveSpd
	
	if chasing == true:
		Transitioned.emit(self,"chase")


func _on_sight_area_entered(area):
	if player == area.get_parent():
		chasing = true

func _on_sight_area_exited(area):
	if player == area.get_parent():
		chasing = false
