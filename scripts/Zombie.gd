extends KinematicBody2D

var player = null
export var health = 3
var speed = 100
onready var raycast = $RayCast2D

func _physics_process(delta):
	if player == null:
		return
	
	var pos_to_plr = player.global_position - global_position
	pos_to_plr = pos_to_plr.normalized()
	move_and_collide(pos_to_plr * speed * delta)
	
	look_at(player.position)
	
	#if raycast.is_colliding():
	#	var a = raycast.get_collider()
	#	if a.has_method("player_die"):
	#		a.player_die()

func die():
	if health == 0:
		queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null
