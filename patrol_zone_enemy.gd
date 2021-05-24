class_name PatrolZoneEnemy
extends Area2D


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################


############################### DECLARE FUNCTIONS ##############################

# Use this to detect if player enters the patrol zone and call the enemy group
func _on_PatrolZoneEnemy_body_entered(body: PhysicsBody2D) -> void:
#	body.go_back_to_patrol_area()
	pass


func _on_PatrolZoneEnemy_body_exited(body: PhysicsBody2D) -> void:
#	body.set_current_ai_state(AI_STATES.TELEPORT_TO_SPAWN_POINT)
	print(self.name + ": The body " + body.name + " exited me!")
	body.teleport_to_spawn_point()
