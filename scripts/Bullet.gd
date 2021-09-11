extends RigidBody2D

var explosion = preload("res://scenes/Explosion.tscn")


func _on_Bullet_body_entered(body):
	if body.is_in_group("zombie"):
		body.health -= 1
		body.die()
		queue_free()
		if body.health == 0:
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_position()
			get_tree().get_root().add_child(explosion_instance)
			queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	queue_free()
