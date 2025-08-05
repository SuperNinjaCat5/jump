extends CanvasLayer

func _ready():
	print("Game_Over_Overlay called _ready()")
	self.hide()
	
	if get_tree().paused == true:
		print("Game_Over_Overlay attempting resume")
		get_tree().paused = false
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	print("Game_Over_Overlay process_mode set to:", process_mode)
	
	$Retry.process_mode = Node.PROCESS_MODE_ALWAYS
	print("Game_Over_Overlay, RetryButton process_mode set to:", $Retry.process_mode)

func _on_retry_pressed() -> void:
	print("Retry Pressed")
	get_tree().reload_current_scene()

func game_over():
	print("game_over() was called in Game_Over_Overlay")
	get_tree().paused = true
	self.show()
