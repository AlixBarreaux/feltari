extends Node


############################### DECLARE VARIABLES ##############################

# Ids of the fairies in wainting to be picked up in chests
var remaining_fairies_ids: PoolIntArray = []
# IDs of the fairies used in the altars
var in_altar_fairies_ids: PoolIntArray = []
# ID of the fairy currently following the player
var following_fairy_id: int = 0
var has_player_following_fairy: bool = false

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func pickup_fairy_from_chest(id: int) -> void:
	print("Remaining: ", remaining_fairies_ids)
	print("In altar: ", in_altar_fairies_ids)
	print("Following (lone on player): ", following_fairy_id)
	
	if has_player_following_fairy:
		print("THE PLAYER ALREADY HAS A FOLLOWING FAIRY!")
		return
	
	# The player has now a fairy
	has_player_following_fairy = true
	var _index: int = -1
	
	for fairy_id in remaining_fairies_ids:
		_index += 1
		if fairy_id == id:
			self.remaining_fairies_ids.remove(_index)
			self.following_fairy_id = id
	
	print("Remaining: ", remaining_fairies_ids)
	print("In altar: ", in_altar_fairies_ids)
	print("Following (lone on player): ", following_fairy_id)


func pickup_fairy_from_altar(id: int) -> void:
	print("Remaining: ", remaining_fairies_ids)
	print("In altar: ", in_altar_fairies_ids)
	print("Following (lone on player): ", following_fairy_id)
	
	if has_player_following_fairy:
		print("Global: pickup_fairy_from_altar() THE PLAYER ALREADY HAS A FOLLOWING FAIRY!")
		return
	
	# The player has now a fairy
	has_player_following_fairy = true
	var _index: int = -1
	
	for fairy_id in in_altar_fairies_ids:
		_index += 1
		if fairy_id == id:
			self.in_altar_fairies_ids.remove(_index)
			self.following_fairy_id = id
	
	print("Remaining: ", remaining_fairies_ids)
	print("In altar: ", in_altar_fairies_ids)
	print("Following (lone on player): ", following_fairy_id)


func place_fairy_in_altar() -> void:
	in_altar_fairies_ids.append(following_fairy_id)
	self.has_player_following_fairy = false


func populate_remaining_fairies_ids(max_index: int) -> void:
	for new_id in range(0, max_index + 1):
		remaining_fairies_ids.append(new_id)
