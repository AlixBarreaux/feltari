class_name ExternalLinkOpenButton
extends Button


############################### DECLARE VARIABLES ##############################

export var link_to_open: String = "" setget , get_link_to_open

################################# RUN THE CODE #################################

func _ready() -> void:
	_initialize_asserts()

############################### DECLARE FUNCTIONS ##############################


func get_link_to_open() -> String:
	return link_to_open


func _initialize_asserts() -> void:
	assert(self.text != "")
	assert(self.get_link_to_open() != "")


func _on_ExternalLinkOpenButton_pressed() -> void:
	OS.shell_open(self.get_link_to_open())
