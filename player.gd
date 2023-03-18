extends Node2D

@onready var player_skin: TextureRect = $PlayerSkin

var screen_size : Vector2

var move_speed := 700


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	var velocity := Vector2.ZERO
	
	if Input.is_action_pressed("key_left"):
		# move left
		velocity.x -= 1
	
	if Input.is_action_pressed("key_right"):
		# move right
		velocity.x += 1
	
	if Input.is_action_pressed("key_up"):
		# move up
		velocity.y -= 1
		
	if Input.is_action_pressed("key_down"):
		# move down
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity += velocity.normalized() * move_speed
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x - player_skin.size.x)
	position.y = clamp(position.y, 0, screen_size.y - player_skin.size.y)
