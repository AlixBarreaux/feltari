class_name Player
extends KinematicBody2D


# Class containing all the player's information.
# Player controller is directly put there, might need decoupling.

############################### DECLARE VARIABLES ##############################

export var current_speed: int = 150 setget set_current_speed, get_current_speed
export var normal_speed: int = 150
export var max_speed = 300

export var current_health: int = 0
export var max_health: int = 0 setget set_max_health, get_max_health

export var current_melee_attack_damage: int = 1
export var max_melee_attack_damage: int = 2


# Enables/Disables all nodes requiring to be active or not
# along  with the player inputs and physics
var enabled: bool = true setget set_enabled, get_enabled

var direction: Vector2 = Vector2(0.0, 0.0) setget set_direction, get_direction
var velocity: Vector2 = Vector2(0.0, 0.0) setget set_velocity
var faced_direction: Vector2 = Vector2(0.0, 0.0)

var spawn_point: Vector2 = Vector2(0.0, 0.0) setget set_spawn_point, get_spawn_point

var can_move: bool = true
var can_melee_attack = true

var targeted_interactable: PhysicsBody2D = null

# Node References

# Collision Shapes 2D
onready var collision_shape2D: CollisionShape2D = $CollisionShape2D
onready var hurt_box_collision_shape2D: CollisionShape2D = $HurtBoxBoxPivot/HurtBox/CollisionShape2D
onready var interact_zone_collision_shape2D: CollisionShape2D = $InteractZone/CollisionShape2D

# Timers
onready var melee_attack_cooldown_timer: Timer = $MeleeAttackCooldownTimer
onready var death_wait_timer: Timer = $DeathWaitTimer

# Other nodes
onready var fairy_sprite: Sprite = $FairySprite
onready var player_hurt_animation_player: AnimationPlayer = $PlayerHurtAnimationPlayer


################################# RUN THE CODE #################################


func _ready() -> void:
	self._initialize_asserts()
	self._initialize_signals()
	self._initialize()
	
	animation_tree.set_active(true)
	anim_tree_sm_playback.start("Idle")
	
	self.set_enabled(false)
	$Camera2D._set_current(false)
	self.set_current_health(self.get_max_health())
	

var is_attacking: bool = false
func _physics_process(_delta: float) -> void:
	self.calculate_velocity()
	if not self.velocity != Vector2(0.0, 0.0):
		if not is_attacking:
			animation_tree.set("parameters/Idle/blend_position", faced_direction)
			anim_tree_sm_playback.travel("Idle")
	else:
		if not is_attacking:
			animation_tree.set("parameters/Walk/blend_position", faced_direction)
			anim_tree_sm_playback.travel("Walk")


	if can_move:
		velocity = move_and_slide(velocity)



func _unhandled_input(_event: InputEvent) -> void:
	self.set_direction(Vector2(0.0, 0.0))
	
	# Move
	if Input.get_action_strength("move_left"):
		self.direction.x = -1
		self.faced_direction = Vector2(-1, 0.0)
		
	if Input.get_action_strength("move_right"):
		self.direction.x = 1
		self.faced_direction = Vector2(1, 0.0)
	
	if Input.get_action_strength("move_up"):
		self.direction.y = -1
		self.faced_direction = Vector2(0.0, -1.0)
	
	if Input.get_action_strength("move_down"):
		self.direction.y = 1
		self.faced_direction = Vector2(0.0, 1.0)

	
	if Input.is_action_just_pressed("attack_melee"):
		if can_melee_attack:
#			can_move = false
			attack_melee()
	
	
	# Interact
	if Input.is_action_just_pressed("interact"):
		print(get_can_interact())
		if self.get_can_interact():
			if targeted_interactable != null:
				targeted_interactable.receive_interaction()
				targeted_interactable = null
	
	
	self.direction = self.direction.normalized()



onready var animation_tree: AnimationTree = $AnimationTree
onready var anim_tree_sm_playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")


# TEST
var can_interact: bool = true

func set_can_interact(value: bool) -> void:
	can_interact = value

func get_can_interact() -> bool:
	return can_interact


func set_can_move(value: bool) -> void:
	can_move = value
	
func get_can_move() -> bool:
	return can_move


func set_enabled(value: bool) -> void:
	if value:
		set_physics_process(true)
		set_process_unhandled_input(true)
		
		collision_shape2D.set_deferred("disabled", false)
		hurt_box_collision_shape2D.set_deferred("disabled", false)
		interact_zone_collision_shape2D.set_deferred("disabled", false)
		
		anim_tree_sm_playback.start("Idle")
		
		melee_attack_cooldown_timer.start()
	else:
		set_physics_process(false)
		set_process_unhandled_input(false)
		
		collision_shape2D.set_deferred("disabled", true)
		hurt_box_collision_shape2D.set_deferred("disabled", true)
		interact_zone_collision_shape2D.set_deferred("disabled", true)
		
		melee_attack_cooldown_timer.stop()


func get_enabled() -> bool:
	return enabled


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	# Must be more than 0!
	assert(self.current_health > 0)
	assert(self.max_health > 0)
	# Current Health must be less or equal to max health!
	assert(self.current_health <= self.max_health)


func _initialize_signals() -> void:
	Events.connect("game_started", self, "on_game_started")


func _initialize() -> void:
	fairy_sprite.hide()
	self.set_spawn_point(self.global_position)
#	Events.emit_signal("player_current_health_set", self.get_current_health())
#	Events.emit_signal("player_max_health_set", self.get_max_health())


# SETTERS AND GETTERS

func set_current_health(value: int) -> void:
	current_health = value
	if current_health > max_health:
		current_health = max_health
	print(self.name + " Current health set to: " + str(value))


func get_current_health() -> int:
	return current_health


func set_max_health(value: int) -> void:
	max_health = value
	print(self.name + ": max value set to: " + str(value))


func get_max_health() -> int:
	return max_health


func set_current_speed(new_speed: int) -> void:
	current_speed = new_speed


func get_current_speed() -> int:
	return current_speed


func set_current_damage(amount: int) -> void:
	current_melee_attack_damage = amount


func get_current_damage() -> int:
	return current_melee_attack_damage


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction


func get_direction() -> Vector2:
	return direction


func set_velocity(new_velocity: Vector2) -> void:
	velocity = new_velocity


func set_can_melee_attack(value: bool) -> void:
	can_melee_attack = value


func set_spawn_point(new_spawn_point: Vector2) -> void:
	spawn_point = new_spawn_point


func get_spawn_point() -> Vector2:
	return spawn_point


# GENERIC FUNCTIONS
func get_can_melee_attack() -> bool:
	return can_melee_attack


func calculate_velocity() -> void:
	self.velocity = self.direction * self.current_speed


# ANIMATIONS
func melee_attack_animation_finished() -> void:
	melee_attack_cooldown_timer.start()
	is_attacking = false
	self.set_can_interact(true)


func on_die_animation_finished() -> void:
	Events.emit_signal("player_died")
	death_wait_timer.start()


# Must rename to on_fairy_spawn_animation_finished()
func on_spawn_animation_finished() -> void:
	$FairyAnimationPlayer.play("Idle")



func attack_melee() -> void:
	set_can_interact(false)
	is_attacking = true
	animation_tree.set("parameters/Melee Attack/blend_position", faced_direction)
	anim_tree_sm_playback.travel("Melee Attack")


# Send damage from the weapon collision zone (HurtBox) to whatever is in 
# its collision layer (should collide with "Enemy" layer)
func _on_HurtBox_body_entered(body: PhysicsBody2D) -> void:
	print(self.name, ": I was entered by: ", body.name)
	body.take_damage(self.get_current_damage())


func _on_InteractZone_body_entered(body: PhysicsBody2D) -> void:
	# Add the interatable as the target for interaction with the player
	self.targeted_interactable = body
	print(self.name + ": Interact target set to: " + body.name)


func _on_InteractZone_body_exited(_body: PhysicsBody2D) -> void:
	# Remove the interactable target since it's out of the player's
	# interaction range (Area2D)
	self.targeted_interactable = null



func _on_MeleeAttackCooldownTimer_timeout() -> void:
	can_melee_attack = true


# Affect the Fairy's colors with transparency
# properly in the FairyAnimationPlayer

var current_fairy_current_color: Color = Color(0, 0, 0, 1) setget set_fairy_current_color, get_fairy_current_color
func set_fairy_current_color(new_color: Color) -> void:
	current_fairy_current_color = new_color
	fairy_sprite.set("self_modulate", self.get_fairy_current_color())


func get_fairy_current_color() -> Color:
	return current_fairy_current_color

#func set_fairy_current_color_transparency(transparency: int) -> void:
#	self.current_fairy_current_color.a = transparency


func spawn_following_fairy(new_color: Color) -> void:
	set_fairy_current_color(new_color)
	$FairyAnimationPlayer.play("Spawn")


func despawn_following_fairy() -> void:
	$FairyAnimationPlayer.play("Despawn")






func check_if_dead() -> void:
	if self.current_health <= 0:
			self.current_health = 0
			self.die()
	print(self.name + ": Health status: " + str(current_health) + " / " + str(max_health))


func die() -> void:
	print(self.name + str(": I died!"))
	self.set_enabled(false)
	player_hurt_animation_player.stop()
	anim_tree_sm_playback.travel("Die")


func resurrect() -> void:
	set_current_health(get_max_health())
	self.set_global_position(get_spawn_point())
	self.set_enabled(true)


func take_damage(amount: int) -> void:
	decrease_current_health(amount)




# Loose Health AND Send an update to the InGameGUI for the Health Bar
func decrease_current_health(amount: int) -> void:
#	self.current_health -= amount
	self.set_current_health(get_current_health() - amount)
	
	print(self.name + ": I took " + str(amount) + " damage!")
	player_hurt_animation_player.play("Hurt")
	self.check_if_dead()
	
	Events.emit_signal("player_current_health_decreased", amount)


# Gain Health AND Send an update to the InGameGUI for the Health Bar
func increase_current_health(amount: int) -> void:
#	self.current_health += amount
	self.set_current_health(get_current_health() + amount)
	print(self.name + ": I was healed by " + str(amount) + " health points!")
	Events.emit_signal("player_current_health_increased", amount)


func _on_DeathWaitTimer_timeout() -> void:
	print("DEATH TIMEOUT!")
	self.resurrect()


func on_game_started() -> void:
	yield(get_tree().create_timer(2.0), "timeout")
	self.set_enabled(true)
	$Camera2D._set_current(true)
