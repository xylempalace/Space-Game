extends CharacterBody2D

@export_subgroup("Health")
@export var START_HEALTH = 5
var _health = START_HEALTH

@export_subgroup("Movement")
@export var SPEED := 300.0
@export var SLOWDOWN := 300.0
	
# Damage the player by the specified amount
func takeDamage(amount: int):
	_health -= amount

# Begin keeping track of positions
func _beginCast():
	pass
	
# Called in response to the input event
func _input(event):
	if event.is_action("begin_cast"):
		_beginCast()

# Processes physics during the physics loop
func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("move_left", "move_right")
	var y_direction = Input.get_axis("move_up","move_down")
	
	# Normalize the input vector
	var direction = Vector2(x_direction, y_direction).normalized();
		
	# Handle regular movement.
	if (x_direction != 0):
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (y_direction != 0):
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SLOWDOWN)

	move_and_slide()
