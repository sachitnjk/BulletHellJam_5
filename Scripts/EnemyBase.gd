extends CharacterBody2D 

@export var speed : float
@export var maxHealth : float

var currentHealth : float

func _ready():
	currentHealth = maxHealth

func TakeDamage():
	currentHealth - 1
	
#func MoveTowardsTransform(targetTransform : Transform2D):
	#pass
