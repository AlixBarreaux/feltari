class_name InteractableAltar
extends Interactable


############################### DECLARE VARIABLES ##############################

#export var available_colors: PoolColorArray = [
#												Color(0, 0, 0, 0),
#												Color(0, 0, 0, 0),
#												Color(0, 0, 0, 0),
#												Color(0, 0, 0, 0)
#											  ]


################################# RUN THE CODE #################################

func _ready() -> void:
	pass

############################### DECLARE FUNCTIONS ##############################

# ALTAR!

func receive_interaction() -> void:
	print(self.name + ": I just received an interaction!")
	animation_player.play("Enable")


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	sprite.set("self_modulate", new_color)
	$Light2D.color = new_color
