extends Node2D

signal death_by_sperm
signal menstruation_start
signal on_score_updated
var health = 1
var score = 0
var high_score = 0

var game: PackedScene = preload("res://Game/game.tscn")
var menu: PackedScene = preload("res://MainMenu/main_menu.tscn")

func get_score() -> int:
	return score

func save():
	var saved_highscore = GameManager.high_score
	return saved_highscore
	
func save_game():
	var save_game = FileAccess.open("user://savegame.save",FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_game = FileAccess.open("user://savegame.save",FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		high_score = node_data

func reset():
	health = 1
	score = 0
	
func load_game_scene():
	get_tree().change_scene_to_packed(game)

func load_menu():
	get_tree().change_scene_to_packed(menu)

func healthUp(a):
	health += a
	
func healthDown(a):
	health -= a
	
func getHealth():
	return health		

func set_score(v: int):
	score = v
	if score > high_score:
		high_score = score
	on_score_updated.emit()

func increment_score():
	set_score(score + 1)
