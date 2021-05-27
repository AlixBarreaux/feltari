class_name PlayMusicArea2D
extends Area2D


############################### DECLARE VARIABLES ##############################

onready var audio_stream_player: AudioStreamPlayer = $Music
onready var sound_animation_player: AnimationPlayer = $SoundAnimationPlayer

################################# RUN THE CODE #################################

#func _ready() -> void:
#	set_audio_stream_playing(true)

############################### DECLARE FUNCTIONS ##############################

func _on_PlayMusicArea2D_body_entered(_body: PhysicsBody2D) -> void:
	sound_animation_player.play("Fade In Out")


func _on_ExitPointArea2D_body_entered(_body: PhysicsBody2D) -> void:
	sound_animation_player.play_backwards("Fade In Out")



func set_audio_stream_playing(playing: bool) -> void:
	if playing:
		audio_stream_player.play()
	else:
		audio_stream_player.stop()
	
	print(playing, audio_stream_player.playing)
