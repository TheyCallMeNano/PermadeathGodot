extends State
class_name EnemyAttackMelee

@onready var animationPlayer = $AnimationPlayer

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")
	animationPlayer.play("Slash")
	enemy.velocity = Vector2.ZERO
	$"../..".previousState = $"../..".previousState
	global.plrSpotted = true

func Update(delta: float):
	$"../../Sight".rotation = $"../..".position.angle_to_point(player.global_position)

func Exit():
	$"../..".previousState = self
	global.plrSpotted = false

func physicsUpdate(delta: float):
	var dir = player.global_position - enemy.global_position
	
	if animationPlayer.get_current_animation() == "Death":
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
	
	if !animationPlayer.is_playing():
		if dir.length() > 80:
			Transitioned.emit(self,"chase")
		else:
			animationPlayer.play("Slash")
