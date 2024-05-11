extends CharacterBody2D

const speed = 300.0

var moveToPoint : Vector2

func _physics_process(delta):
	var direction = sign(moveToPoint.x - global_position.x)
	
	if direction != 0:
		if direction > 0:
			velocity.x = speed
		else:
			velocity.x = -speed
	else:
		velocity.x = 0
	
	move_and_slide()


func MoveTowardsTransform(targetTransform : Transform2D):
	print("going here")
	moveToPoint = targetTransform.origin
