extends Node2D

enum SlingState{
	idle,
	pulling,
	birdThrown,
	reset
}

var SlingShotState
@onready var right_line: Line2D = $RightLine
@onready var left_line: Line2D = $LeftLine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SlingShotState = SlingState.idle
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match SlingShotState:
		SlingState.idle:
			pass
		SlingState.pulling:
			if Input.is_action_pressed("LeftMouse"):
				var mousepos = get_global_mouse_position()-position
				if mousepos.distance_to($CenterOfSlingShot.position) > 100:
					mousepos = (mousepos - $CenterOfSlingShot.position).normalized() * 100 + $CenterOfSlingShot.position
				left_line.points[1] = mousepos
				right_line.points[1] = mousepos
			else:
				var location = get_global_mouse_position()-position
				var distance = location.distance_to($CenterOfSlingShot.position)
				var velocity = $CenterOfSlingShot.position - location
				
		SlingState.birdThrown:
			pass
		SlingState.reset:
			pass



func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	SlingShotState = SlingState.pulling
	pass # Replace with function body.
