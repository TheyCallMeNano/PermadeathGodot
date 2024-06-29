extends ParallaxBackground

func _process(delta):
	scroll_base_offset -= Vector2(25,0) * delta
