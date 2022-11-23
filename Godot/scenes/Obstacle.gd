extends Area2D

export var movespeed = 300;

const images = [
	preload("res://assets/graphics/obs1.png"),
	preload("res://assets/graphics/obs2.png"),
	preload("res://assets/graphics/obs3.png"),
	preload("res://assets/graphics/obs4.png")
]

func _ready():
	var chosenTexture = images[randi()%images.size()]
	
	$Sprite.set_texture(chosenTexture)
	$CollisionShape2D.shape.set_extents(chosenTexture.get_size() / 2)
	

func _process(delta):
	#Yes very big brain ethan, multiplying by delta so that the object does not instantly
	#fly off the screen
	#Lmao we should increase the movespeed as time goes on, everything gets faster
	position.x -= movespeed * delta
	#Get rid of object if it leaves the screen
	if position.x < -$Sprite.texture.get_width():
		queue_free()
	

#Controls what happens to the obstacle when being hit by the car
func destroy():
	
	hide()
	queue_free()
	
