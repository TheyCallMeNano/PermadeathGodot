extends CharacterBody2D

var player: CharacterBody2D

func _ready():
	$AnimationPlayer.play("Moving")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	position += velocity/25

func _on_area_2d_area_entered(area):
	if player == area.get_parent():
		global.plrHP -= 5
		print(global.plrHP)
		queue_free()
