class_name Player
extends KinematicBody2D


# Class containing all the player's information.
# Player controller is directly put there, might need decoupling.

############################### DECLARE VARIABLES ##############################

export var current_speed: int = 200 setget set_current_speed, get_current_speed

var direction: Vector2 = Vector2(0.0, 0.0) setget set_direction, get_direction
var velocity: Vector2 = Vector2(0.0, 0.0) setget set_velocity

################################# RUN THE CODE #################################

func _physics_process(delta: float) -> void:
	self.calculate_velocity()
	velocity = move_and_slide(velocity)


func _unhandled_input(event: InputEvent) -> void:
	self.set_direction(Vector2(0.0, 0.0))
	
	if Input.get_action_strength("move_left"):
		self.direction.x = -1
		
	if Input.get_action_strength("move_right"):
		self.direction.x = 1
	
	if Input.get_action_strength("move_up"):
		self.direction.y = -1
	
	if Input.get_action_strength("move_down"):
		self.direction.y = 1
	
	
	self.direction = self.direction.normalized()
	


############################### DECLARE FUNCTIONS ##############################

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction


func get_direction() -> Vector2:
	return direction


func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity


func set_current_speed(new_speed: int) -> void:
	current_speed = new_speed


func get_current_speed() -> int:
	return current_speed


func calculate_velocity() -> void:
	self.velocity = self.direction * self.current_speed
