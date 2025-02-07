extends Node2D
var stress_counter: int = 6;
@onready var bar = $stress

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.text = str(stress_counter);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	$Control/Label.text = "bad choice you are more stressed"
	bar.text = str(stress_counter - 1)
	pass # Replace with function body.



func _on_timer_bar_no_time():
	$Control/Label.text = "bad choice you are more stressed"
	bar.text = str(stress_counter - 1)
	pass # Replace with function body.
