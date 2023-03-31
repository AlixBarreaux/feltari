class_name InteractableChest
extends Interactable


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func receive_interaction() -> void:
	if Global.has_player_following_fairy:
		print(self.name + ": The player already has a fairy!")
		return
	
	print("Sending fairy to you player!")
	print(self.name + ": I just received an interaction!")
	collision_shape2D.set_deferred("disabled", true)
	animation_player.play("Enable")


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	$RevealedItem.set("self_modulate", new_color)


func _on_enable_animation_finished() -> void:
	# Give fairy to player
	Global.pickup_fairy_from_chest(self.id)
	# Add following fairy on the player
	get_tree().call_group("player", "spawn_following_fairy", self.get_current_color())
	self.queue_free()
