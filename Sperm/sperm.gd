extends CharacterBody2D

@onready var egg = $"../../Egg"
@onready var sperm_animation = $AnimatedSprite2D
var spermSpeed: float = 150.0
func _ready():
	GameManager.death_by_sperm.connect(death_by_sperm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var motion = Vector2.ZERO
	motion += position.direction_to(egg.global_position)
	self.position += motion * spermSpeed * delta 
	look_at(egg.global_position)
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()

func player_scored():
	GameManager.increment_score()

func _on_mouse_entered():
	spermSpeed = 0
	player_scored()
	$AudioStreamPlayer.play()
	sperm_animation.play("vanish")

func death_by_sperm():
	sperm_animation.stop()
	get_node("CollisionShape2D").set_deferred("disabled",true)

func destroySperm():
	self.queue_free()
	
func _on_animated_sprite_2d_animation_finished():
	if GameManager.health != -1:
		destroySperm()
