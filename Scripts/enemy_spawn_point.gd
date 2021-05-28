class_name EnemySpawnPoint
extends Position2D


############################### DECLARE VARIABLES ##############################

onready var enemy: KinematicBody2D = self.get_child(0)

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	
	# PATROL AREA, SPAWN POINT OR WHATEVER
#	enemy.set_initial_area(self.global_position)

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	assert(self.get_child_count() == 1)
	# My child should be an Enemy!
	# NOTE (Programmer) : KinematicBody2D is not replaced by Enemy in this 
	# assert since the engine outputs (FALSE POSITIVES!) cyclic
	# dependencies errors
	assert(enemy is KinematicBody2D)
