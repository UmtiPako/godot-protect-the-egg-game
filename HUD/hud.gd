extends CanvasLayer

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.menstruation_start.connect(menstruation_start)
	GameManager.on_score_updated.connect(on_score_updated)
	GameManager.death_by_sperm.connect(death_by_sperm)

func menstruation_start():
	timer.start()

func death_by_sperm():
	timer.stop()

func _on_timer_timeout():
	GameManager.health += 1

func menstrualCheck():
	if timer.time_left != 0 and timer.time_left != null:
		$MenstrualTimer.text = "Menstrual Cycle: %d" % (int(timer.time_left) % 60)
	else:
		$MenstrualTimer.text = "Menstrual Cycle: Deactive"

func on_score_updated():
	$score.text = "score: %s" % str(GameManager.get_score())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	menstrualCheck()
