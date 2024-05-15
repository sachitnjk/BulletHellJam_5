extends Node

@export var scoreLabel: Label
@export var heartsArray: Array[Sprite2D] = []
var score: int
var heartIndex: int

func _ready():
	score = 0
	scoreLabel.text = str(score)
	heartIndex = heartsArray.size() - 1
	pass

func AddScore(amount: int):
	score += amount
	scoreLabel.text = str(score)
	pass

func PlayerHit():
	if(heartIndex > -1):
		heartsArray[heartIndex].visible = false
		heartIndex -= 1
	pass
