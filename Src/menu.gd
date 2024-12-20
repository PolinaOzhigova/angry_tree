extends Node2D


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_quit_pressed() -> void:
	get_tree().quit()
	$ClickButton.play()
	
func _on_quit_mouse_entered() -> void:
	$HoverButton.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Src/lvl/level.tscn")
	$ClickButton.play()

func _on_play_mouse_entered() -> void:
	$HoverButton.play()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Src/settings/settings.tscn")
	$ClickButton.play()
	
func _on_settings_mouse_entered() -> void:
	$HoverButton.play()
