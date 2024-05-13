extends "res://Scripts/EnemyBase.gd"

@export var bulletSpeed : float
@export var shootInterval : float
@export var bulletSpawnPoint: Transform2D

var playerNode
var targetPosition
var shootTimer : float = 0.0
var isMoving : bool = false
var canMove : bool = true
var canShoot : bool = true

func _ready():
	var rootNode = get_tree().get_root().get_child(0)
	playerNode = rootNode.get_node("Player")

func _physics_process(delta):
	
	MoveToRandomPoint()
	if isMoving:
		var direction = (targetPosition - global_position).normalized()
		
		velocity = direction * speed
		move_and_slide()
		CheckDistanceToTargetPos()
	else:
		if canShoot:
			shootTimer += delta
			if shootTimer >= shootInterval:
				FireBullet((playerNode.global_position - global_position).normalized(), global_position)
				shootTimer = 0.0
	pass

func MoveToRandomPoint():
	if canMove:
		var randomOffset = Vector2(randf_range(-250, 250), randf_range(-200, 200))
		targetPosition = playerNode.transform.origin + randomOffset
		
		isMoving = true

func CheckDistanceToTargetPos():
	if global_position.distance_to(targetPosition) <= 100:
		canMove = false
		isMoving = false
		velocity = Vector2.ZERO
