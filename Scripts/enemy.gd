class_name Enemy
extends KinematicBody2D

# Generic class all enemies share

# WARNING: All child nodes are tightly coupled
# WARNING: chase_target() function is empty even though everything works!

# to the main class (time contraints)
# NOTE: The AI was poorly implemented due to the time constraints during the
# game jam, it is therefore not recommended to replicate unless it's not a
# problem to have something not maintainable nor scalable.

# The TargetPosition node is only used in the wander function.
# You can add a child to this node to see it in the world for debugging.
# It could probably be used in the set_target() function.


############################### DECLARE VARIABLES ##############################

export var current_health: int = 0
export var max_health: int = 0
export var damage: int = 1

export var current_speed: int = 100

enum AI_STATES {
	IDLE,
	WANDER,
	CHASE,
	TELEPORT_TO_SPAWN_POINT
}

export (AI_STATES) var current_ai_state = AI_STATES.IDLE setget set_current_ai_state, get_current_ai_state

# Where the Enemy spawned (is placed in the World) at first.
# It'll go back to this point after it's done chasing the player
onready var initial_spawn_point: Vector2 = self.global_position setget set_initial_spawn_position, get_initial_spawn_position
var target_destination: Vector2 = Vector2(0.0, 0.0)

################################# RUN THE CODE #################################

var velocity: Vector2 = Vector2(0.0, 0.0)
var knockback: Vector2 = Vector2(0.0, 0.0)

func _ready() -> void:
	self._initialize_asserts()


var current_target: Node2D = null setget set_current_target, get_current_target


func _physics_process(_delta: float) -> void:
	if self.get_current_target() != null:
		velocity = position.direction_to(target_destination) * current_speed

		if self.position.distance_to(target_destination) > 5:
			velocity = move_and_slide(velocity)
		
		self.target_destination = get_current_target().global_position
		
		
		if velocity.x > 0:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
			
		
#		print("Physics Process: Destination: ", self.target_destination)
	
#	self.move_and_slide(velocity)
	
#	knockback = knockback.move_toward(Vector2(0.0, 0.0), 200 * delta)
#	knockback = move_and_slide(knockback)

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	# Must be more than 0!
	assert(self.current_health > 0)
	assert(self.max_health > 0)
	# Current Health mus be less or equal to max health!
	assert(self.current_health <= self.max_health)


func seek_player() -> void:
	pass


# AI
func _on_CreatureDetectionZone_body_entered(body: PhysicsBody2D) -> void:
#	knockback = Vector2.DOWN * 200
#	knockback = knockback.direction_to(body.global_position)
#	print(knockback)
	self.set_current_target(body)
	self.set_current_ai_state(AI_STATES.CHASE)


func _on_CreatureDetectionZone_body_exited(_body: PhysicsBody2D) -> void:
	self.set_current_ai_state(AI_STATES.IDLE)
	pass


func _on_HurtBox_body_entered(body: PhysicsBody2D) -> void:
	print(self.name, ": I was entered by: ", body.name)
	body.take_damage(damage)




# Setters and getters

func set_initial_spawn_position(new_position: Vector2) -> void:
	initial_spawn_point = new_position


func get_initial_spawn_position() -> Vector2:
	return initial_spawn_point



func set_current_target(new_target: Node2D) -> void:
	current_target = new_target
	if new_target != null:
		target_destination = new_target.global_position
#		print("set_current_target(): Target set to: " + str(new_target.global_position))


func get_current_target() -> Node2D:
	return current_target


func set_current_ai_state(new_state: int) -> void:
	current_ai_state = new_state
	
	match get_current_ai_state():
		AI_STATES.IDLE:
			self.idle()
		AI_STATES.WANDER:
			self.wander()
		AI_STATES.CHASE:
			self.chase_target()
		AI_STATES.TELEPORT_TO_SPAWN_POINT:
			self.teleport_to_spawn_point()
		_:
			printerr("(!) ERROR: In " + self.name + " in fuction set_current_ai_state() :")
			printerr("Unrecognized state!")


func idle() -> void:
	self.set_current_target(null)
	velocity = Vector2(0.0, 0.0)



# DESTINATION TEST VARIABLES
export var min_random_destination_axis_length: float = -100.0
export var max_random_destination_axis_length: float = 100.0
var random_destination_x_axis: float = 0.0
var random_destination_y_axis: float = 0.0
var destination_rng: RandomNumberGenerator = RandomNumberGenerator.new()

# Move 100 pixels away from the current position
func wander() -> void:

#	# DESTIONATION TEST
	destination_rng.randomize()
	random_destination_x_axis = rand_range(min_random_destination_axis_length, max_random_destination_axis_length)
	destination_rng.randomize()
	random_destination_y_axis = rand_range(min_random_destination_axis_length, max_random_destination_axis_length)
#	print("Random destination: ", random_destination_x_axis, " ", random_destination_y_axis)

	$TargetPosition.global_position.x = self.global_position.x + random_destination_x_axis
	$TargetPosition.global_position.y = self.global_position.y + random_destination_y_axis
	set_current_target($TargetPosition)
#	print("TargetPosition position set to: ", $TargetPosition.global_position)


func chase_target() -> void:
	pass

# Messy (Game Jam!) The target must be set to null for the destination to 
# clear the target (which should be the player)
func teleport_to_spawn_point() -> void:
	self.set_current_target(null)
	self.set_position(get_initial_spawn_position())


func _on_IdleTimer_timeout() -> void:
	# Check if the enemy is chasing something
	# and do not stop it if it is
	if self.current_ai_state == AI_STATES.CHASE:
		return
	
	self.wander()
	$WanderTimer.start()


func _on_WanderTimer_timeout() -> void:
	if self.current_ai_state == AI_STATES.CHASE:
		return

	$IdleTimer.start()
	set_current_ai_state(AI_STATES.IDLE)


func get_current_ai_state() -> int:
	return current_ai_state



func take_damage(amount: int) -> void:
	self.current_health -= amount
	print(self.name + ": I took " + str(amount) + " damage!")
	
	self.check_if_dead()
	
	

func check_if_dead() -> void:
	if self.current_health <= 0:
			self.current_health = 0
			self.die()
	print(self.name + ": Health status: " + str(current_health) + " / " + str(max_health))


func die() -> void:
	print(self.name + str(": I died!"))
