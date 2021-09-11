extends Sprite

func _process(delta):
	if Global.Player != null:
		frame = Global.Player.health
