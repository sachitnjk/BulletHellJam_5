extends CharacterBody2D

@export var health: int = 3
@export var speed: float = 300.0
@export var onHitInvincibilityTime: float = 1.5
@export var shootLineLength: float = 60.0
@export var shootDirectionLine: Line2D
@export var bulletScene: PackedScene
@export var animatedSprite: AnimatedSprite2D
@export var playerDeathTimer: Timer
@export var playerCollider : CollisionShape2D
var stoppingSpeed: float = 0
var dead: bool = false
var isInvincible: bool = false
const flickerGap: float = 0.1
var flickerTimer: float = 0.0
var invincibilityTimer: float = 0.0

const LINE_END_POINT_INDEX: int = 1
@onready var gameManager = %GameManager

func _ready():
	stoppingSpeed = speed/4
	pass

func _physics_process(delta):
	if(dead):
		return
		
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_down", "move_up"))
	if (direction):
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, stoppingSpeed)
		velocity.y = move_toward(velocity.y, 0, stoppingSpeed)
	var directionToMouse = (get_global_mouse_position() - shootDirectionLine.global_position).normalized()
	shootDirectionLine.points[LINE_END_POINT_INDEX] = directionToMouse * shootLineLength
	move_and_slide()
	if(Input.is_action_just_pressed("shoot")):
		FireBullet(directionToMouse)
	if(isInvincible):
		invincibilityTimer += delta
		if(invincibilityTimer > onHitInvincibilityTime):
			DeactivateInvincible()
	HandleVisuals(direction.x, delta)
	pass

func HandleVisuals(xDirectionInput: float, delta: float):
	if(xDirectionInput < 0):
		animatedSprite.flip_h = true
	elif(xDirectionInput > 0):
		animatedSprite.flip_h = false
	
	if(velocity.length() != 0):
		animatedSprite.play("moving")
	else:
		animatedSprite.play("idle")
		
	if(isInvincible):
		flickerTimer += delta
		if(flickerTimer >= flickerGap):
			animatedSprite.visible = !animatedSprite.visible
			flickerTimer = 0.0
	pass
	
func FireBullet(direction: Vector2):
	var spawnnedBullet = bulletScene.instantiate()
	var rootNode = get_tree().get_root().get_child(GameVars.ROOT_NODE_CHILD_INDEX)
	rootNode.add_child(spawnnedBullet)
	spawnnedBullet.global_position = shootDirectionLine.global_position
	spawnnedBullet.SetMoveDirection(direction)
	pass


func TakeDamage():
	if(dead || isInvincible):
		return
	if(gameManager != null):
			gameManager.PlayerHit()
	health = health - 1
	if(health == 0):
		dead = true
		playerCollider.disabled = true
		shootDirectionLine.visible = false
		animatedSprite.play("death")
		if(playerDeathTimer != null):
			playerDeathTimer.start()
	else:
		ActivateInvincible()
	pass

func ActivateInvincible():
	isInvincible = true
	animatedSprite.visible = false
	invincibilityTimer = 0
	flickerTimer = 0
	pass

func DeactivateInvincible():
	animatedSprite.visible = true
	isInvincible = false
	pass

func PlayerDeathTimerTimeout():
	get_tree().change_scene_to_file("res://Levels/GameOver.tscn")
	pass
