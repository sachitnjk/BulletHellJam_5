extends "res://Scripts/EnemyBase.gd"

@export var gapBetweenShots: float = 1.5
@export var horizontalWanderLimits: Vector2
@export var verticalWanderLimits: Vector2
var shootingTimer: float
var playerTransform: Node2D

func _ready():
	SetNewMoveTarget()
	shootingTimer = gapBetweenShots
	playerTransform = get_tree().get_root().get_child(0).get_node("Player")
	pass

func _physics_process(delta):
	if(global_position.distance_to(moveToTarget) <= 10):
		SetNewMoveTarget()
	HandleShoot(delta)
	MoveToTargetPosition()
	move_and_slide()
	ApplyDamgeCollisionCheck()
	pass
	
func HandleShoot(delta: float):
	shootingTimer -= delta
	if(shootingTimer <= 0):
		shootingTimer = gapBetweenShots
		var shootDirection = (playerTransform.global_position - global_position).normalized()
		FireBullet(shootDirection, global_position)
	pass

func SetNewMoveTarget():
	var targetX = randf_range(horizontalWanderLimits.x, horizontalWanderLimits.y)
	var targetY = randf_range(verticalWanderLimits.x, verticalWanderLimits.y)
	SetMoveToTargetPosition(Vector2(targetX, targetY))
	pass
