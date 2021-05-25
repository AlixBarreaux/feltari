class_name InteractableChest
extends Interactable


############################### DECLARE VARIABLES ##############################

onready var collision_shape2D: CollisionShape2D = $CollisionShape2D

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func receive_interaction() -> void:
	print("Sending fairy to you player!")
	print(self.name + ": I just received an interaction!")
	collision_shape2D.set_deferred("disabled", true)
	animation_player.play("Enable")
	
	# Give fairy to player
	Global.pickup_fairy_from_chest(self.id)


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	$RevealedItem.set("self_modulate", new_color)


func _on_enable_animation_finished() -> void:
	self.queue_free()
