extends Node2D


############################### DECLARE VARIABLES ##############################

onready var audio_stream_player2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
onready var sound_animation_player: AnimationPlayer = $SoundAnimationPlayer

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func _on_VisibilityNotifier2D_screen_entered() -> void:
	sound_animation_player.play("Fade In Out")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	sound_animation_player.play_backwards("Fade In Out")


func set_audio_stream_playing(playing: bool) -> void:
	if playing:
		audio_stream_player2d.play()
	else:
		audio_stream_player2d.stop()
