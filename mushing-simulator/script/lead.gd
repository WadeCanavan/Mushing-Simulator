extends Node3D

var children 

func _ready():
	children = get_children()

func _process(_delta: float) -> void:
	var index = 0
	for child in children:
		if child.name != "nav":
			var target_position = children[index].global_transform.origin
			child.set_target_position(target_position)
			
			index += 1
