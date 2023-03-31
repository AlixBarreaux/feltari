class_name LevelCameraManager
extends Node2D


############################### DECLARE VARIABLES ##############################

onready var camera_2d: Camera2D = $LevelCamera2D
onready var animation_player: AnimationPlayer = $AnimationPlayer

# Camera Locations (Position2D)
onready var tutorial_area: Position2D = $TutorialArea
onready var end_area: Position2D = $EndArea

################################# RUN THE CODE #################################

func _ready() -> void:
	self.set_camera_position(tutorial_area)


func set_camera_position(new_position2d: Position2D) -> void:
	camera_2d._set_current(true)
	camera_2d.global_position = new_position2d.global_position


func on_game_ended() -> void:
	self.set_camera_position(end_area)
	animation_player.play_backwards("Zoom Out")


############################### DECLARE FUNCTIONS ##############################


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	camera_2d._set_current(false)
	Events.emit_signal("game_started")
