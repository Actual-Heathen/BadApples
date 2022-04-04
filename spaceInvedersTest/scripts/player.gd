extends Area2D
export (PackedScene) var fire_scene
signal hit

export var speed = 600
var screen_size


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	var direction = position.direction_to(mouse)
	var angle = atan2(direction.y,direction.x)
	rotation = angle + PI/2
	
	var fire = fire_scene.instance()
	fire.position = position + direction *10
	fire.rotation = rotation -PI/2
	fire.linear_velocity = direction*1200
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("shoot") && is_visible():
		get_parent().add_child(fire)
		$AudioStreamPlayer.play()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_body_entered(body):
	if (body.is_in_group("mobs")):
		hide() # Player disappears after being hit.
		emit_signal("hit")
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
