extends Area2D

@onready var waitTimer = $Timer

func _on_body_entered(body):
	if body.is_in_group("Sperm"):
		if GameManager.getHealth() == 1:
			body.queue_free()
			GameManager.healthDown(1)
			GameManager.menstruation_start.emit()
		else:
			GameManager.death_by_sperm.emit()

		
