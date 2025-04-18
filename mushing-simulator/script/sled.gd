extends RigidBody3D

var target_position
var speed: float = 0.1
var max_speed := 7
var current_speed = 5
var acceleration := .0001

@onready var dog = get_parent().get_node("dog")


func _look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D) -> void:
	var forward_local_axis: Vector3 = Vector3(0, 0, -1)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step
		
func _drive(state: PhysicsDirectBodyState3D, current_transform: Transform3D) -> void:
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var distance = current_transform.origin.distance_to(target_position)
	if target_dir:
		if distance > 6:
			current_speed = min(current_speed + acceleration, max_speed)
		else:
			current_speed = max(current_speed - acceleration, 0)

		state.linear_velocity.x = target_dir.x * current_speed
		state.linear_velocity.z = target_dir.z * current_speed
		
	else:
		current_speed = max(current_speed - acceleration, 0)
		state.linear_velocity.x = move_toward(state.linear_velocity.x, 0, current_speed)
		state.linear_velocity.z = move_toward(state.linear_velocity.z, 0, current_speed)

func _set_target_position(position):
	target_position = position

func _integrate_forces(state):
	if target_position:
		_drive(state, global_transform, target_position)
		_look_follow(state, global_transform, target_position)
