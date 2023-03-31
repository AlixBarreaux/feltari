class_name EndGameGUI
extends Control


############################### DECLARE VARIABLES ##############################

export var scene_to_load: PackedScene = null setget , get_scene_to_load

# Node References
export var first_button_to_focus_node_path: NodePath = ""
onready var first_button_to_focus_button: Button = self.get_node(first_button_to_focus_node_path)

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	first_button_to_focus_button.grab_focus()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	# The scene to load when clicking play is not set!
	assert(self.scene_to_load != null)


func get_scene_to_load() -> PackedScene:
	return scene_to_load

func _on_CreditsButton_pressed() -> void:
	pass # Replace with function body.


func _on_QuitToMainMenuButton_pressed() -> void:
	get_tree().change_scene_to(self.get_scene_to_load())


func _on_EndGameGUI_visibility_changed() -> void:
	self.show()
