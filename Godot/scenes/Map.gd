extends Node

export(PackedScene) var Obstacle
onready var screensize = get_viewport().get_visible_rect().size







# Called when the node enters the scene tree for the first time.
func _ready():
	$Obstacle.hide()
	$SpawnTimer.start()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Made it so that we can just press esc to quit
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()
	

func spawnObstacle():
	#Instances a new obstacle
	var obstacle = Obstacle.instance()
	#Set position
	obstacle.position = Vector2(screensize.x + 300,
	rand_range(0, screensize.y))
	add_child(obstacle)


func _on_SpawnTimer_timeout():
	for i in rand_range(1, 3):
		spawnObstacle()
	$SpawnTimer.wait_time = rand_range(1, 7)


func _on_PlayerCar_hit():
	pass
