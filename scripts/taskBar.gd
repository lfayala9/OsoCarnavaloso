extends Line2D

#signal no_time;
#func _ready():
	#points[1].x = 200
#
#func _decrease():
	#points[1].x -= 10;
#
#func _is_over():
	#return points[1].x == 0;
#
#func _on_task_timer_timeout():
	#_decrease()
	#if _is_over():
		#emit_signal("no_time")
		#$taskTimer.stop()
	#pass 


signal no_time
signal remove_bar

@onready var task_timer = $taskTimer  # Asegura que el Timer está referenciado correctamente
var counter = 10;


func _ready():
	points[1].x = 200  # Inicializar la barra en tamaño máximo
	task_timer.start()  # Iniciar el Timer al crearse

func _decrease():
	points[1].x -= counter

func _is_over():
	return points[1].x <= 0  # Usar <= para evitar posibles errores de precisión

func _on_task_timer_timeout():
	_decrease()
	if _is_over():
		emit_signal("no_time")
		emit_signal("remove_bar")  # Emitir la señal cuando la barra se agote
		task_timer.stop()
