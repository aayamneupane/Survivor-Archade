extends ParallaxBackground

var speed: int = 300
var rotation_speed: float = 0.3
#var direction = Vector2(0, 1)


func _process (delta) :
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
	
#	position += velocity
	
	scroll_offset += velocity * speed * delta
	velocity = velocity.rotated( rotation_speed * delta)
