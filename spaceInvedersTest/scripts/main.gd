extends Node

export(PackedScene) var mob_scene
var score

#include <iostream>
#include <fstream>

res://file.txt

while (!eof())

name_array[400] = [];
# loop for j = 0 to 400
for j in [400]:
	print(name_array[j])



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$scoreTimer.stop()
	$mobTimer.stop()

func new_game():
	score = 0
	$player.start($startPosition.position)
	$startTimer.start()

func _on_scoreTimer_timeout():
	score += 1

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
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
