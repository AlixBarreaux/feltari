class_name OptionsMenu
extends Panel


############################### DECLARE VARIABLES ##############################

export var first_button_to_focus_node_path: NodePath = ""
onready var first_button_to_focus_button: Button = self.get_node(first_button_to_focus_node_path)

################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func _on_OptionsMenu_visibility_changed() -> void:
	if self.visible:
		self.show()
		first_button_to_focus_button.grab_focus()
	else:
		self.hide()


func _on_BackButton_pressed() -> void:
	self.hide()

