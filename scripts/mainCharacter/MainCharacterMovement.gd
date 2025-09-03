extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement (left/right)
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction != 0:
		velocity.x = direction * SPEED
		
		# Flip sprite if moving left
		if direction < 0:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false

		# Play run animation
		if not anim_sprite.is_playing() or anim_sprite.animation != "run":
			anim_sprite.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Play idle animation
		if not anim_sprite.is_playing() or anim_sprite.animation != "idle":
			anim_sprite.play("Idle")

	move_and_slide()
