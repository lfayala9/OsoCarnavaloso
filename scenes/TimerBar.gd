extends Line2D

signal no_time;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _decrease():
	points[1].x -= 10

func lose_stress():
	return points[1].x == 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bar_timer_timeout():
	_decrease();
	if lose_stress(): 
		emit_signal("no_time")	
		$barTimer.stop()
	pass # Replace with function body.
