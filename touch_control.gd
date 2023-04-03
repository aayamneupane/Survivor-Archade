extends Control

@onready var _base := $Base
@onready var _tip := $Tip

@onready var _base_radius = _base.size * _base.get_global_transform_with_canvas().get_scale() / 2
@onready var _base_default_position : Vector2 = _base.position
@onready var _tip_default_position : Vector2 = _tip.position

@export var deadzone_size : float = 10
@export var clampzone_size : float = 75

var _touch_index : int = -1
var _pressed := false
var _output := Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			if _is_point_inside_joystick_area(event.position) and _touch_index == -1:
					_touch_index = event.index
					_update_joystick(event.position)
					get_viewport().set_input_as_handled()
		
		elif event.index == _touch_index:
			_reset()
			get_viewport().set_input_as_handled()
	
	elif event is InputEventScreenDrag:
		if event.index == _touch_index:
			_update_joystick(event.position)
			get_viewport().set_input_as_handled()


func _is_point_inside_joystick_area(point: Vector2) -> bool:
	var x: bool = point.x >= global_position.x and point.x <= global_position.x + (size.x * get_global_transform_with_canvas().get_scale().x)
	var y: bool = point.y >= global_position.y and point.y <= global_position.y + (size.y * get_global_transform_with_canvas().get_scale().y)
	return x and y


func _update_joystick(touch_position: Vector2) -> void:
	var center : Vector2 = _base.global_position + _base_radius
	print(center)
	var vector : Vector2 = touch_position - center
	print("vector is : ", vector)
	
	vector = vector.limit_length(clampzone_size)
	_move_tip(center + vector)
	
	if vector.length() > deadzone_size:
		_pressed = true
		_output = (vector - (vector.normalized() * deadzone_size)) / (clampzone_size - deadzone_size)
	else:
		_pressed = false
		_output = Vector2.ZERO


func _move_tip(new_position: Vector2) -> void:
	if new_position.length() < 0:
		_tip.global_position = new_position + _tip.pivot_offset * _base_radius
	else:
		_tip.global_position = new_position - _tip.pivot_offset * _base_radius


func _reset():
	_pressed = false
	_output = Vector2.ZERO
	_touch_index = -1
	_base.position = _base_default_position
	_tip.position = _tip_default_position


func get_velocity() -> Vector2:
	var joy_stick_vel : Vector2 
	joy_stick_vel.x = _tip.position.x / clampzone_size
	joy_stick_vel.y = _tip.position.y / clampzone_size
	
	return joy_stick_vel
