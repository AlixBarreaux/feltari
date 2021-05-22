class_name HealthManager
extends Node


############################### DECLARE VARIABLES ##############################

export var current_health: int = 0
export var max_health: int = 0

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	# Must be more than 0!
	assert(self.current_health > 0)
	assert(self.max_health > 0)
	# Current Health mus be less or equal to max health!
	assert(self.current_health <= self.max_health)


func _take_damage(amount: int) -> void:
	self.current_health -= amount
	
	if self.current_health <= 0:
		self.current_health
		self._die()


func _die() -> void:
	pass
