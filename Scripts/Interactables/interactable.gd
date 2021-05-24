class_name Interactable
extends Node2D


############################### DECLARE VARIABLES ##############################


onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	assert(sprite.texture != null)


func receive_interaction() -> void:
	print(self.name + ": I just received an interaction!")
	animation_player.play("Enable")
