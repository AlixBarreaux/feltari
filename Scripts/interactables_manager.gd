class_name InteractablesManager
extends Node2D

# Node in the world managing Interactable nodes.
# Each interactable should be a child of one of the children of
# this Node (EG: Altar would be a child of Altars Node)
# This script ensures there are the same amount of chests
# and altars in case the level designer forgot to do that.

# This Node will set the ids for the interactables.


############################### DECLARE VARIABLES ##############################

export var interactables_colors: PoolColorArray = []

var unassigned_color: Color = Color("000000")
var interactable_pairs_count: int = 0

# Node References
onready var altars: Node2D = $Altars
onready var chests: Node2D = $Chests
onready var color_check_gates: Node2D = $ColorCheckGates


################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	self._initialize()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	self.verify_interactables_parity()
	
	# Assign to this variable for checks in functions later in the code
	interactable_pairs_count = altars.get_child_count()
	# There must be as much Colors as each pair of interactables!
	assert((interactables_colors.size()) == interactable_pairs_count)
	

	self.verify_if_colors_assigned()


# Verify there are as much altars as the chests
# If it crashed with an error message 'assertion failed' and redirected to this
# script in this function it's because this condition is not met
func verify_interactables_parity() -> void:
	var _altars_count: int = 0
	for altar in altars.get_children():
		_altars_count += 1
	
	var _chests_count: int = 0
	for chest in chests.get_children():
		_chests_count += 1
	
	var _gates_count: int = 0
	for gate in color_check_gates.get_children():
		_gates_count += 1
	
	assert(_altars_count == _chests_count)
	assert(_chests_count == _gates_count)
# Non programmer: Look comment on top of this function for crash explanation!


func _initialize() -> void:
	# Set the pairs count for checks in the next functions below
	assign_ids_to_interactables()
	assign_colors_to_interactables()



# Verify if the number
func verify_if_colors_assigned() -> void:
	# Altar or chest count doesn't matter
	if interactable_pairs_count == 0:
		return
	
	assert(interactables_colors.size() == interactable_pairs_count)
	for color in interactables_colors:
		if color == unassigned_color:
			printerr("(!) WARNING: One or more Colors have not been assigned to")
			printerr("the Interactables Node (InteractablesManager class) !")
			printerr("Please assign one/them!")
			break


func assign_ids_to_interactables() -> void:
	var _id_to_assign: int = -1
	for altar in altars.get_children():
		_id_to_assign += 1
		altar.set_id(_id_to_assign)
		
	# Assign the IDs in the singleton which will be the hub
	# for the checks with the fairies management
	# will break if _id_to_assign is changed unproperly or removed
	Global.populate_remaining_fairies_ids(_id_to_assign)
	
	# Reset the id to have the same on both of the altars and chests
	_id_to_assign = -1
	for chest in chests.get_children():
		_id_to_assign += 1
		chest.set_id(_id_to_assign)
	
	
	# ColorCheckGates
	_id_to_assign = -1
	for gate in color_check_gates.get_children():
		_id_to_assign += 1
		gate.set_id(_id_to_assign)


func assign_colors_to_interactables() -> void:
	var _color_index: int = -1
	
	for altar in altars.get_children():
		_color_index += 1
		altar._set_current_color(interactables_colors[_color_index])
	
	# Reset the color index to have the same on both the altars and the chests
	_color_index = -1
	
	for chest in chests.get_children():
		_color_index += 1
		chest._set_current_color(interactables_colors[_color_index])

	
	# Color gates
	_color_index = -1
	
	for gate in color_check_gates.get_children():
		_color_index += 1
		gate._set_current_color(interactables_colors[_color_index])
	
