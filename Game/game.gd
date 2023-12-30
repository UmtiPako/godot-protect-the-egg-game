extends Node2D

@export var sperm_scene: PackedScene
@onready var spermHolder = $SpermHolder
@onready var spawnUL = $SpawnPositions/Spawn_UL
@onready var spawnUR = $SpawnPositions/Spawn_UR
@onready var spawnLL = $SpawnPositions/Spawn_LL
@onready var spawnLR = $SpawnPositions/Spawn_LR
@onready var spawn_x_positions = [spawnUL.position.x,spawnUR.position.x]
@onready var spawn_y_positions = [spawnUL.position.y,spawnLL.position.y]
@onready var spawn_timer = $"Spawn Timer"
@onready var music_list = ["ah_sana","alco","all_my_fellas","devil","moskau","smurf"]

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.death_by_sperm.connect(death_by_sperm)
	spawn_sperm(randf_range(-1,1))
	music_selector()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(GameManager.health)

func music_selector():
	$BgMusic.stream = load("res://Music/%s.mp3" % music_list[randf_range(0,6)])
	$BgMusic.play()	

func _on_bg_music_finished():
	music_selector()

func die():
	spawn_timer.stop()
	for sperm in spermHolder.get_children():
		sperm.set_physics_process(false)
	
func spawn_sperm(a):
	var y_pos
	var x_pos
	if a > 0:
		y_pos = spawn_y_positions[randi() % spawn_y_positions.size()]
		if y_pos == -50:
			x_pos = randf_range(spawnUL.position.x,spawnUR.position.x)
		else:
			x_pos = randf_range(spawnLL.position.x,spawnLR.position.x)
	else:
		x_pos = spawn_x_positions[randi() % spawn_x_positions.size()]
		if x_pos == -50:
			y_pos = randf_range(spawnUL.position.y,spawnLL.position.y)
		else:
			y_pos = randf_range(spawnUR.position.y,spawnLR.position.y)
	var new_sperms = sperm_scene.instantiate()
	new_sperms.position = Vector2(x_pos,y_pos)
	spermHolder.add_child(new_sperms)
	
func death_by_sperm():	
	die()

func _on_spawn_timer_timeout():
	spawn_sperm(randf_range(-1,1))

func _on_timer_timeout():
	GameManager.health += 1

func menstrualCheck():
	if $HUD/Timer.time_left != 0 and $HUD/Timer.time_left != null:
		$HUD/MenstrualTimer.text = "Menstrual Cycle: %d" % (int($HUD/Timer.time_left) % 60)
	else:
		$HUD/MenstrualTimer.text = "Menstrual Cycle: Deactive"


