extends Sprite

var max_velocity = 500
var acceleration = 300
var deceleration_rate = 0.95
var turn_rate = 3
#Exported some variables so we can easily tweak if needed
export var movespeed = 300;

var velocity: Vector2 = Vector2.ZERO

func _ready():
	velocity.x = 400

func _process(delta):
	
	move(delta)
	
	
	
	
func move(delta):
	# Check input
	var drifting: bool = Input.is_mouse_button_pressed(2)
	var accelerating: bool = Input.is_mouse_button_pressed(1)
	
	# Find some stuff about where we want to drive towards
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Clamp target position to be in front of the car to avoid driving backwards
	if mouse_pos.x < position.x:
		mouse_pos.x = position.x
	
	var target_vector: Vector2 = (mouse_pos - position).normalized()
	var facing_vector: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	var turn: float = facing_vector.angle_to(target_vector)
	
	# Accelerate
	if accelerating:
		if velocity.length_squared() < 1:
			velocity += Vector2.RIGHT.rotated(rotation) * acceleration * delta
		else:
			velocity += velocity.normalized() * acceleration * delta
		
		velocity = velocity.rotated(turn * delta * turn_rate)
		if velocity.length_squared() > max_velocity * max_velocity:
			velocity = velocity.normalized() * max_velocity
	else:
		velocity -= velocity * deceleration_rate * delta
	
	# Move
	position += velocity * delta;
	rotation = velocity.angle()
	
	# Just simulates a scrolling screen
	position.x -= movespeed * delta
	
