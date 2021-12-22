extends CanvasLayer


signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_game():
	$StartButton.hide()
	emit_signal("start_game")


func update_score(score):
	$ScoreLabel.text = str(score)


func show_message(text):
	$Message.text = text
	$Message.show()


func show_temporary_message(text):
	show_message(text)
	$MessageTimer.start()


func game_over():
	show_temporary_message("Game over")
	
	yield($MessageTimer, "timeout")
	
	show_message("Dodge the Creeps!")
	
	yield(get_tree().create_timer(1), "timeout")
	
	$StartButton.show()


func _on_StartButton_pressed():
	start_game()


func _on_MessageTimer_timeout():
	$Message.hide()
