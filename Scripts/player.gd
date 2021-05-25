class_name Player
extends KinematicBody2D


# Class containing all the player's information.
# Player controller is directly put there, might need decoupling.

############################### DECLARE VARIABLES ##############################

export var current_speed: int = 150 setget set_current_speed, get_current_speed
export var normal_speed: int = 150
export var max_speed = 300

export var current_health: int = 0
export var max_health: int = 0

export var current_melee_attack_damage: int = 1
export var max_melee_attack_damage: int = 2


# Enables/Disables all nodes requiring to be active or not
# along  with the player inputs and physics
var enabled: bool = true setget set_enabled, get_enabled

var direction: Vector2 = Vector2(0.0, 0.0) setget set_direction, get_direction
var velocity: Vector2 = Vector2(0.0, 0.0) setget set_velocity
var faced_direction: Vector2 = Vector2(0.0, 0.0)

var can_move: bool = true
var can_melee_attack = true

var targeted_interactable: PhysicsBody2D = null


onready var fairy_sprite: Sprite = $FairySprite

################################# RUN THE CODE #################################

func _ready() -> void:
	self._initialize_asserts()
	self._initialize()
	
	animation_tree.set_active(true)
	anim_tree_sm_playback.start("Idle")
	


func _physics_process(_delta: float) -> void:
	self.calculate_velocity()
#	if not self.velocity != Vector2(0.0, 0.0):
#		anim_tree_sm_playback.travel("Idle")
#		return

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
		$CollisionShape2D.set_deferred("disabled", false)
		$HurtBoxBoxPivot/HurtBox/CollisionShape2D.set_deferred("disabled", false)
		$InteractZone/CollisionShape2D.set_deferred("disabled", false)
		$MeleeAttackCooldownTimer.start()
	else:
		set_physics_process(false)
		set_process_unhandled_input(false)
		$CollisionShape2D.set_deferred("disabled", true)
		$HurtBoxBoxPivot/HurtBox/CollisionShape2D.set_deferred("disabled", true)
		$InteractZone/CollisionShape2D.set_deferred("disabled", true)
		$MeleeAttackCooldownTimer.stop()


func get_enabled() -> bool:
	return enabled


############################### DECLARE FUNCTIONS ##############################


func _initialize_asserts() -> void:
	# Must be more than 0!
	assert(self.current_health > 0)
	assert(self.max_health > 0)
	# Current Health mus be less or equal to max health!
	assert(self.current_health <= self.max_health)


func _initialize() -> void:
	fairy_sprite.hide()


# Setters and Getters for public variables
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


func calculate_velocity() -> void:
	self.velocity = self.direction * self.current_speed


# ANIMATIONS
func melee_attack_animation_finished() -> void:
	$MeleeAttackCooldownTimer.start()
	pass


func on_spawn_animation_finished() -> void:
	$FairyAnimationPlayer.play("Idle")



func attack_melee() -> void:
	set_can_interact(false)
	animation_tree.set("parameters/Melee Attack/blend_position", faced_direction)
	anim_tree_sm_playback.travel("Melee Attack")


func set_can_melee_attack(value: bool) -> void:
	can_melee_attack = value


func get_can_melee_attack() -> bool:
	return can_melee_attack


func take_damage(amount: int) -> void:
	self.current_health -= amount
	print(self.name + ": I took " + str(amount) + " damage!")
	anim_tree_sm_playback.travel("Take Damage")
	
	self.check_if_dead()
	
	

func check_if_dead() -> void:
	if self.current_health <= 0:
			self.current_health = 0
			self.die()
	print(self.name + ": Health status: " + str(current_health) + " / " + str(max_health))


func die() -> void:
	print(self.name + str(": I died!"))
	self.set_enabled(false)
	anim_tree_sm_playback.travel("Die")


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
	fairy_sprite.set("self_modulate", current_fairy_current_color)


func get_fairy_current_color() -> Color:
	return current_fairy_current_color

#func set_fairy_current_color_transparency(transparency: int) -> void:
#	self.current_fairy_current_color.a = transparency




func spawn_following_fairy(new_color: Color) -> void:
	set_fairy_current_color(new_color)
	$FairyAnimationPlayer.play("Spawn")


func despawn_following_fairy() -> void:
	$FairyAnimationPlayer.play("Despawn")




signal current_health_changed

func set_current_health(value: int) -> void:
	current_health = value
#	emit_signal("current_health_changed", cur)


func get_current_health() -> int:
	return current_health

func add_current_health(amount: int) -> void:
	self.current_health += amount
	self.set_current_health(get_current_health() + amount)
	print("ADD HEALTH TRIGGGERED, NEEDS TO UPDATE HEALTH!")
