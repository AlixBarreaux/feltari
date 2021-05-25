extends Control


############################### DECLARE VARIABLES ##############################

export var scene_to_load: PackedScene = null setget , get_scene_to_load

# Node References
export var first_button_to_focus_node_path: NodePath = ""
onready var first_button_to_focus_button: Button = self.get_node(first_button_to_focus_node_path)



# Buttons
onready var play_button: Button = $ButtonsContainer/PlayButton
onready var options_button: Button = $ButtonsContainer/OptionsButton
onready var credits_button: Button = $ButtonsContainer/CreditsButton


# SubMenus
onready var options_menu: Control = $OptionsMenu
onready var credits_menu: Control = $CreditsMenu


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
	var _change_scene_to_error: int = 0
	_change_scene_to_error = get_tree().change_scene_to(get_scene_to_load())
	
	match _change_scene_to_error:
		OK:
			pass
		ERR_CANT_CREATE:
			printerr("(!) ERROR: In " + self.name + " _on_PlayButton_pressed()")
			printerr("Can't load the scene! ERR_CANT_CREATE")
		_:
			printerr("(!) ERROR: In" + self.name + " _on_PlayButton_pressed()")
			printerr("Unknown error!")



func _on_OptionsButton_pressed() -> void:
	options_menu.show()


func _on_CreditsButton_pressed() -> void:
	credits_menu.show()


# -------------------------------------------------------

# Children's visibility changed 

func _on_OptionsMenu_visibility_changed() -> void:
	if not options_menu.visible:
		options_button.grab_focus()


func _on_CreditsMenu_visibility_changed() -> void:
	if not credits_menu.visible:
		credits_button.grab_focus()
