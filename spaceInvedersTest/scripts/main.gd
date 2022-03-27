extends Node

export(PackedScene) var mob_scene
var score
var array
var nCount = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var music = $music
	music.playing = true
	var data = File.new()
	data.open("res://file.txt",File.READ)
	var add = data.get_line()
	array = [add]
	while data.get_position() < data.get_len():
		add = data.get_line()
		array.append(add)
		print(array[nCount])
	data.close()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$HUD.show_game_over()
	$scoreTimer.stop()
	$mobTimer.stop()

func new_game():

	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$player.start($startPosition.position)
	$startTimer.start()
	get_tree().call_group("mobs", "queue_free")

func _on_scoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_startTimer_timeout():
	$mobTimer.start()
	$scoreTimer.start()
	
func _on_mobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var rMult = rand_range(.5,3)
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)*rMult
	mob.linear_velocity = velocity.rotated(direction)
	mob.id = array[nCount]
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	nCount += 1
	if nCount >= array.size():
		nCount = 0
