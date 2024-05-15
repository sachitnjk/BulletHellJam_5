extends "res://Scripts/EnemyBase.gd"

@export var bulletSpeed : float
@export_range(0.1, 2) var shootInterval : float
@export_range(0.1, 5) var rotationIncrementRate : float

var shootTimer : float = 0.0
var canShoot : bool = false
var fireDirection : Vector2 = Vector2(1, 0)

func _ready():
	fireDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	MoveToRandomPoint()

func _physics_process(delta):
	if targetIsSet:
		MoveToTargetPosition()
		move_and_slide()
		HandleLookDirectionVisual()
		CheckDistanceToTargetPos()
	elif canShoot:
		DirectionRotator()
		shootTimer += delta
		if shootTimer >= shootInterval:
			FireBullet(fireDirection, global_position)
			shootTimer = 0.0
	HandleFlickering(delta)
	pass

# THIS FUNCTION NEED CHANGING; SHOULD NOT CALL EVERY FRAME AND THE
# POSITION SELECTION SHOULD BE FIXED CAN LEAVE IT TOO
func MoveToRandomPoint():
	var randomOffset = Vector2(randf_range(-30, 30), randf_range(-30, 30))
	var target = player.transform.origin + randomOffset
	if(!IsInGameBounds(target)):
		target = player.global_position
	SetMoveToTargetPosition(target)

func DirectionRotator():
	var rotationAngle = rotationIncrementRate * get_physics_process_delta_time()
	fireDirection = fireDirection.rotated(rotationAngle)

func CheckDistanceToTargetPos():
	var stoppingForPlayer = IsInGameBounds(global_position) && (global_position.distance_to(player.global_position) <= 200)
	if (global_position.distance_to(moveToTarget) <= 100 || stoppingForPlayer):
		ClearMoveToTargetPosition()
		canShoot = true
		velocity = Vector2.ZERO
		animatedSprite.play("idle")
