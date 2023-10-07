extends CharacterBody2D
## Enemy Controller for generic/non boss or special enemies


#Animation Manager
@onready var animationPlayer = $AnimationPlayer

#Controllers
var acidActive = false
var poisonActive = false
var moltenActive = false
const FRICTION = 1500
var acidCounter = 0
var poisonCounter = 0
var moltenCounter = 0
var beingHit = false
var previousState = "handlehit"
@onready var player = $"/root/Hub/YSort/Player/"
var dir = Vector2.ZERO
var vel = Vector2.ZERO

#Stats
var attackSpeed = 5
var attackDMG = 5
var eHealth = 75
var eDefense = 7

func _ready():
	if self.name == "Dummy":
		eHealth = 9999


func handleHit():
	beingHit = true


##### ELEMENTAL DICTIONARY #####
#Elemental Int to name ID: 0 = Poison, 1 = Acid, 2 = Molten

func _physics_process(delta):
	move_and_slide()
	
	if eHealth <= 0:
		print("Dead!")
		queue_free()
	


func Acid():
	acidActive = true
	handleHit()

func Poison():
	poisonActive = true
	handleHit()

func Molten():
	moltenActive = true
	handleHit()


func _on_weapon_area_entered(area):
	if player == area.get_parent():
		global.plrHP -= attackDMG
		print(global.plrHP)
