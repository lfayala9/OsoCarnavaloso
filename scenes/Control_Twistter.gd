extends Node2D

# Variables
var images = []  # Aquí almacena las rutas de las imágenes
var texts = ["Bienvenido a tu primer día, seguro lo haces genial", 
	"Necesitamos cerveza para el botellon de cibeles", 
	"¿Por qué tarda tanto la comida?", 
	"Melendi ya no canta como antes", 
	"Qué es el mago de oz", 
	"NO HAY DONDE COMPRAR COMIDA CON TARJETA", 
	"OSO", 
	"OSO TRABAJA", 
	"¿QUIÉN ESTA AL CARGO EN MADRID??", 
	"CORRE MONTOYA CORRE", 
	"Tenedor", 
	"Mensaje 12", 
	"Mensaje 13", 
	"Mensaje 14", 
	"Mensaje 15", 
	"Mensaje 16", 
	"Mensaje 17"]
@onready var sprite = $Sprite2D
@onready var label = $Label
@onready var image_timer = $ImageTimer
@onready var cycle_timer = $CycleTimer
var current_index = 0  # Índice para seguir el orden de los mensajes

func _ready():
	# Agrega las rutas de las imágenes a la lista
	images = [
		load("res://assets/popup-avatar3.png"),
		load("res://assets/popup-avatar4.png"),
		load("res://assets/popup-avatar5.png"),
		load("res://assets/popup-avatar6.png"),
		load("res://assets/popup-avatar7.png"),
		load("res://assets/popup-avatar3.png"),
		load("res://assets/popup-avatar4.png"),
		load("res://assets/popup-avatar5.png"),
		load("res://assets/popup-avatar6.png"),
		load("res://assets/popup-avatar7.png"),
		load("res://assets/popup-avatar3.png"),
		load("res://assets/popup-avatar4.png"),
		load("res://assets/popup-avatar5.png"),
		load("res://assets/popup-avatar6.png"),
		load("res://assets/popup-avatar7.png"),
		load("res://assets/popup-avatar3.png"),
		load("res://assets/popup-avatar4.png"),
		load("res://assets/popup-avatar5.png"),
		load("res://assets/popup-avatar6.png"),
		load("res://assets/popup-avatar7.png"),
	]
	
	# Conectar señales correctamente
	image_timer.connect("timeout", Callable(self, "_on_ImageTimer_timeout"))
	cycle_timer.connect("timeout", Callable(self, "_on_CycleTimer_timeout"))
	
	# Establecer el Z-index del label mayor al del sprite
	label.z_index = 1
	sprite.z_index = 0

	# Empezar el ciclo
	cycle_timer.start()

func _on_ImageTimer_timeout():
	# Esconder imagen y texto
	sprite.visible = false
	label.visible = false

func _on_CycleTimer_timeout():
	# Mostrar la imagen y el texto en orden
	sprite.texture = images[current_index]
	label.text = texts[current_index]
	
	sprite.visible = true
	label.visible = true
	
	# Incrementar el índice, y reiniciarlo si se llegó al final de la lista
	current_index += 1
	if current_index >= images.size():
		current_index = 0  # Reinicia el índice para repetir los mensajes
	
	# Empezar el ImageTimer
	image_timer.start()
