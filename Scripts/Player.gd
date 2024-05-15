extends CharacterBody2D

@export var health: int = 3
@export var speed: float = 300.0
@export var shootLineLength: float = 60.0
@export var shootDirectionLine: Line2D
@export var bulletScene: PackedScene
@export var animatedSprite: AnimatedSprite2D
@export var playerDeathTimer: Timer
var stoppingSpeed: float = 0

const LINE_END_POINT_INDEX: int = 1

func _ready():
	stoppingSpeed = speed/4
	pass

func _physics_process(delta):
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
	HandleVisuals(direction.x)
	pass

func HandleVisuals(xDirectionInput: float):
	if(xDirectionInput < 0):
		animatedSprite.flip_h = true
	elif(xDirectionInput > 0):
		animatedSprite.flip_h = false
	
	if(velocity.length() != 0):
		animatedSprite.play("moving")
	else:
		animatedSprite.play("idle")
	pass
	
func FireBullet(direction: Vector2):
	var spawnnedBullet = bulletScene.instantiate()
	var rootNode = get_tree().get_root().get_child(1)
	rootNode.add_child(spawnnedBullet)
	spawnnedBullet.global_position = shootDirectionLine.global_position
	spawnnedBullet.SetMoveDirection(direction)
	pass


func TakeDamage():
	health = health - 1
	if(health == 0):
		if(playerDeathTimer != null):
			playerDeathTimer.start()
	else:
		print("current player hp:")
		print(health)
	pass


func PlayerDeathTimerTimeout():
	get_tree().change_scene_to_file("res://Levels/GameOver.tscn")
	pass
