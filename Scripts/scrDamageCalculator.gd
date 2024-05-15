extends CharacterBody2D

var player: CharacterBody2D
var dmg = null

func _ready():
	$AnimationPlayer.play("Moving")
	player = get_tree().get_first_node_in_group("player")
	if global.path == 1:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false

func _physics_process(delta):
	position += velocity/25

func _on_area_2d_area_entered(area):
	if player == area.get_parent():
		global.plrHP -= dmg
		queue_free()
