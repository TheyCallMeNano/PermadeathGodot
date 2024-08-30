extends State
class_name EnemyRangedAttack

@onready var animationPlayer = $"../../AnimationPlayer"

@onready var timer = get_node("Cooldown")
@export var enemy: CharacterBody2D
## For randomized projectiles use the method we use to find the player in the Enter fucntion
## however, use a random number for the projectile to use.
@export var projectile = preload("res://Objects/Enemys/Projectiles/objIceSpell.tscn")
var player: CharacterBody2D
var canFire = true

func Enter():
	player = get_tree().get_first_node_in_group("player")
	timer.set_wait_time(2)
	global.plrSpotted = true

func physicsUpdate(delta: float):
	$"../../Sight".rotation = $"../..".position.angle_to_point(player.global_position)
	
	if animationPlayer.get_current_animation() == "Death":
		enemy.velocity = Vector2()
		Transitioned.emit(self, "idle")
	
	if canFire == true:
		var projectileInst = projectile.instantiate()
		projectileInst.rotation = $"../../Sight".rotation
		projectileInst.position = $"../..".global_position
		projectileInst.velocity = Vector2(player.position - projectileInst.position)
		projectileInst.dmg = get_parent().get_parent().attackDMG
		get_tree().get_root().call_deferred("add_child", projectileInst)
		timer.start()
		canFire = false
		Transitioned.emit(self,"chase")

func Exit():
	$"../..".previousState = self
	global.plrSpotted = false

func _on_timer_timeout():
	canFire = true
