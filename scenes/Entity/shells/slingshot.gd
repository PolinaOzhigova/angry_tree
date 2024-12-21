extends Node2D

enum SlingState{
	idle,
	pulling,
	projectileThrown,
	reset
}

var SlingShotState
@onready var right_line: Line2D = $RightLine
@onready var left_line: Line2D = $LeftLine
@onready var center_of_sling_shot: Vector2 = $CenterOfSlingShot.position




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SlingShotState = SlingState.idle
	left_line.points[1] = center_of_sling_shot
	right_line.points[1] = center_of_sling_shot
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match SlingShotState:
		SlingState.idle:
			pass
		SlingState.pulling:
			var projectile = get_tree().get_nodes_in_group("Projectile")[0]
			projectile = projectile as RigidBody2D
			if Input.is_action_pressed("LeftMouse"):
				var mousepos = get_global_mouse_position()-position
				if mousepos.distance_to(center_of_sling_shot) > 100:
					mousepos = (mousepos - center_of_sling_shot).normalized() * 100 + center_of_sling_shot
				projectile.position = mousepos+position
				left_line.points[1] = mousepos
				right_line.points[1] = mousepos
			else:
				var location = get_global_mouse_position()-position
				var distance = location.distance_to(center_of_sling_shot)
				var velocity = center_of_sling_shot - location
				projectile.ThrowProjectile()
				projectile.apply_impulse(velocity/50*distance)
				SlingShotState = SlingState.projectileThrown
				left_line.points[1] = center_of_sling_shot
				right_line.points[1] = center_of_sling_shot
				GameManager.CurrentGameState = GameManager.GameState.Play
		SlingState.projectileThrown:
			pass
		SlingState.reset:
			pass



func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if SlingShotState == SlingState.idle:
		if (event is InputEventMouseButton && event.is_pressed()):
			SlingShotState = SlingState.pulling
	pass # Replace with function body.
