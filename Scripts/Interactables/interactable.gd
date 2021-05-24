class_name Interactable
extends Node2D

# Base class for all the interactables.
# The id variable will be set automatically by the interactables manager.


############################### DECLARE VARIABLES ##############################

var id: int = 0 setget set_id, get_id
var current_color: Color = Color(0, 0, 0, 0) setget _set_current_color

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	assert(sprite.texture != null)


func receive_interaction() -> void:
#	print(self.name + ": I just received an interaction!")
#	animation_player.play("Enable")
	pass


func set_id(new_id: int) -> void:
	id = new_id
#	print(self.name + ": ID SET TO: " + str(id))

func get_id() -> int:
	return id


func _set_current_color(new_color: Color) -> void:
	current_color = new_color


func get_current_color() -> Color:
	return current_color
