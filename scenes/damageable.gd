extends RigidBody2D

@export_range(1, 1000)
var health: int = 10

var processed_velocity: Vector2 = Vector2()
var processed_angular_velocity: Vector2 = Vector2()

func _physics_process(delta):
	# Получаем текущую скорость
	processed_velocity = get_linear_velocity()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var contact = state.get_contact_collider_object(i)
		if contact == null:
			continue  # Пропускаем, если объекта нет
		
		# Скорость контактирующего объекта
		var contact_velocity = state.get_contact_collider_velocity_at_position(i)

		# Собственная скорость в точке контакта (линейная)
		var self_velocity = state.get_linear_velocity()

		# Разница скоростей
		var v = contact_velocity - self_velocity

		# Отладка
		print("Contact velocity:", contact_velocity)
		print("Self velocity:", self_velocity)
		print("Relative velocity:", v)


func _on_body_entered(body: Node) -> void:
	# Передаем длину вектора скорости в качестве урона
	get_damage(processed_velocity.length()*0.01)

func get_damage(damage: float) -> void:
	print("Damage:", damage)
	health -= damage
	if health <= 0:
		queue_free()
