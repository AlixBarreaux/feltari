class_name InteractableAltar
extends Interactable


############################### DECLARE VARIABLES ##############################

var is_enabled: bool = false
var has_fairy_inside: bool = false

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func receive_interaction() -> void:
	print(self.name + ": I just received an interaction!")
	if not Global.following_fairy_id == self.id: #or Global.has_player_following_fairy:
		print(self.name + ": The player has a following fairy or a fairy of different ID from me!")
		print("Submitted fairy ID: ", Global.following_fairy_id, " Altar's ID: ", self.id)
		return
	
	if not Global.has_player_following_fairy:
		print(self.name + ": PLAYER HAS NO FAIRY FOLLOWING HIM: ", Global.has_player_following_fairy)
		
		if self.is_enabled:
			animation_player.play("Idle")
			Global.pickup_fairy_from_altar(self.id)
			is_enabled = false
	else:
		if not self.is_enabled:
			animation_player.play("Enable")
			Global.place_fairy_in_altar()
			has_fairy_inside = true
			is_enabled = true


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	sprite.set("self_modulate", new_color)
	$Light2D.color = new_color
