extends CharacterBody2D

#Animation Manager
@onready var animationPlayer = $AnimationPlayer

#Controllers
var acidActive = false
var poisonActive = false
var moltenActive = false
const FRICTION = 1000
var acidCounter = 0
var poisonCounter = 0
var moltenCounter = 0
var path: PackedVector2Array
var player = -4
var chasing = false
var dir = Vector2.ZERO
var vel = Vector2.ZERO

#Stats
var attackSpeed = 5
var attackDMG = 5
var speed = 1000
var eHealth = 75
var eDefense = 7

func handleHit():
	animationPlayer.play("Hit")

##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _process(delta):
	if chasing == true:
		$Sight.rotation = position.angle_to_point(player.global_position)
		var fromPos: Vector2 = self.global_position
		var toPos: Vector2 = player.global_position
		if fromPos.x > toPos.x:
			dir.x = -1
		elif fromPos.x < toPos.x:
			dir.x = 1
		if fromPos.y > toPos.y:
			dir.y = -1
		elif fromPos.y < toPos.y:
			dir.y = 1
		vel = vel.move_toward(dir * speed, 50 * delta)
		var navMap: RID = get_world_2d().get_navigation_map()
		path = NavigationServer2D.map_get_path(navMap, fromPos, toPos, true)
		move(path)
		
	
	
	if acidActive == true:
		#Acid should reduce "accuracy" or make the enemy attack slower
		acidCounter += 1
		if acidCounter == 200 || acidCounter == 400:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			attackSpeed -= 0.5
			eHealth -= 12/eDefense
			print("Acid Inflicted! " + str(attackSpeed) + " " + str(eHealth))
		if acidCounter == 400:
			acidActive = false
			acidCounter = 0
			attackSpeed += 1
			
	if poisonActive == true:
		#Poison should give the enemy weakness or less damage
		poisonCounter += 1
		if poisonCounter == 200 || poisonCounter == 400:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 2
			attackDMG -= 0.5
			print("Poison Inflicted! " + str(eDefense) + " " + str(attackDMG))
		if poisonCounter == 400:
			poisonActive = false
			eDefense += 4
			attackDMG += 1
			poisonCounter = 0
			
	if moltenActive == true:
		#Molten should slow the enemy and deal massive damage to health/armor
		moltenCounter += 1
		if moltenCounter == 200 || moltenCounter == 400:
			handleHit()
			#Change these to modular values later, calculated by difficulty and plrLvl
			eDefense -= 3
			eHealth -= 21/eDefense
			print("Molten Inflicted! " + str(eDefense) + " " + str(eHealth))
		if moltenCounter == 400:
			moltenActive = false
			moltenCounter = 0
			eDefense += 6
	
	if eHealth <= 0:
		queue_free()

func move(mPath:PackedVector2Array):
	for p in mPath:
		set_velocity(vel)
		move_and_slide()

func Acid():
	acidActive = true

func Poison():
	poisonActive = true

func Molten():
	moltenActive = true


func _on_sight_area_entered(area):
	if area == $/root/Hub/YSort/Player/SightBox:
		player = area.get_parent()
		chasing = true


func _on_sight_area_exited(area):
	#player = -4
	#chasing = false
	vel = vel.move_toward(Vector2.ZERO, FRICTION * 60)
