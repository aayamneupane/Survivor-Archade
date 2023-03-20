extends Area2D

var speed := 300
var steering_force := 30.0

var velocity := Vector2.ZERO
var acceleration := Vector2.ZERO

var target : Player


func initialize(p_target : Player) -> void:
	target = p_target
	global_position.x = target.global_position.x


func _physics_process(delta: float) -> void:
	pass
