extends Node2D

signal hit(amount: int)

var pulse_active := false
const PULSE_RADIUS := 68.0
const CYCLE := 3.0
const WINDUP_START := 1.9
const IMPACT_START := 2.65

var elapsed := 0.0
var flash := 0.0

@onready var pulse_shape: CollisionShape2D = $Pulse/CollisionShape2D


func _physics_process(delta: float) -> void:
	elapsed = fmod(elapsed + delta, CYCLE)
	flash = maxf(0.0, flash - delta)
	var active := elapsed >= IMPACT_START
	if active != pulse_active:
		pulse_active = active
		pulse_shape.set_deferred("disabled", not active)
	queue_redraw()


func receive_damage(amount: int) -> void:
	flash = 0.15
	hit.emit(amount)


func _draw() -> void:
	if elapsed >= WINDUP_START:
		var active := elapsed >= IMPACT_START
		var color := Color(1.0, 0.25, 0.22, 0.45) if active else Color(1.0, 0.66, 0.2, 0.18)
		draw_circle(Vector2.ZERO, PULSE_RADIUS, color)
		draw_arc(Vector2.ZERO, PULSE_RADIUS, 0.0, TAU, 48, color.lightened(0.3), 1.0)
	draw_rect(Rect2(-11, -11, 22, 22), Color("#fff2c8") if flash > 0.0 else Color("#cb6449"))
	draw_rect(Rect2(-6, -6, 12, 12), Color("#592c3e"))
