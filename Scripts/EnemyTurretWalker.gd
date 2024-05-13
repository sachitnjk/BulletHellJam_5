extends "res://Scripts/EnemyBase.gd"

@export var enemyBullet : PackedScene

var playerNode
var targetPosition
var isMoving : bool = false
var canMove : bool = true

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
	#else:
		#ShootAtPlayer()
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

#func ShootAtPlayer():
	#var spawnedBullet = enemyBullet.instantiate()
	#add_child(spawnedBullet)
	#
	#var direction = (playerNode.global_position - global_position).normalized()
	#
