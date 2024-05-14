extends "res://Scripts/EnemyBase.gd"

@export var gapBetweenShots: float = 1.5
var shootingTimer: float
var playerTransform: Node

func _ready():
	SetNewMoveTarget()
	shootingTimer = gapBetweenShots
	playerTransform = get_tree().get_root().get_child(0).get_node("Player")
	pass

func _physics_process(delta):
	MoveToTargetPosition()
	move_and_slide()
	if(global_position.distance_to(moveToTarget) <= 10):
		SetNewMoveTarget()
	pass
	
func HandleShoot():
	pass

func SetNewMoveTarget():
	pass
