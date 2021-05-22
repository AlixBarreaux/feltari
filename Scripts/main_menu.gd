extends Control


############################### DECLARE VARIABLES ##############################

export var scene_to_load: PackedScene = null setget , get_scene_to_load

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	# The scene to load when clicking play is not set!
	assert(self.scene_to_load != null)


func get_scene_to_load() -> PackedScene:
	return scene_to_load


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to(get_scene_to_load())



