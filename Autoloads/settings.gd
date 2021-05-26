extends Node


############################### DECLARE VARIABLES ##############################

var default_master_min_volume_db: int = -60 setget set_default_master_min_volume_db, get_default_master_min_volume_db
var default_master_max_volume_db: int = 0 setget set_default_master_max_volume_db, get_default_master_max_volume_db
var default_master_current_volume_db: int = self.get_default_master_max_volume_db() setget set_default_master_current_volume_db, get_default_master_current_volume_db

var default_music_min_volume_db: int = -60 setget set_default_music_min_volume_db, get_default_music_min_volume_db
var default_music_max_volume_db: int = 0 setget set_default_music_max_volume_db, get_default_music_max_volume_db
var default_music_current_volume_db: int = self.get_default_music_max_volume_db() setget set_default_music_current_volume_db, get_default_music_current_volume_db

var default_sound_effects_min_volume_db: int = -60 setget set_default_sound_effects_min_volume_db, get_default_sound_effects_min_volume_db
var default_sound_effects_max_volume_db: int = 0 setget set_default_sound_effects_max_volume_db, get_default_sound_effects_max_volume_db
var default_sound_effects_current_volume_db: int = self.get_default_sound_effects_max_volume_db() setget set_default_sound_effects_current_volume_db, get_default_sound_effects_current_volume_db


var default_ambient_sounds_min_volume_db: int = -60 setget set_default_ambient_sounds_min_volume_db, get_default_ambient_sounds_min_volume_db
var default_ambient_sounds_max_volume_db: int = 0 setget set_default_ambient_sounds_max_volume_db, get_default_ambient_sounds_max_volume_db
var default_ambient_sounds_current_volume_db: int = self.get_default_ambient_sounds_max_volume_db()

################################# RUN THE CODE #################################

func _ready() -> void:
	TranslationServer.set_locale(OS.get_locale())
	
	self.initialize_sound()

############################### DECLARE FUNCTIONS ##############################


func initialize_sound() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), default_master_current_volume_db)
	print("Settings Autoload: ", default_master_current_volume_db)


# SETTERS AND GETTERS

func set_default_master_min_volume_db(value: int) -> void:
	default_master_min_volume_db = value


func get_default_master_min_volume_db() -> int:
	return default_master_min_volume_db


func set_default_master_max_volume_db(value: int) -> void:
	default_master_max_volume_db = value


func get_default_master_max_volume_db() -> int:
	return default_master_max_volume_db


func set_default_master_current_volume_db(value: int) -> void:
	default_master_current_volume_db = value


func get_default_master_current_volume_db() -> int:
	return default_master_current_volume_db

# --------------------------------------------------------------

func set_default_music_min_volume_db(value: int) -> void:
	default_music_min_volume_db = value


func get_default_music_min_volume_db() -> int:
	return default_music_min_volume_db


func set_default_music_max_volume_db(value: int) -> void:
	default_music_max_volume_db = value


func get_default_music_max_volume_db() -> int:
	return default_music_max_volume_db


func set_default_music_current_volume_db(value: int) -> void:
	default_music_current_volume_db = value


func get_default_music_current_volume_db() -> int:
	return default_music_current_volume_db


# --------------------------------------------------------------

func set_default_sound_effects_min_volume_db(value: int) -> void:
	default_sound_effects_min_volume_db = value


func get_default_sound_effects_min_volume_db() -> int:
	return default_sound_effects_min_volume_db


func set_default_sound_effects_max_volume_db(value: int) -> void:
	default_sound_effects_max_volume_db = value


func get_default_sound_effects_max_volume_db() -> int:
	return default_sound_effects_max_volume_db


func set_default_sound_effects_current_volume_db(value: int) -> void:
	default_sound_effects_current_volume_db = value


func get_default_sound_effects_current_volume_db() -> int:
	return default_sound_effects_current_volume_db

# --------------------------------------------------------------

func set_default_ambient_sounds_min_volume_db(value: int) -> void:
	default_ambient_sounds_min_volume_db = value


func get_default_ambient_sounds_min_volume_db() -> int:
	return default_ambient_sounds_min_volume_db


func set_default_ambient_sounds_max_volume_db(value: int) -> void:
	default_ambient_sounds_max_volume_db = value


func get_default_ambient_sounds_max_volume_db() -> int:
	return default_ambient_sounds_max_volume_db


func set_default_ambient_sounds_current_volume_db(value: int) -> void:
	default_ambient_sounds_current_volume_db = value


func get_default_ambient_sounds_current_volume_db() -> int:
	return default_ambient_sounds_current_volume_db
