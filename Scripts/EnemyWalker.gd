extends "res://Scripts/EnemyBase.gd"

var playerNode

func _ready():
	var rootNode = get_tree().get_root().get_child(0)
	playerNode = rootNode.get_node("Player")
	

func _process(delta):
	if playerNode != null:
		moveToTarget = playerNode.transform.origin
	
	var direction = moveToTarget - global_position
	direction = direction.normalized()
	
	velocity = direction * speed
	
	move_and_slide()
	ApplyDamgeCollisionCheck()
