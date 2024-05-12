extends Area2D

@export var moveSpeed: float = 250
@export var lifeTimeTimer: float = 6.0

const DIRECTION_SETTING_OFFSET: int = 5

func _process(delta):
	lifeTimeTimer -= delta
	if(lifeTimeTimer < 0.0):
		queue_free()
	global_position += global_transform.x * (moveSpeed * delta)
	pass
	
func SetMoveDirection(direction: Vector2):
	look_at(global_position + direction * DIRECTION_SETTING_OFFSET)
	pass

func OnBodyEnter(body):
	body.TakeDamage()
	pass
