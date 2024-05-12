extends Area2D

@export var moveSpeed: float = 250

const DIRECTION_SETTING_OFFSET: int = 5

func _process(delta):
	look_at(get_global_mouse_position())
	global_position += global_transform.x * (moveSpeed * delta)
	pass
	
func SetMoveDirection(direction: Vector2):
	look_at(global_position + direction * DIRECTION_SETTING_OFFSET)
	pass

