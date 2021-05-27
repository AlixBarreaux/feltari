class_name EndGameArea2D
extends Area2D


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

func _on_EndGameArea2D_body_entered(body: PhysicsBody2D) -> void:
	Events.emit_signal("game_ended")
