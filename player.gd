extends Node2D
#
class_name Player

var speed = 700
#export (NodePath) var joystickLeftPath
#onready var joystickLeft : VirtualJoystick = get_node(joystickLeftPath)
#
#export var speed : float = 100
#
#export (NodePath) var joystickRightPath
#onready var joystickRight : VirtualJoystick = get_node(joystickRightPath)
#
#func _process(delta: float) -> void:
##	# Movement using the joystick output:
##	if joystickLeft and joystickLeft.is_pressed():
##		position += joystickLeft.get_output() * speed * delta
#
#	# Movement using Input functions:
#	var move := Vector2.ZERO
#	move.x = Input.get_axis("ui_left", "ui_right")
#	move.y = Input.get_axis("ui_up", "ui_down")
#	position += move * speed * delta
#
#	# Rotation:
#	if joystickRight and joystickRight.is_pressed():
#		rotation = joystickRight.get_output().angle()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	
	position += velocity
