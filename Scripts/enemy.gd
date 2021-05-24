class_name Enemy
extends KinematicBody2D

# Generic class all enemies share

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
#		velocity = position.direction_to(get_current_target().position) * current_speed
		
#		if self.position.distance_to(get_current_target().position) > 5:
		if self.position.distance_to(target_destination) > 5:
			velocity = move_and_slide(velocity)
		
		self.target_destination = get_current_target().position
	
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
#	self.set_current_ai_state(AI_STATES.TELEPORT_TO_SPAWN_POINT)
	idle()
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
		target_destination = new_target.position


func get_current_target() -> Node2D:
	return current_target


func set_current_ai_state(new_state: int) -> void:
	current_ai_state = new_state
	
	match get_current_ai_state():
		AI_STATES.IDLE:
			self.idle()
		AI_STATES.WANDER:
			pass
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


func wander() -> void:
	pass

func chase_target() -> void:
	pass

# Messy (Game Jam!) The target must be set to null for the destination to 
# clear the target (which should be the player)
func teleport_to_spawn_point() -> void:
	self.set_current_target(null)
	self.set_position(get_initial_spawn_position())



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
