class_name FullScreenCheckbox
extends CheckBox


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################


func _on_FullScreenCheckBox_toggled(value: bool) -> void:
	OS.set_window_fullscreen(value)
