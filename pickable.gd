class_name Pickable
extends Node2D


############################### DECLARE VARIABLES ##############################

export var health_value: int = 0 setget set_health_value, get_health_value

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()

############################### DECLARE FUNCTIONS ##############################

func _initialize_asserts() -> void:
	assert(get_health_value() > 0)
	assert(sprite.texture != null)


func _on_Pickable_body_entered(body: PhysicsBody2D) -> void:
	body.add_current_health(get_health_value())
	animation_player.play("Pick Up")
	yield(animation_player, "animation_finished")
	self.queue_free()


func set_health_value(new_value: int) -> void:
	health_value = new_value


func get_health_value() -> int:
	return health_value
