class_name FinalBlockZone
extends StaticBody2D


############################### DECLARE VARIABLES ##############################


################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_signals()

############################### DECLARE FUNCTIONS ##############################

func _initialize_signals() -> void:
	Events.connect("game_ended", self, "on_game_ended")


func on_game_ended() -> void:
	print(self.name, " Game is ended, locking the area!")
	for child in self.get_children():
		child.set_deferred("disabled", false)
