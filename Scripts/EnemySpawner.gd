extends Node

#@export var enemyPrefab : Array[PackedScene] = []
#var enemyPrefab = preload("res://GameElements/Enemy.tscn")
@export var enemyPrefab : PackedScene
@export var sceneCam : Camera2D
@export var moveToNode : Node2D
@export var scaleRange : float = 0.9

@export_range(0.1, 30) var initialSpawnDelay : float
@export_range(0.5, 20) var delayBetweenSpawns : float

var initialSpawnTimer : float = 0.0
var spawnTimer : float = 0.0
var hasStarterSpawn : bool = false
var spawnPoint : Vector2
var camPosition : Vector2
var camSize : Vector2

func _ready():
	pass
	
func _process(delta):
	if !hasStarterSpawn:
		initialSpawnTimer += delta
	elif hasStarterSpawn:
		spawnTimer += delta
	
	#if(Input.is_action_just_pressed("ui_select")):
	EnemySpawnCheck()


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
	
	
func EnemySpawnCheck():
	if initialSpawnTimer >= initialSpawnDelay:
		initialSpawnTimer = 0.0
		hasStarterSpawn = true
		SpawnEnemy()
	
	if spawnTimer >= delayBetweenSpawns:
		spawnTimer = 0.0
		SpawnEnemy()

func SpawnEnemy():
	var  charBodyTesting = enemyPrefab.instantiate()
	charBodyTesting.transform = GetRandomSpawnPoint()
	add_child(charBodyTesting)
