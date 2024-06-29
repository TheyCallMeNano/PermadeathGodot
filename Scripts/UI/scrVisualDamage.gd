extends Node2D

var dmgNumber = preload("res://Objects/objDmgNumber.tscn")

func displayDamage(dmgTaken):
	if dmgTaken < 10 && dmgTaken > 0:
		var dmgInst = dmgNumber.instantiate()
		dmgInst.position = global_position
		dmgInst.frame = dmgTaken
		$/root/Hub.add_child(dmgInst)
	elif dmgTaken > 10:
		var mod = 10
		@warning_ignore("unassigned_variable")
		var children : Array[int]
		while dmgTaken != 0:
			if dmgTaken % mod < 10:
				children.append(dmgTaken % mod)
				dmgTaken -= dmgTaken % mod
			elif dmgTaken % mod >= 10:
				@warning_ignore("integer_division")
				children.append((dmgTaken % mod) / (mod/10))
				dmgTaken -= dmgTaken % mod
			if dmgTaken % mod == 0:
				mod = mod * 10
		if dmgTaken == 0:
			mod = 10
			print("Damage Numbers: " + str(children))
		var numOfChildren = children.size() - 1
		var i = 0
		while numOfChildren != -1:
			var dmgInst = dmgNumber.instantiate()
			dmgInst.position = global_position + Vector2(i*30,0)
			i += 1
			dmgInst.frame = children[numOfChildren]
			$/root/Hub.add_child(dmgInst)
			numOfChildren -= 1
