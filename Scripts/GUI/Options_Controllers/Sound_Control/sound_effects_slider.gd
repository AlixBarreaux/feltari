class_name SoundEffectsSoundSlider
extends HSlider


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize()

############################### DECLARE FUNCTIONS ##############################

func _initialize() -> void:
	self.min_value = Settings.get_default_sound_effects_min_volume_db()
	self.value = Settings.get_default_sound_effects_current_volume_db()
	self.max_value = Settings.get_default_sound_effects_max_volume_db()


func _on_SoundEffectsHSlider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), value)
	print(self.name + ": Value changed to: " + str(value))
