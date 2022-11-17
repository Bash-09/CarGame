extends Area2D

var obs_tex1 = preload("res://assets/graphics/obs1.png")
var obs_tex2 = preload("res://assets/graphics/obs2.png")
var obs_tex3 = preload("res://assets/graphics/obs3.png")
var obs_tex4 = preload("res://assets/graphics/obs4.png")

export var movespeed = 330;

onready var obsSprite = get_node("Sprite")


func _ready():
	#This segment handles applying a random texture to the obstacle
	#I will need to add a bit 
	randomize()
	var myRand = randi()%4+1
	if myRand == 1:
		obsSprite.set_texture(obs_tex1)
	if myRand == 2:
		obsSprite.set_texture(obs_tex2)
	if myRand == 3:
		obsSprite.set_texture(obs_tex3)
	if myRand == 4:
		obsSprite.set_texture(obs_tex4)
	#I have no idea why this does not work properly, need to fix later, maybe hardcode idk
	#Get the size of the sprite
	var obsWitdth = obsSprite.texture.get_width()
	var obsHeight = obsSprite.texture.get_height()
	#Update the obstacle's collision shape to be the size of the sprite
	$CollisionShape2D.shape.extents.x = obsWitdth
	$CollisionShape2D.shape.extents.y = obsHeight
	
	


func _process(delta):
	#Yes very big brain ethan, multiplying by delta so that the object does not instantly
	#fly off the screen
	#Lmao we should increase the movespeed as time goes on, everything gets faster
	position.x -= movespeed * delta
	#Get rid of object if it leaves the screen
	if position.x < -200:
		queue_free()
	
#Controls what happens to the obstacle when being hit by the car
func destroy():
	hide()
	queue_free()
