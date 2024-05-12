extends CharacterBody2D

const speed = 300.0

var moveToPoint : Vector2

func _physics_process(delta):
	var direction = moveToPoint - global_position
	direction = direction.normalized()
	
	velocity = direction * speed
	
	move_and_slide()


func MoveTowardsTransform(targetTransform : Transform2D):
	print("going here")
	moveToPoint = targetTransform.origin
