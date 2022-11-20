extends Area2D

signal hit

var max_velocity = 450
var acceleration = 250
var deceleration_rate = 0.95
var turn_rate = 4
#Exported some variables so we can easily tweak if needed
export var movespeed = 300;

var velocity: Vector2 = Vector2.ZERO
var was_drifting: bool = false;

func _ready():
	velocity.x = 800

func _process(delta):
	move(delta)
	
	
func move(delta):
	# Check input
	var drifting: bool = Input.is_mouse_button_pressed(2)
	var accelerating: bool = Input.is_mouse_button_pressed(1)
	
	if drifting:
		was_drifting = true
	
	# Find some stuff about where we want to drive towards
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Clamp target position to be in front of the car to avoid driving backwards
#	if mouse_pos.x < position.x:
#		mouse_pos.x = position.x
	
	var target_vector: Vector2 = (mouse_pos - position).normalized()
	var facing_vector: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	var turn: float = facing_vector.angle_to(target_vector)
	
	if accelerating:
		# Accelerate
		if velocity.length_squared() < 1:
			velocity += Vector2.RIGHT.rotated(rotation) * acceleration * delta
		else:
			velocity += facing_vector * acceleration * delta
		
		# Turn the vehicle a bit
		rotation += turn * delta * turn_rate
		
		if drifting:
			# Reduce how much our velocity turns with us and add some acceleration in the direction we are actually facing
			velocity = velocity.rotated(turn * delta * turn_rate / 2)
			velocity += facing_vector * acceleration * delta
			velocity -= velocity.normalized() * facing_vector * acceleration * delta
		
		else:
			# Turn our vehicle's velocity to match the vehicle itself turning
			velocity = velocity.rotated(turn * delta * turn_rate)
			# Reduce velocity in directions that aren't where we are facing
			var normal = Vector2.RIGHT.rotated(rotation + PI/2)
			normal *= velocity.dot(normal)
			velocity -= normal * delta * 5
			
		# Bring velocity back down to max_velocity
		if velocity.length_squared() > (max_velocity * max_velocity):
			velocity -= velocity.normalized() * delta * max_velocity
	
	else:
		# Decelerate
		velocity -= velocity * deceleration_rate * delta
	
	
	# Move
	position += velocity * delta;
	
	# Just simulates a scrolling screen
	position.x -= movespeed * delta
	
	
func die():
	#Will do some sort of hurt animation, something
	pass

#Hit detection
func _on_Player_area_entered(area):
	#If the player hits an obstacle, currently just removes the obstacle
	if area.is_in_group("obstacles"):
		emit_signal("hit")
		die()
		area.destroy()
		
	if area.is_in_group("boosts"):
		velocity = velocity * 2
		
