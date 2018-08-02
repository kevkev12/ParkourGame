extends KinematicBody

var SPEED = 600
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
		
	direction = direction.normalized()
	direction = direction * SPEED * delta
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 10
	
	var HITCOUNT = get_slide_count()
	if HITCOUNT > 0:
		var collision = get_slide_collision(0)
		if collision.collider is RigidBody:
			collision.collider.apply_impulse(collision.position, -collision.normal)

func points():
	if KinematicBody.entersBox:
		pass