extends Node2D

const FLOOR := Rect2(-152, -88, 304, 176)

var damage_taken := 0
var damage_dealt := 0
var last_hit := 0

@onready var status: Label = $HUD/Status


func _ready() -> void:
	_add_wall(Vector2(0, -92), Vector2(320, 8))
	_add_wall(Vector2(0, 92), Vector2(320, 8))
	_add_wall(Vector2(-156, 0), Vector2(8, 176))
	_add_wall(Vector2(156, 0), Vector2(8, 176))
	$Player.damage_received.connect(_on_player_hit)
	$Target.hit.connect(_on_target_hit)
	_update_status()


func _add_wall(center: Vector2, size: Vector2) -> void:
	var wall := StaticBody2D.new()
	wall.position = center
	var collider := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	rectangle.size = size
	collider.shape = rectangle
	wall.add_child(collider)
	add_child(wall)


func _draw() -> void:
	draw_rect(FLOOR.grow(8), Color("#46516a"))
	draw_rect(FLOOR, Color("#202b3f"))
	for x in range(-144, 152, 16):
		draw_line(Vector2(x, -88), Vector2(x, 88), Color("#2d3950"))
	for y in range(-80, 88, 16):
		draw_line(Vector2(-152, y), Vector2(152, y), Color("#2d3950"))


func _on_player_hit(amount: int) -> void:
	damage_taken += amount
	_update_status()


func _on_target_hit(amount: int) -> void:
	damage_dealt += amount
	last_hit = amount
	_update_status()


func _update_status() -> void:
	status.text = (
		"WASD mover   |   Mouse mirar   |   Esq. leve   |   Dir. forte   |   Espaço esquivar\n"
		+ "Alvo: %d de dano (último golpe: %d)   |   Dano recebido: %d\n"
		% [damage_dealt, last_hit, damage_taken]
		+ "O pulso laranja avisa o ataque. Esquive quando ficar vermelho."
	)
