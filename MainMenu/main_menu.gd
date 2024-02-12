extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.reset()
	GameManager.load_game()
	$Highscore.text = "Highscore: "+str(GameManager.high_score)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		GameManager.load_game_scene()
		
