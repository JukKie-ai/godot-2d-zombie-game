extends KinematicBody2D

export var health = 3
export var speed = 300
export var bullet_speed = 1000
export var fire_rate = 0.2
var can_fire = true


var movement = Vector2()
var bullet = preload("res://scenes/Bullet.tscn")

func _ready():
	Global.Player = self

func _exit_tree():
	Global.Player = null

func _physics_process(delta):
	movement = Vector2()
	
	if Input.is_action_pressed("up"):
		movement.y -= 1
	if Input.is_action_pressed("down"):
		movement.y += 1
	if Input.is_action_pressed("left"):
		movement.x -= 1
	if Input.is_action_pressed("right"):
		movement.x += 1
	
	movement = movement.normalized() * speed
	movement = move_and_slide(movement)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		
		can_fire = false
		
		yield(get_tree().create_timer(fire_rate), "timeout")
		
		can_fire = true

func player_die():
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if body.is_in_group("zombie"):
		health -= 1
		get_parent().find_node("UI").find_node("HealthSprite").frame -= 1
		if health <= 0:
			player_die()
