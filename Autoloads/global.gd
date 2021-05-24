extends Node


############################### DECLARE VARIABLES ##############################

var remaining_fairies_ids: PoolIntArray = []
var owned_fairies_ids: PoolIntArray = []

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func pickup_fairy(id: int) -> void:
	print("Remaining: ", remaining_fairies_ids)
	print("Owned: ", owned_fairies_ids)
	var _index: int = -1
	for fairy_id in owned_fairies_ids:
		_index += 1
		if fairy_id == id:
			self.owned_fairies_ids.remove(_index)
	
	self.remaining_fairies_ids.append(id)
	get_tree().call_group("player", "spawn_fairy")
	
	print("Remaining: ", remaining_fairies_ids)
	print("Owned: ", owned_fairies_ids)


func use_fairy(id: int) -> void:
	pass


func populate_remaining_fairies_ids(max_index: int) -> void:
	for new_id in range(0, max_index + 1):
		remaining_fairies_ids.append(new_id)
		print(remaining_fairies_ids)
