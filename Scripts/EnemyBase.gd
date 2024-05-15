extends CharacterBody2D 

@export var speed : float = 40
@export var health : float = 6
@export var enemyDeathScore: int = 2
@export var enemyBullet : PackedScene
@export var deathSmoke : PackedScene
@export var animatedSprite: AnimatedSprite2D
@export var horizontalGameBoundLimits: Vector2 = Vector2(-527, 527)
@export var verticalGameBoundLimits: Vector2 = Vector2(-276, 276)

var moveToTarget: Vector2
var targetIsSet: bool = false
var isFlickering: bool = false
const flickerGap: float = 0.05
var flickerTimer: float = 0.0
const hitEffectTime = 0.1
var hitEffectTimer: float = 0.0

@onready var player = %Player
@onready var gameManager = %GameManager
@onready var sfxPlayer = %EnemyDeathSFXAudioPlayer

func TakeDamage():
	health = health - 1
	if(health <= 0):
		Die()
	else:
		hitEffectTimer = 0.0
		isFlickering = true
	pass

func Die():
	if(sfxPlayer != null):
		print("asdadadads")
		sfxPlayer.play()
	else:
		print("goin back to unity fk this")
	
	if(gameManager != null):
		gameManager.AddScore(enemyDeathScore)
	if(deathSmoke != null):
		var smoke = deathSmoke.instantiate()
		var rootNode = get_tree().get_root().get_child(GameVars.ROOT_NODE_CHILD_INDEX)
		rootNode.add_child(smoke)
		smoke.global_position = global_position
	queue_free()
	pass

func MoveToTargetPosition():
	var direction = (moveToTarget - global_position).normalized()
	velocity = direction * speed

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
			Die()
			break
			#tf idk why it finds 2 colliders on the player and applies damage twice so just breaking after applying damage once
	pass

func FireBullet(direction: Vector2, spawnPoint: Vector2):
	var spawnnedBullet = enemyBullet.instantiate()
	var rootNode = get_tree().get_root().get_child(GameVars.ROOT_NODE_CHILD_INDEX)
	rootNode.add_child(spawnnedBullet)
	spawnnedBullet.global_position = spawnPoint
	spawnnedBullet.SetMoveDirection(direction)
	pass

func IsInGameBounds(positionToCheck: Vector2):
	var isInBounds = (positionToCheck.x > horizontalGameBoundLimits.x) && (positionToCheck.x < horizontalGameBoundLimits.y)
	if(isInBounds && (positionToCheck.y > verticalGameBoundLimits.x) && (positionToCheck.y < verticalGameBoundLimits.y)):
		isInBounds = true;
	else:
		isInBounds = false
	return isInBounds
	
func HandleLookDirectionVisual():
	if(velocity.x > 0):
		animatedSprite.flip_h = false
	elif(velocity.x < 0):
		animatedSprite.flip_h = true

func HandleFlickering(delta: float):
	if(isFlickering):
		flickerTimer += delta
		if(flickerTimer >= flickerGap):
			flickerTimer = 0.0
			if(animatedSprite.modulate.g == 1):
				animatedSprite.modulate = Color(1, 0, 0, 1)
			else:
				animatedSprite.modulate = Color(1, 1, 1, 1)
		
		hitEffectTimer += delta
		if(hitEffectTimer >= hitEffectTime):
			animatedSprite.modulate = Color(1, 1, 1, 1)
			isFlickering = false
