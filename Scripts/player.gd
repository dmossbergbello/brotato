extends CharacterBody2D
class_name Player

@export var speed: float = 350
@export var health: int = 20
var bullet = preload("res://Escenas/bullet.tscn")

func _ready() -> void:
	Global.Player = self

func _physics_process(delta: float) -> void:
	var Direccion := Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
	velocity = Direccion * speed
	move_and_slide()

func Shoot():
	var enemies = $Area2D.get_overlapping_bodies()
	var mas_cercano: Enemie = null
	var distance = INF
	
	for enemy in enemies:
		if enemy.is_in_group("enemies"):
			var d = global_position.distance_to(enemy.global_position)
			if d < distance:
				distance = d
				mas_cercano = enemy
	
	if mas_cercano != null:
		var b = bullet.instantiate()
		get_tree().current_scene.add_child(b)
		var pos: Vector2 = $Arma/ChainGun/Pivote.global_position
		b.global_position = pos
		b.Direction = pos.direction_to(mas_cercano.global_position)

func TakeDamage(damage: int):
	$CPUParticles2D.emitting = true
	health -= damage
	if health <= 0: Die()

func Die():
	queue_free()

func _on_cd_timeout() -> void:
	Shoot()
