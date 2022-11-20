extends Area2D

export var movespeed = 330;

func _ready():
	pass
	

func _process(delta):
	#Yes very big brain ethan, multiplying by delta so that the object does not instantly
	#fly off the screen
	#Lmao we should increase the movespeed as time goes on, everything gets faster
	position.x -= movespeed * delta
	#Get rid of object if it leaves the screen
	if position.x < -200:
		queue_free()
	
