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


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		if not self.visible:
			get_tree().set_pause(true)
			self.show()
		else:
			get_tree().set_pause(false)
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
	get_tree().change_scene_to(self.get_scene_to_load())



# Control Visibility Signals

func _on_OptionsMenu_visibility_changed() -> void:
	options_button.grab_focus()


func _on_PauseMenuGUI_visibility_changed() -> void:
	if self.visible:
		first_button_to_focus_button.grab_focus()
