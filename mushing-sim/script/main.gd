extends Node3D

@onready var sled = $sled
@onready var dog = $dog

var max_speed := 5000
var current_speed := 2000
var acceleration := 1


func _ready():
	pass

func _process(delta: float) -> void:
	var mid_pos = Vector3(dog.global_position.x, dog.global_position.y - 4, dog.global_position.z)
	var direction = sled.position.direction_to(mid_pos)
	var distance = sled.position.distance_to(mid_pos)
	
	if direction and distance > 8 :
		current_speed = min(current_speed + acceleration, max_speed)
		print(current_speed * delta)

		sled.apply_central_force( Vector3(direction.x , 0, direction.z ) * current_speed * delta)
	else:
		current_speed = max(current_speed - acceleration, 0)
		sled.apply_central_force( Vector3(direction.x , 0, direction.z ) * current_speed * delta)
	$sled/sled/midLine.look_at(mid_pos)
