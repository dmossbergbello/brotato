extends CharacterBody2D
class_name Enemie

@export var speed: float = 150
@export var damage: int = 1
@export var health: int = 5
var canAttack: bool = false

func _ready() -> void:
	add_to_group("enemies")  # asegura que siempre esté en el grupo, aunque no lo hayas puesto a mano en el editor

func _physics_process(delta: float) -> void:
	if Global.Player == null: return
	
	if canAttack:
		Attack()
	else:
		Move()

func Move():
	var Direction: Vector2 = global_position.direction_to(Global.Player.global_position)
	velocity = Direction.normalized() * speed
	move_and_slide()

func Attack():
	if $Timer.is_stopped():
		Global.Player.TakeDamage(damage)
		$Timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		canAttack = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		canAttack = false

func TakeDamage(damage: int):
	health -= damage
	if health <= 0: Die()

func Die():
	queue_free()
