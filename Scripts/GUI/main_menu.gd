extends Control


############################### DECLARE VARIABLES ##############################

export var scene_to_load: PackedScene = null setget , get_scene_to_load

# Node Paths
export var play_button_node_path: NodePath = ""


# Node References
onready var play_button: Button = get_node(play_button_node_path)

# Buttons
onready var credits_button: Button = $ButtonsContainer/CreditsButton
onready var options_button: Button = $ButtonsContainer/OptionsButton

# SubMenus
onready var options_menu: Panel = $OptionsMenu


################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	
	play_button.grab_focus()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	# The scene to load when clicking play is not set!
	assert(self.scene_to_load != null)


func get_scene_to_load() -> PackedScene:
	return scene_to_load


# Button presses

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to(get_scene_to_load())


func _on_OptionsButton_pressed() -> void:
	options_menu.show()


# -------------------------------------------------------

# Children's visibility changed 

func _on_OptionsMenu_visibility_changed() -> void:
	if not options_menu.visible:
		options_button.grab_focus()
