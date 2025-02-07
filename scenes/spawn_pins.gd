extends Node2D  # O el nodo principal del mapa

var pin_texture = preload("res://assets/pop_up.png")
var pin_positions = [Vector2(100, 200), Vector2(300, 400), Vector2(500, 100)]  # Lista de posiciones
var current_index = 0

@onready var timer = $Timer_pop  # Asegúrate de que hay un Timer en la escena

func _ready():
	timer.wait_time = 2.0  # Intervalo de 2 segundos
	timer.start()
	timer.timeout.connect(_spawn_pin)  # Conectar la señal timeout

func _spawn_pin():
	if current_index < pin_positions.size():
		var pin = TextureRect.new()
		pin.texture = pin_texture
		pin.position = pin_positions[current_index]
		add_child(pin)
		
		current_index += 1  # Pasar al siguiente pin
	else:
		timer.stop()  # Detener el timer si ya no hay más pins
