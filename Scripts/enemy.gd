class_name enemy
extends KinematicBody2D

# Generic class all enemies share

############################### DECLARE VARIABLES ##############################

enum AI_STATES {
	IDLE,
	WANDER,
	CHASE
}

export (AI_STATES) var current_ai_state = AI_STATES.IDLE

################################# RUN THE CODE #################################

var velocity: Vector2 = Vector2(0.0, 0.0)
var knockback: Vector2 = Vector2(0.0, 0.0)

func _ready() -> void:
	self._initialize_asserts()


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2(0.0, 0.0), 200 * delta)
	knockback = move_and_slide(knockback)
	
#	yield(get_tree().create_timer(2.0), "timeout")

#	match current_ai_state:
#		AI_STATES.IDLE:
#			knockback = knockback.move_toward(Vector2(0.0, 0.0), 200 * delta)
#
#		AI_STATES.WANDER:
#			pass
#
#		AI_STATES.CHASE:
#			pass

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
	knockback = knockback.direction_to(body.global_position)
	print(knockback)


func _on_CreatureDetectionZone_body_exited(body: PhysicsBody2D) -> void:
	pass # Replace with function body.





export var current_health: int = 0
export var max_health: int = 0
export var damage: int = 1

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

func _on_HurtBox_body_entered(body: PhysicsBody2D) -> void:
	print(self.name, ": I was entered by: ", body.name)
	body.take_damage(damage)
