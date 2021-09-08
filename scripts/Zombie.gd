extends KinematicBody2D

export var health = 3
var speed = 100
onready var raycast = $RayCast2D

func _physics_process(delta):
	if Global.Player == null:
		return
	
	var pos_to_plr = Global.Player.global_position - global_position
	pos_to_plr = pos_to_plr.normalized()
	move_and_collide(pos_to_plr * speed * delta)
	
	
	look_at(Global.Player.position)
	
	if raycast.is_colliding():
		var a = raycast.get_collider()
		if a.has_method("player_die"):
			a.player_die()

func die():
	if health == 0:
		queue_free()
