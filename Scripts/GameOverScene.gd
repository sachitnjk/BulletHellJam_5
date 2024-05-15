extends Control

@export var scoreLabel: Label

func _ready():
	scoreLabel.text = str(GameVars.score)
	pass


func OnReturnToMenuPressed():
	get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")
	pass

func OnPlayAgainPressed():
	get_tree().change_scene_to_file("res://Levels/Game.tscn")
	pass
