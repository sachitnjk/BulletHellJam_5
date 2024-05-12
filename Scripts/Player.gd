extends CharacterBody2D


@export var speed: float = 300.0
@export var shootLineLength: float = 60.0
@export var shootDirectionLine: Line2D
var stoppingSpeed: float = 0

const LINE_END_POINT_INDEX: int = 1

func _ready():
	stoppingSpeed = speed/4

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_down", "move_up"))
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, stoppingSpeed)
		velocity.y = move_toward(velocity.y, 0, stoppingSpeed)
	var directionToMouse = (get_global_mouse_position() - shootDirectionLine.global_position).normalized()
	shootDirectionLine.points[LINE_END_POINT_INDEX] = directionToMouse * shootLineLength
	
	move_and_slide()
