extends CharacterBody2D

var Direction: Vector2
var speed:= 1000

func _physics_process(delta: float) -> void:
	velocity = Direction.normalized() * speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.TakeDamage(1)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
