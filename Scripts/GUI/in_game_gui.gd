class_name InGameGui
extends Control


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_signals()

############################### DECLARE FUNCTIONS ##############################

func _initialize_signals() -> void:
	Events.connect("player_current_health_decreased", self, "on_current_health_decreased")
	Events.connect("player_current_health_increased", self, "on_current_health_increased")


func on_current_health_decreased(amount: int) -> void:
	print(self.name + ": I received decreased current health value of: " + str(amount)) 


func on_current_health_increased(amount: int) -> void:
	print(self.name + ": I received an added current health value of: " + str(amount)) 
