extends Node

#@export var enemyPrefab : Array[PackedScene] = []
#var enemyPrefab = preload("res://GameElements/Enemy.tscn")
@export var enemyPrefab : PackedScene
@export var sceneCam : Camera2D
@export var moveToNode : Node2D
@export var scaleRange : float = 0.9

var spawnPoint : Vector2
var camPosition : Vector2
var camSize : Vector2

func _ready():
	pass
	
func _process(delta):
	if(Input.is_action_just_pressed("ui_select")):
		SpawnEnemy()


func GetRandomSpawnPoint() -> Transform2D:
	var spawnTransform : Transform2D
	if sceneCam != null:
		camPosition = sceneCam.global_position
		camSize = sceneCam.get_viewport_rect().size
		
		var spawnX = camPosition.x + randi_range(-camSize.x * scaleRange, camSize.x * scaleRange)
		var spawnY = camPosition.y + randi_range(-camSize.y * scaleRange, camSize.y * scaleRange)
		
		spawnPoint = Vector2(spawnX, spawnY)
		
	else:
		spawnPoint = Vector2.ZERO
	
	spawnTransform.origin = spawnPoint
	return spawnTransform
	
	
func SpawnEnemy():
	var  charBodyTesting = enemyPrefab.instantiate()
	
	charBodyTesting.transform = GetRandomSpawnPoint()
	
	add_child(charBodyTesting)
	print(moveToNode.transform)
	#charBodyTesting.MoveTowardsTransform(moveToNode.transform)
