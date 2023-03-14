extends Node2D

#Type Management // For potions styles
enum{
	ACID,
	MOLTEN,
	POISON
}
var potionType = ACID

func _ready():
	if global.styleEquipped == 0:
		$Sprite.set_modulate("00ff00")
		potionType = POISON
	if global.styleEquipped == 1:
		$Sprite.set_modulate("63009e")
		potionType = ACID
	if global.styleEquipped == 2:
		$Sprite.set_modulate("ee6800")
		potionType = MOLTEN
