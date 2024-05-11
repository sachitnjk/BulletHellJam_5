extends CharacterBody2D


@export var speed: float = 300.0
var stoppingSpeed: float = 0

func _ready():
	stoppingSpeed = speed/4


func _physics_process(delta):
	# var direction = Input.get_axis("ui_left", "ui_right")
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_down", "move_up"))
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, stoppingSpeed)
		velocity.y = move_toward(velocity.y, 0, stoppingSpeed)
	move_and_slide()
