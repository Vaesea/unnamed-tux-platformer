extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
		
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		
	if Input.is_anything_pressed()==false and is_on_floor():
		$AnimatedSprite2D.play("stand")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions. I'm not doing this at the moment.
	var direction := Input.get_axis("ui_left", "ui_right") # no idea what this does!
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			$AnimatedSprite2D.play("walk") # WALK NOW
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_wall(): # dumb idiot you're moving against a wall
		$AnimatedSprite2D.play("stand") # you must stand
		
	if velocity.x == 0: # you aren't moving.
		$AnimatedSprite2D.play("stand")

	move_and_slide()
