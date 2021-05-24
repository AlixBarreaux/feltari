class_name InteractableChest
extends Interactable


############################### DECLARE VARIABLES ##############################

#export var available_colors: PoolColorArray = [
#												Color("83c522"),
#												Color("83c522"),
#												Color("83c522"),
#												Color("4100c0")
#											  ]


################################# RUN THE CODE #################################

func _ready() -> void:
	pass

############################### DECLARE FUNCTIONS ##############################

# CHEST !

func receive_interaction() -> void:
	print("Sending fairy to you player!")
	print(self.name + ": I just received an interaction!")
	animation_player.play("Enable")
	
	# Give fairy to player
	Global.pickup_fairy(self.id)


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	$RevealedItem.set("self_modulate", new_color)
