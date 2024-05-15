extends Node

@export var scoreLabel: Label
@export var heartsArray: Array[Sprite2D] = []
var heartIndex: int

func _ready():
	GameVars.score = 0
	scoreLabel.text = str(GameVars.score)
	heartIndex = heartsArray.size() - 1
	pass

func AddScore(amount: int):
	GameVars.score += amount
	scoreLabel.text = str(GameVars.score)
	pass

func PlayerHit():
	if(heartIndex > -1):
		heartsArray[heartIndex].visible = false
		heartIndex -= 1
	pass
