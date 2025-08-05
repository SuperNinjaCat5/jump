extends CharacterBody2D


const SPEED = 140
const JUMP_VELOCITY = -260
@onready var coyote_timer = $CoyoteTime
@onready var Game_Over_Overlay = get_node("../Game_Over_Overlay")
var is_alive: bool = true

func _ready():
	visible = true
	is_alive = true	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_alive:
		return	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") && (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()

func _on_death_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		visible = false
		is_alive = false
		death()
			
func death():
	print("Called Death")
	Game_Over_Overlay.game_over()
	
