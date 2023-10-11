extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("Container/AnimatedSprite2D");
@onready var container = get_node("Container");

func _physics_process(delta):
	# Thêm trọng lực
	if not is_on_floor():
		velocity.y += gravity * delta

	# Nhảy
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Di chuyển trái phải
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1 or direction == -1:
		velocity.x = direction * SPEED
		container.scale.x = direction;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation
	if not is_on_floor():
		anim.play("jump");
	elif direction == 1 or direction == -1 :
		anim.play("run");
	else:
		anim.play("idle");
	move_and_slide()
