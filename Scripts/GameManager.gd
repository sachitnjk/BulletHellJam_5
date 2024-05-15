extends Node

@export var scoreLabel: Label

var score: int

func _ready():
	score = 0
	scoreLabel.text = str(score)
	pass

func AddScore(amount: int):
	score += amount
	scoreLabel.text = str(score)
	pass
