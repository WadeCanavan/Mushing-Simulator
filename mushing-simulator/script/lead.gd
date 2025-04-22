extends Node3D

var children 

func _ready():
	children = get_children()

func _process(_delta: float) -> void:
	var index = 0
	for child in children:
		if child.name == "lead":
			#var target_position = children[7].global_transform.origin
			#var distance = $nav2.position.distance_to($lead.position)
			#child.set_target_position(target_position, distance)
			
			index += 1
