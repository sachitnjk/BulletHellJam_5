extends "res://Scripts/EnemyBase.gd"

func _process(delta):
	if player != null:
		SetMoveToTargetPosition(player.transform.origin)
	
	MoveToTargetPosition()
	move_and_slide()
	ApplyDamgeCollisionCheck()
	HandleLookDirectionVisual()
