extends Node2D  # O el nodo principal del mapa

var pin_texture = preload("res://assets/pop_up.png")
var pin_positions = [Vector2(250, 200), Vector2(300, 250), Vector2(500, 100)]  # Lista de posiciones
var current_index = 0

@onready var timer = $Timer_pop  # Asegúrate de que hay un Timer en la escena

func _ready():
	timer.wait_time = 2.0  # Intervalo de 2 segundos
	timer.start()
	timer.timeout.connect(_spawn_pin)  # Conectar la señal timeout

func _spawn_pin():
	if current_index < pin_positions.size():
		var pin = TextureButton.new()
		pin.texture_normal = pin_texture
		pin.position = pin_positions[current_index]
		pin.scale = Vector2(0.15, 0.15)  # Reducir a la mitad

		pin.pressed.connect(_on_pin_pressed.bind(current_index))  # Conectar evento clic
		
		add_child(pin)
		current_index += 1
	else:
		timer.stop()

func _on_pin_pressed(index):
	print("Pin " + str(index) + " fue presionado")
