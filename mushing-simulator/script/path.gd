extends Path3D

var inc=0
var speed=10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inc+=delta*speed
	$Sled.progress = inc
	$Wheel.progress = inc + 7
