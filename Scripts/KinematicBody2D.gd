extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 400
const GRAVITY = 40
const JUMPFORCE = -1100

func _physics_process(delta):
	# right and left movement
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("Walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("Walk")
		$Sprite.flip_h = true
	else: $Sprite.play("idle")
	if not is_on_floor():
		$Sprite.play("Air")

	# move and slide for movement and define upward ground
	velocity = move_and_slide(velocity, Vector2.UP)
	#lerp to make movement in x direction smoother
	velocity.x = lerp(velocity.x, 0 , 0.16)
	
	# jump movement
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		
		

	
	# const downard gravity
	velocity.y += GRAVITY
	
#to respawn player at start if they fall
func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Scenes/Level.tscn")
