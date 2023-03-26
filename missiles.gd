extends Area2D

var speed := 500
var steering_force := 30.0

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO

var target : Player


func initialize(p_target : Player) -> void:
	target = p_target
	position = Vector2.ZERO
	velocity = p_target.position.normalized() * speed


func _physics_process(delta: float) -> void:
	acceleration += _seek()
	velocity += acceleration * delta
	
	velocity = velocity.limit_length(speed)
	
	rotation = velocity.angle()
	position += velocity * delta


func _seek() -> Vector2:
	var steer = Vector2.ZERO
	var desired : Vector2
	
	if target:
		var direction = global_position.direction_to(target.global_position)
		desired = direction * speed
		steer = (desired - velocity).normalized() * steering_force
	
	return steer
