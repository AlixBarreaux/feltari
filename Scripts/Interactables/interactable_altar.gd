class_name InteractableAltar
extends Interactable


############################### DECLARE VARIABLES ##############################

var is_enabled: bool = false
var has_fairy_inside: bool = false
# Prevent the player from spamming the Altar's interaction
var can_interact: bool = true setget set_can_interact, get_can_interact

# Node References
onready var player_respawn_point: Position2D = $PlayerRespawnPoint
onready var light_2D: Light2D = $Light2D

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func set_can_interact(value: bool) -> void:
	can_interact = value


func get_can_interact() -> bool:
	return can_interact


func receive_interaction() -> void:
	if not self.get_can_interact():
#		print(self.name + ": Stop spamming me with your interaction!")
		return
	
#	print(self.name + ": I just received an interaction!")
	
	
	if not Global.has_player_following_fairy:
#		print(self.name + ": PLAYER HAS NO FAIRY FOLLOWING HIM: ", Global.has_player_following_fairy)
		
		if self.is_enabled:
			animation_player.play("Idle")
			Global.pickup_fairy_from_altar(self.id)
			# Add following fairy on the player
			get_tree().call_group("player", "spawn_following_fairy", self.get_current_color())
			is_enabled = false
	else:
		if not Global.following_fairy_id == self.id:
#			print(self.name + ": The player has a following fairy or a fairy of different ID from me!")
#			print("Submitted fairy ID: ", Global.following_fairy_id, " Altar's ID: ", self.id)
			return
		
		if not self.is_enabled:
			animation_player.play("Enable")
			Global.place_fairy_in_altar()
			# Remove following fairy on the player
			get_tree().call_group("player", "despawn_following_fairy")
			has_fairy_inside = true
			is_enabled = true
			
			get_tree().call_group("player", "set_spawn_point", player_respawn_point.global_position)


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	sprite.set("self_modulate", new_color)
	light_2D.color = new_color
