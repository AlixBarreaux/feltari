class_name enemy
extends KinematicBody2D


############################### DECLARE VARIABLES ##############################

enum AI_STATES {
	IDLE,
	WANDER,
	CHASE
}

export (AI_STATES) var current_ai_state = AI_STATES.IDLE

################################# RUN THE CODE #################################

var velocity: Vector2 = Vector2(0.0, 0.0)
var knockback: Vector2 = Vector2(0.0, 0.0)

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2(0.0, 0.0), 200 * delta)
	knockback = move_and_slide(knockback)
	
#	yield(get_tree().create_timer(2.0), "timeout")

#	match current_ai_state:
#		AI_STATES.IDLE:
#			knockback = knockback.move_toward(Vector2(0.0, 0.0), 200 * delta)
#
#		AI_STATES.WANDER:
#			pass
#
#		AI_STATES.CHASE:
#			pass

############################### DECLARE FUNCTIONS ##############################


func _on_HurtBox_area_entered(area: Area2D) -> void:
	pass






func seek_player() -> void:
	pass


# AI
func _on_CreatureDetectionZone_body_entered(body: PhysicsBody2D) -> void:
#	knockback = Vector2.DOWN * 200
	knockback = knockback.direction_to(body.global_position)
	print(knockback)


func _on_CreatureDetectionZone_body_exited(body: PhysicsBody2D) -> void:
	pass # Replace with function body.
