extends CharacterBody2D 

@export var speed : float
@export var health : float = 6
#@export var enemyBullet : PackedScene

var moveToTarget: Vector2
var targetIsSet: bool = false

func TakeDamage():
	health = health - 1
	if(health <= 0):
		Die()
	pass

func Die():
	print("enemy Died")
	#do vfx or whatever here and also maybe sound
	queue_free()
	pass

func SetMoveToTargetPosition(target: Vector2):
	moveToTarget = target
	targetIsSet = true
	pass
	
func ClearMoveToTargetPosition():
	targetIsSet = false
	pass
	
func ApplyDamgeCollisionCheck():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if(collider.has_method("TakeDamage")):
			collider.TakeDamage()
			queue_free()
			break
			#tf idk why it finds 2 colliders on the player and applies damage twice so just breaking after applying damage once
	pass

#func ShootAtPlayer(startDirection : Vector2):
	#var spawnedBullet = enemyBullet.instantiate()
	#add_child(spawnedBullet)
	#
	#var direction = (playerNode.global_position - global_position).normalized()
	#spawnedBullet.global_position = global_position
	#spawnedBullet.SetMoveDirection(direction)
