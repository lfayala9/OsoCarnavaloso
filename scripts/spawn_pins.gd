extends Node2D  # O el nodo principal del mapa

#var pin_positions = [Vector2(250, 200), Vector2(300, 250), Vector2(500, 100)]  # Lista de posiciones
#var current_index = 0
#
#@onready var timer = $Timer_pop  # Asegúrate de que hay un Timer en la escena
#
#func _ready():
	#timer.wait_time = 2.0  # Intervalo de 2 segundos
	#timer.start()
	#timer.timeout.connect(_spawn_pin)  # Conectar la señal timeout
#
#func _spawn_pin():
	#if current_index < pin_positions.size():
		#var pin = $pin;
		#pin.visible = true
		#pin.position = pin_positions[0]
		#pin.pressed.connect(_on_pin_pressed.bind(current_index))  # Conectar evento clic
		#
		##add_child(pin)
		#current_index += 1
	#else:
		#timer.stop()
#
#func _on_pin_pressed(index):
	#print("Pin " + str(index) + " fue presionado sí")
	#pass
var pin_positions = [Vector2(250, 200), Vector2(500, 100), Vector2(125, 670), Vector2(460, 692), Vector2(513, 482), Vector2(847, 516), Vector2(732, 246)]  
var active_pins = {}  # Diccionario para rastrear posiciones ocupadas

@onready var timer = $Timer_pop
@onready var pin_scene = $pin  # Referencia al nodo base (el que se reutiliza)

func _ready():
	randomize()  
	timer.wait_time = randf_range(1, 6)  
	timer.start()
	timer.timeout.connect(_spawn_pin)

func _spawn_pin():
	# Obtener posiciones disponibles (donde no hay un pin actualmente)
	var available_positions = pin_positions.filter(func(pos): return !active_pins.has(pos))
	
	if available_positions.size() > 0:
		var chosen_position = available_positions[randi() % available_positions.size()]  
		var new_pin = pin_scene.duplicate()  
		new_pin.position = chosen_position
		new_pin.visible = true  
		new_pin.pressed.connect(_on_pin_pressed.bind(chosen_position))

		add_child(new_pin)  
		active_pins[chosen_position] = new_pin  # Marcar la posición como ocupada
		
		# Conectar la señal no_time de la taskBar
		var task_bar = new_pin.get_node("taskBar")  # Asegúrate de que el pin tenga una taskBar como hijo
		task_bar.no_time.connect(_on_task_bar_remove_bar.bind(chosen_position))

		# Configurar el próximo spawn con otro tiempo aleatorio
		timer.wait_time = randf_range(3, 7)
		timer.start()
	else:
		print("Todas las posiciones están ocupadas. Esperando...")  # Depuración opcional
func _on_pin_pressed(position):
	print("Pin en posición " + str(position) + " fue presionado")
	_remove_pin(position)

func _remove_pin(position):
	if active_pins.has(position):
		active_pins[position].queue_free()  # Eliminar el pin
		active_pins.erase(position)  # Liberar la posición

func _on_task_bar_remove_bar(position):
	_remove_pin(position)
	pass # Replace with function body.
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print("Click en posición:", event.position)
