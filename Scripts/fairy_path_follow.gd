class_name FairyPathFollow
extends Path2D


############################### DECLARE VARIABLES ##############################

onready var path_follow_2D: PathFollow2D = $PathFollow2D

################################# RUN THE CODE #################################

func _physics_process(delta: float) -> void:
	path_follow_2D.set_offset(path_follow_2D.get_offset() + 150 * delta)

############################### DECLARE FUNCTIONS ##############################
