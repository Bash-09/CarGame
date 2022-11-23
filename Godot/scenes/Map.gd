extends Node

export(PackedScene) var Obstacle
export(PackedScene) var Boost


onready var screensize = get_viewport().get_visible_rect().size





# Called when the node enters the scene tree for the first time.
func _ready():
	$Obstacle.hide()
	$SpawnTimer.start()
	$BoostSpawnTimer.start()
	
	
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

func spawnBoost():
	var boost = preload("res://scenes/Boost.tscn").instance()
	boost.position = Vector2(screensize.x + 300,
	rand_range(0, screensize.y))
	add_child(boost)

func _on_SpawnTimer_timeout():
	for i in rand_range(1, 3):
		spawnObstacle()
		#spawnBoost()
	$SpawnTimer.wait_time = rand_range(1, 7)



func _on_PlayerCar_hit():
	pass


func _on_PlayerCar_boosting():
	pass # Replace with function body.


func _on_BoostSpawnTimer_timeout():
	spawnBoost()
	$BoostSpawnTimer.wait_time = rand_range(5,9)
