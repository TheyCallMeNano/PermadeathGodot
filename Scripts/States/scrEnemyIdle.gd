extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var moveSpd := 10.0
@onready var player = get_tree().get_first_node_in_group("player")

var moveDir : Vector2
var wanderTime : float

func randomizeWander():
	moveDir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wanderTime = randf_range(1,3)

func Enter():
	if !self.name == "Dummy":
		randomizeWander()

func Update(delta: float):
	if $"../..".beingHit == true:
		$"../..".beingHit == false
		Transitioned.emit(self,"handlehit")
	
	if moveDir.x < -0.5 && moveDir.y > 0.5 && $"../../Sight".rotation != -144:
		if $"../../Sight".rotation < -144:
			$"../../Sight".rotation = 0
		$"../../Sight".rotation -= .02
	elif moveDir.x < -0.5 && moveDir.y == 0 && $"../../Sight".rotation != -180:
		if $"../../Sight".rotation < -180:
			$"../../Sight".rotation = 0
		$"../../Sight".rotation -= .02
	elif moveDir.x > 0.5 && moveDir.y > 0.5 && $"../../Sight".rotation != -34:
		if $"../../Sight".rotation < -34:
			$"../../Sight".rotation = 0
		$"../../Sight".rotation -= .02
	elif moveDir.x == 0 && moveDir.y > 0.5 && $"../../Sight".rotation != -90:
		if $"../../Sight".rotation < -90:
			$"../../Sight".rotation = 0
		$"../../Sight".rotation -= .02
	elif moveDir.x == 0 && moveDir.y < -0.5 && $"../../Sight".rotation != 90:
		if $"../../Sight".rotation < 90:
			$"../../Sight".rotation = 0
		$"../../Sight".rotation += .02
	else:
		pass
	
	if wanderTime > 0:
		wanderTime -= delta
	
	else:
		randomizeWander()

func physicsUpdate(delta: float):
	if enemy:
		enemy.velocity = moveDir * moveSpd


func _on_sight_area_entered(area):
	if player == area.get_parent():
		Transitioned.emit(self,"chase")

func _on_sight_area_exited(area):
	if player == area.get_parent():
		pass
