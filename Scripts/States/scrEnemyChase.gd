extends State
class_name EnemyChase

@onready var animationPlayer = $"../../AnimationPlayer"

var chasing = false
@export var enemy: CharacterBody2D
@export var moveSpd := 75.0
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")

func Update(delta: float):
	if $"../..".beingHit == true:
		$"../..".beingHit = false
		Transitioned.emit(self,"handlehit")

func physicsUpdate(delta: float):
	var dir = player.global_position - enemy.global_position
	
	if chasing == true:
		enemy.velocity = dir.normalized() * moveSpd
		$"../../Sight".rotation = $"../..".position.angle_to_point(player.global_position)
	else:
		enemy.velocity = Vector2()
	if dir.length() < 100 && get_parent().get_child(2).name == "AttackRanged":
		enemy.velocity = Vector2()
		chasing = false
		Transitioned.emit(self,"attackranged")
	elif dir.length() <= 30 && get_parent().get_child(2).name == "AttackMelee":
		enemy.velocity = Vector2()
		Transitioned.emit(self, "attackmelee")
	elif chasing == false:
		enemy.velocity = Vector2.ZERO

func _on_sight_area_entered(area):
	if player == area.get_parent():
		chasing = true

func _on_sight_area_exited(area):
	if player == area.get_parent():
		chasing = false
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
