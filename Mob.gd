extends RigidBody2D


export var min_speed = 150
export var max_speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	var mobTypes = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mobTypes[randi() % mobTypes.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
