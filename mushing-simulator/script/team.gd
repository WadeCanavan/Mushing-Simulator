extends Node3D

@onready var parent = get_parent() as PathFollow3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent.progress_ratio = randf()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if parent is PathFollow3D:
		parent.set_progress(parent.getprogress() + 200 * delta)
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
