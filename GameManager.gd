extends Node2D

signal death_by_sperm
signal menstruation_start
signal on_score_updated
var health = 1
var score = 0
var high_score = 0

func get_score() -> int:
	return score

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
