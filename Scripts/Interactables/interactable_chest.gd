class_name InteractableChest
extends Interactable


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func receive_interaction() -> void:
	print("Sending fairy to you player!")
	print(self.name + ": I just received an interaction!")
	animation_player.play("Enable")
	
	# Give fairy to player
	Global.pickup_fairy(self.id)


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	$RevealedItem.set("self_modulate", new_color)
