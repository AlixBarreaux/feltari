class_name InteractableChest
extends Interactable


############################### DECLARE VARIABLES ##############################

export var available_colors: PoolColorArray = [
												Color("83c522"),
												Color("83c522"),
												Color("83c522"),
												Color("4100c0")
											  ]

var id: int = 0

################################# RUN THE CODE #################################

func _ready() -> void:
	pass

############################### DECLARE FUNCTIONS ##############################


func set_color_automatically() -> void:
	match id:
		_:
			pass
