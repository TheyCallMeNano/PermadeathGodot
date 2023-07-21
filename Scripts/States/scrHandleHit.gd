extends State
class_name HandleHit

@onready var animationPlayer = $"../../AnimationPlayer"

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")
	enemy.velocity = Vector2()

func physicsUpdate(delta: float):
	if global.classInt == 0:
		enemy.eHealth -= global.baseDMG
		print("Health: " + str(enemy.eHealth))
		Transitioned.emit(self,"chase")
	
	if $"../..".acidActive == true:
		#Acid should reduce "accuracy" or make the enemy attack slower
		$"../..".acidCounter += 1
		if $"../..".acidCounter == 30 || $"../..".acidCounter == 60:
			animationPlayer.play("Hit")
			#Change these to modular values later, calculated by difficulty and plrLvl
			$"../..".attackSpeed -= 0.5
			$"../..".eHealth -= 12/$"../..".eDefense
			print("Acid Inflicted! Attack Speed: " + str($"../..".attackSpeed) + " Health: " + str($"../..".eHealth))
		if $"../..".acidCounter == 60:
			$"../..".attackSpeed += 1
			Transitioned.emit(self,"chase")

			
	if $"../..".poisonActive == true:
		#Poison should give the enemy weakness or less damage
		$"../..".poisonCounter += 1
		if $"../..".poisonCounter == 30 || $"../..".poisonCounter == 60:
			animationPlayer.play("Hit")
			#Change these to modular values later, calculated by difficulty and plrLvl
			$"../..".eDefense -= 2
			$"../..".attackDMG -= 0.5
			print("Poison Inflicted! Defense: " + str($"../..".eDefense) + " Attack Damage: " + str($"../..".attackDMG))
		if $"../..".poisonCounter == 60:
			$"../..".eDefense += 4
			$"../..".attackDMG += 1
			Transitioned.emit(self,"chase")

			
	if $"../..".moltenActive == true:
		#Molten should slow the enemy and deal massive damage to health/armor
		$"../..".moltenCounter += 1
		if $"../..".moltenCounter == 30 || $"../..".moltenCounter == 60:
			animationPlayer.play("Hit")
			#Change these to modular values later, calculated by difficulty and plrLvl
			$"../..".eDefense -= 3
			$"../..".eHealth -= 21/$"../..".eDefense
			print("Molten Inflicted! Defense: " + str($"../..".eDefense) + " Health: " + str($"../..".eHealth))
		if $"../..".moltenCounter == 60:
			$"../..".eDefense += 6
			Transitioned.emit(self,"chase")

func Exit():
	$"../..".beingHit = false
	$"../../Sight".rotation = $"../..".position.angle_to_point(player.global_position)
	$"../..".moltenCounter = 0
	$"../..".poisonCounter = 0
	$"../..".acidCounter = 0
	$"../..".acidActive = false
	$"../..".moltenActive = false
	$"../..".poisonActive = false
