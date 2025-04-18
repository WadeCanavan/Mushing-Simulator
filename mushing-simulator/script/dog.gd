extends CharacterBody3D

var movement_speed: float = 5.0
var movement_target_position: Vector3 = Vector3(-10.182,10.588,639.201)
var points = [Vector3(-10.182,10.588,639.201), Vector3(460.024,52.878,440.403), Vector3(483.018,8.35,-267.611), Vector3(-345.715,43.259,-396.203), Vector3(-522.926,61.59,476.176)]
var index = 0
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(points[index])
	index += 1

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return
	elif navigation_agent.distance_to_target() < 10:
		set_movement_target(points[index])
		index += 1
		if index == points.size():
			index = 0

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
	var xform := transform # your transform
	if xform.origin != next_path_position:
		xform = xform.looking_at(next_path_position,Vector3.UP)
		transform = transform.interpolate_with(xform, 0.2)
