extends Line2D

signal no_time;

func _decrease():
	points[1].x -= 10;

func _is_over():
	return points[1].x == 0;

func _on_task_timer_timeout():
	_decrease()
	if _is_over():
		emit_signal("no_time")
		$taskTimer.stop()
	pass 
