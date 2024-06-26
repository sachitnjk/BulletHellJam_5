extends "res://Scripts/EnemyBase.gd"

@export var gapBetweenShots: float = 1.5
var shootingTimer: float

func _ready():
	SetNewMoveTarget()
	shootingTimer = gapBetweenShots
	pass

func _physics_process(delta):
	if(global_position.distance_to(moveToTarget) <= 10):
		SetNewMoveTarget()
	HandleShoot(delta)
	
	MoveToTargetPosition()
	move_and_slide()
	ApplyDamgeCollisionCheck()
	
	HandleLookDirectionVisual()
	HandleFlickering(delta)
	pass
	
func HandleShoot(delta: float):
	shootingTimer -= delta
	if(shootingTimer <= 0):
		shootingTimer = gapBetweenShots
		var shootDirection = (player.global_position - global_position).normalized()
		FireBullet(shootDirection, global_position)
	pass

func SetNewMoveTarget():
	var targetX = randf_range(horizontalGameBoundLimits.x, horizontalGameBoundLimits.y)
	var targetY = randf_range(verticalGameBoundLimits.x, verticalGameBoundLimits.y)
	SetMoveToTargetPosition(Vector2(targetX, targetY))
	pass
