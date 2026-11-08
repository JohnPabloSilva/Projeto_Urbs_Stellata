extends CharacterBody2D

signal damage_received(amount: int)

enum State { IDLE, RUN, ROLL, ATTACK_LIGHT, ATTACK_HEAVY }

@export var move_speed := 110.0
@export var roll_speed := 330.0

@onready var facing: Node2D = $Facing
@onready var hurtbox: Area2D = $Hurtbox
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var light_shape: CollisionShape2D = $Facing/SwordPivot/LightHitbox/CollisionShape2D
@onready var heavy_shape: CollisionShape2D = $Facing/SwordPivot/HeavyHitbox/CollisionShape2D

var state := State.IDLE
var elapsed := 0.0
var roll_cooldown := 0.0
var roll_direction := Vector2.RIGHT
var saved_mask := 0
var hit_targets: Dictionary = {}


func _ready() -> void:
	hurtbox.area_entered.connect(_on_enemy_hitbox_entered)
	# Conecte animation_finished no editor para efeitos visuais.
	# Use uma faixa Call Method para sons/partículas no impacto.
	# A física controla a janela de dano e as transições.
	_play_animation(&"idle")


func _physics_process(delta: float) -> void:
	roll_cooldown = maxf(0.0, roll_cooldown - delta)
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	_update_aim()
	if state == State.IDLE or state == State.RUN:
		_read_actions(direction)

	velocity = direction * move_speed
	match state:
		State.ROLL:
			velocity = roll_direction * roll_speed
		State.ATTACK_LIGHT, State.ATTACK_HEAVY:
			velocity *= 0.20
	move_and_slide()
	_update_aim()

	elapsed += delta
	match state:
		State.ROLL:
			if elapsed >= 0.35:
				hurtbox.collision_mask = saved_mask
				roll_cooldown = 0.55
				_set_state(_movement_state(direction))
		State.ATTACK_LIGHT:
			_update_attack(direction, delta, light_shape, 12, 0.05, 0.08, 0.12)
		State.ATTACK_HEAVY:
			_update_attack(direction, delta, heavy_shape, 35, 0.26, 0.12, 0.36)


func _read_actions(direction: Vector2) -> void:
	if Input.is_action_just_pressed("roll") and roll_cooldown <= 0.0:
		roll_direction = direction
		if direction.is_zero_approx():
			roll_direction = Vector2.RIGHT.rotated(facing.global_rotation)
		saved_mask = hurtbox.collision_mask
		hurtbox.collision_mask = 0
		_set_state(State.ROLL)
	elif Input.is_action_just_pressed("attack_heavy"):
		_set_state(State.ATTACK_HEAVY)
	elif Input.is_action_just_pressed("attack_light"):
		_set_state(State.ATTACK_LIGHT)
	else:
		_set_state(_movement_state(direction))


func _update_aim() -> void:
	var aim := get_global_mouse_position() - facing.global_position
	if not aim.is_zero_approx():
		facing.global_rotation = aim.angle()


func _update_attack(direction: Vector2, delta: float, shape: CollisionShape2D,
		damage: int, windup: float, active: float, recovery: float) -> void:
	var impact_end := windup + active
	if elapsed >= windup and elapsed - delta < impact_end:
		_hit_enemies(shape, damage)
	if elapsed >= impact_end + recovery:
		_set_state(_movement_state(direction))


func _hit_enemies(shape: CollisionShape2D, damage: int) -> void:
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape.shape
	query.transform = shape.global_transform
	query.collision_mask = 1 << 3  # Hurtboxes inimigas na camada 4.
	query.collide_with_areas = true
	query.collide_with_bodies = false
	for result in get_world_2d().direct_space_state.intersect_shape(query, 64):
		var area := result["collider"] as Area2D
		if not is_instance_valid(area):
			continue
		var enemy := area.get_parent()
		if not is_instance_valid(enemy) or not enemy.has_method(&"receive_damage"):
			continue
		var id := enemy.get_instance_id()
		if not hit_targets.has(id):
			hit_targets[id] = true
			enemy.call(&"receive_damage", damage)


func _on_enemy_hitbox_entered(hitbox: Area2D) -> void:
	if state != State.ROLL and hitbox.has_method(&"get_damage"):
		receive_damage(int(hitbox.call(&"get_damage")))


func receive_damage(amount: int) -> void:
	if state != State.ROLL and amount > 0:
		damage_received.emit(amount)


func _movement_state(direction: Vector2) -> State:
	return State.IDLE if direction.is_zero_approx() else State.RUN


func _set_state(next_state: State) -> void:
	if state == next_state:
		return
	state = next_state
	elapsed = 0.0
	hit_targets.clear()
	match state:
		State.IDLE:
			_play_animation(&"idle")
		State.RUN:
			_play_animation(&"run")
		State.ROLL:
			_play_animation(&"roll")
		State.ATTACK_LIGHT:
			_play_animation(&"attack_light")
		State.ATTACK_HEAVY:
			_play_animation(&"attack_heavy")


func _play_animation(clip: StringName) -> void:
	if animations.has_animation(clip):
		animations.play(clip)
