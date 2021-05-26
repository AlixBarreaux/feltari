extends Node2D


############################### DECLARE VARIABLES ##############################

onready var audio_stream_player2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func _on_VisibilityNotifier2D_screen_entered() -> void:
	print("LAKE!!!!!!!!!!!!!!!!!!!!!!!!!!")
	audio_stream_player2d.play()
#	fade_in(audio_stream_player2d)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("LAKE!!!!!!!!!!!!!!!!!!!!!!!!!!")
#	audio_stream_player2d.stop()
#	fade_in(audio_stream_player2d)



onready var tween_out = $Tween

export var transition_duration = 5.0
export var transition_type = Tween.TRANS_SINE


func audio_stream_fade_in(stream_player: AudioStreamPlayer) -> void:
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped


func audio_stream_fade_out(stream_player: AudioStreamPlayer) -> void:
	pass


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	# stop the music -- otherwise it continues to run at silent volume
#	object.stop()
	object.stop()
	pass
