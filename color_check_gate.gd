class_name ColorCheckGate
extends Interactable


# Checks if the player has a fairy and
# let him pass if his fairy has the same id as the gate
# else block his path

############################### DECLARE VARIABLES ##############################

#onready var creature_detect_zone: Area2D = $CreatureDetectZone

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	pass

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
#	assert(creature_detect_zone)
	pass


func _set_current_color(new_color: Color) -> void:
	current_color = new_color
	sprite.set("self_modulate", new_color)


func _on_CreatureDetectZone_body_entered(body: PhysicsBody2D) -> void:
	print(self.name + ": I've been entered by: " + body.name)
	self.check_if_player_can_pass()


func check_if_player_can_pass() -> void:
	if not Global.has_player_following_fairy:
		print(self.name + ": The player can't pass: No fairy is following him.")
		return

	if not Global.following_fairy_id == self.id:
		print(self.name + ": The player has a following fairy or a fairy of different ID from me!")
		print("Submitted fairy ID: ", Global.following_fairy_id, " Altar's ID: ", self.id)
		return
	
	print("All pass conditions are met, player can pass!")
	self.set_gate_locked(false)


func _on_CreatureDetectZone_body_exited(body: PhysicsBody2D) -> void:
	print(self.name + ": I've been exited by: " + body.name + " !")
	print(self.name + ": I'm now locking the gate!")
	self.set_gate_locked(true)


func set_gate_locked(value: bool) -> void:
	if value:
		print("Gate locked!")
		collision_shape2D.set_deferred("disabled", false)
	else:
		print("Gate unlocked!")
		collision_shape2D.set_deferred("disabled", true)
