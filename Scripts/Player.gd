extends CharacterBody2D

@export var speed: float = 300.0
@export var shootLineLength: float = 60.0
@export var shootDirectionLine: Line2D
@export var bulletScene: PackedScene
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
	pass
	
func FireBullet(direction: Vector2):
	var spawnnedBullet = bulletScene.instantiate()
	var rootNode = get_tree().get_root().get_child(0)
	rootNode.add_child(spawnnedBullet)
	spawnnedBullet.global_position = shootDirectionLine.global_position
	spawnnedBullet.SetMoveDirection(direction)
	pass


func TakeDamage():
	print("The Player")
	pass
