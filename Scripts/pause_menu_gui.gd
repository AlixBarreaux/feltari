extends Control


############################### DECLARE VARIABLES ##############################

export var scene_to_load: PackedScene = null setget , get_scene_to_load

# Node References
export var first_button_to_focus_node_path: NodePath = ""
onready var first_button_to_focus_button: Button = self.get_node(first_button_to_focus_node_path)

onready var buttons_container: VBoxContainer = $Panel/ButtonsContainer

# Buttons
onready var resume_button: Button = buttons_container.get_node("ResumeButton")
onready var options_button: Button = buttons_container.get_node("OptionsButton")
onready var quit_to_main_menu_button: Button = buttons_container.get_node("QuitToMainMenuButton")

# SubMenus
onready var options_menu: Control = $OptionsMenu

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	first_button_to_focus_button.grab_focus()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		if not self.visible:
			self.show()
		else:
			self.hide()


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	assert(self.get_scene_to_load())


# Setters and Getters

func get_scene_to_load() -> PackedScene:
	return scene_to_load


# Button pressed Signals

func _on_ResumeButton_pressed() -> void:
	self.hide()


func _on_OptionsButton_pressed() -> void:
	options_menu.show()


func _on_QuitToMainMenuButton_pressed() -> void:
	var _change_scene_to_error: int = 0
	_change_scene_to_error = get_tree().change_scene_to(self.get_scene_to_load())
	
	match _change_scene_to_error:
		OK:
			pass
		ERR_CANT_CREATE:
			printerr("(!) ERROR: In " + self.name + " _on_PlayButton_pressed()")
			printerr("Can't load the scene! ERR_CANT_CREATE")
		_:
			printerr("(!) ERROR: In" + self.name + " _on_PlayButton_pressed()")
			printerr("Unknown error!")



# Control Visibility Signals

func _on_OptionsMenu_visibility_changed() -> void:
	options_button.grab_focus()


func _on_PauseMenuGUI_visibility_changed() -> void:
	if self.visible:
		get_tree().set_pause(true)
		first_button_to_focus_button.grab_focus()
	else:
		get_tree().set_pause(false)
