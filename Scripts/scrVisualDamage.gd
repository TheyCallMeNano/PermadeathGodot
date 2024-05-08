extends Node2D

var dmgNumber = preload("res://Objects/objDmgNumber.tscn")

func displayDamage(dmgTaken):
	print(dmgTaken)
	if dmgTaken < 10 && dmgTaken > 0:
		var dmgInst = dmgNumber.instantiate()
		dmgInst.position = global_position
		dmgInst.frame = dmgTaken
		$/root/Hub/Decals.add_child(dmgInst)
	elif dmgTaken > 10:
		var cleared = false
		var mod = 10
		var children : Array[int]
		while cleared == false:
			if dmgTaken % mod < 10:
				children.append(dmgTaken % mod)
				dmgTaken -= dmgTaken % mod
			elif dmgTaken % mod >= 10:
				children.append((dmgTaken % mod) / (mod/10))
				dmgTaken -= dmgTaken % mod
			if dmgTaken % mod == 0:
				mod = mod * 10
			if dmgTaken == 0:
				cleared = true
				mod = 10
				print(children)
		var numOfChildren = children.size() - 1
		var num = 0
		while numOfChildren != -1:
			var dmgInst = dmgNumber.instantiate()
			dmgInst.position = global_position + Vector2(num*30,0)
			num += 1
			print(children[numOfChildren])
			dmgInst.frame = children[numOfChildren]
			$/root/Hub.add_child(dmgInst)
			numOfChildren -= 1
