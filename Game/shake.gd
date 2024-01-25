extends Camera2D

@export var randomStrength: float = 20.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shakeStrength: float = 0.0

var defaultPosition: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.menstruation_start.connect(shake)
	
func applyShake():
	shakeStrength = randomStrength
	
func randomOffset():
	return Vector2(rng.randf_range(-shakeStrength,shakeStrength),rng.randf_range(-shakeStrength,shakeStrength))

func shake():
	applyShake()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	offset = Vector2(0,0)
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0,shakeFade * get_physics_process_delta_time())
		offset = randomOffset()
