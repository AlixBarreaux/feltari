class_name PlayMusicArea2D
extends Area2D


############################### DECLARE VARIABLES ##############################

onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
onready var sound_animation_player: AnimationPlayer = $SoundAnimationPlayer

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	# The AudioStreamPlayer requires a Stream!
	assert(self.audio_stream_player.stream != null)


func _on_PlayMusicArea2D_body_entered(_body: PhysicsBody2D) -> void:
	sound_animation_player.play("Fade In Out")



func set_audio_stream_playing(playing: bool) -> void:
	if playing:
		audio_stream_player.play()
	else:
		audio_stream_player.stop()
	
	print(playing, audio_stream_player.playing)


# Use of yield with create timer because of
# time constraints for the project...
func _on_ExitPointArea2D_body_exited(_body: Node) -> void:
	sound_animation_player.play_backwards("Fade In Out")
	yield(get_tree().create_timer(8), "timeout")
	self.queue_free()
