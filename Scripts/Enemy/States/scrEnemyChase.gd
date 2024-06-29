extends State
class_name EnemyChase

@onready var animationPlayer = $"../../AnimationPlayer"

var chasing = true
@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")
	chasing = true
	global.plrSpotted = true

func physicsUpdate(delta: float):
	$"../..".moveSpd = 300
	var dir = player.global_position - enemy.global_position
	
	if $"../../Sight".inSightAmt >= 9/2:
		chasing = true
	elif $"../../Sight".inSightAmt < 9/2:
		chasing = false
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
	
	if animationPlayer.get_current_animation() == "Death":
		chasing = false
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
	
	if chasing == true:
		enemy.velocity = dir.normalized() * enemy.moveSpd
		enemy.move_and_slide()
		$"../../Sight".rotation = $"../..".position.angle_to_point(player.global_position)
	else:
		enemy.velocity = Vector2()
		enemy.move_and_slide()
	if dir.length() < 300 && get_parent().get_child(2).name == "AttackRanged":
		enemy.velocity = Vector2()
		enemy.move_and_slide()
		chasing = false
		Transitioned.emit(self,"attackranged")
	elif dir.length() <= 30 && get_parent().get_child(2).name == "AttackMelee":
		enemy.velocity = Vector2()
		enemy.move_and_slide()
		Transitioned.emit(self, "attackmelee")
	elif chasing == false:
		enemy.velocity = Vector2.ZERO
		enemy.move_and_slide()

func Exit():
	$"../..".moveSpd = 100
	$"../..".previousState = self
	global.plrSpotted = false

func _on_sight_area_entered(area):
	if player == area.get_parent():
		chasing = true

func _on_sight_area_exited(area):
	if player == area.get_parent():
		chasing = false
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
