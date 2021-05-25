class_name InGameGui
extends Control


############################### DECLARE VARIABLES ##############################

onready var health_bar: TextureProgress = $HealthBar
onready var health_points_label_int: Label = $HealthBar/CenterContainer/HealthPointsIntLabel

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_signals()

############################### DECLARE FUNCTIONS ##############################

func _initialize_signals() -> void:
	Events.connect("player_current_health_set", self, "on_player_current_health_set")
	Events.connect("player_current_health_decreased", self, "on_current_health_decreased")
	Events.connect("player_current_health_increased", self, "on_current_health_increased")
	
	Events.connect("player_max_health_set", self, "on_player_max_health_set")



func on_current_health_decreased(amount: int) -> void:
	print(self.name + ": I received decreased current health value of: " + str(amount)) 
#	health_points_label_int.set_text(str(health_bar.value + amount))


func on_current_health_increased(amount: int) -> void:
	print(self.name + ": I received an added current health value of: " + str(amount)) 
#	health_points_label_int.set_text(str(health_bar.value - amount))
#	health_points_label_int.set_text(str(health_bar.value))
#	on_player_current_health_set()



func on_player_max_health_set(value: int) -> void:
	health_bar.max_value = value
	health_points_label_int.set_text(str(health_bar.max_value))
	print(self.name + ": max value set to: " + str(value))


func on_player_current_health_set(value: int) -> void:
	health_bar.value = value
	health_points_label_int.set_text(str(value))
	print(self.name + ": on_player_current_health_set value: " + str(value))
