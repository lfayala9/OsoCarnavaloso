extends Control

var drink_value: int = 100
var food_value: int = 100
var games_value: int = 100  
var music_value: int = 100  

var active_pin = null

@onready var drink_label = $Bebida_Label
@onready var food_label = $Comida_Label
@onready var games_label = $Juegos_Label 
@onready var music_label = $Musica_Label 

func _ready():
	update_label()
	# Instead of using a file path, get the actual pin node from the scene.
	# Adjust the node path according to your scene tree.
	var pin_node = get_node("../pin")
	if pin_node:
		# Add an extra connection so that when the pin is pressed,
		# our override function is called and active_pin is set.
		if not pin_node.is_connected("pressed", Callable(self, "_on_pin_pressed_override")):
			pin_node.connect("pressed", Callable(self, "_on_pin_pressed_override"))
	else:
		print("⚠️ ERROR: No se encontró el nodo 'pin' en SpawnPins.")

func set_active_pin(pin):
	active_pin = pin
	print("Pin activo: ", pin)
	
	var accepted_resource = ["Bebida", "Comida", "Juegos", "Música"].pick_random()
	pin.set_meta("accepted_resource", accepted_resource)

	# Now, retrieve and print the assigned resource
	var expected = pin.get_meta("accepted_resource")
	print("El pin espera: ", expected)

# This function will be called when the pin is pressed.
func _on_pin_pressed_override():
	# Retrieve the pin node. In this setup, there's only one pin node.
	var pin = get_node("../pin")
	if pin:
		set_active_pin(pin)
	else:
		print("⚠️ ERROR: No se pudo encontrar el nodo 'pin' para activarlo.")

func use_resource(resource: String, amount: int) -> bool:
	match resource:
		"Bebida":
			if drink_value >= amount:
				drink_value -= amount
				update_label()
				return true
			else:
				print("❌ ERROR: No tienes suficiente Bebida!")
				return false
		"Comida":
			if food_value >= amount:
				food_value -= amount
				update_label()
				return true
			else:
				print("❌ ERROR: No tienes suficiente Comida!")
				return false
		"Juegos":
			if games_value >= amount:
				games_value -= amount
				update_label()
				return true
			else:
				print("❌ ERROR: No tienes suficiente Juegos!")
				return false
		"Música":
			if music_value >= amount:
				music_value -= amount
				update_label()
				return true
			else:
				print("❌ ERROR: No tienes suficiente Música!")
				return false
	return false

func process_resource_usage(resource: String, amount: int):
	if active_pin != null:
		if use_resource(resource, amount):
			if active_pin.has_meta("accepted_resource"):
				var expected_resource = active_pin.get_meta("accepted_resource")
				if resource == expected_resource:
					print("✅ Correcto! Usaste " + resource + " en el pin.")
				else:
					print("⚠️ Incorrecto! Este pin necesitaba " + expected_resource + ", pero usaste " + resource + ".")
			else:
				print("⚠️ ERROR: El pin seleccionado no tiene un recurso esperado asignado.")
			#active_pin.queue_free()
			active_pin = null
	else:
		print("⚠️ ERROR: No seleccionaste ningún pin!")

func update_label():
	drink_label.text = "Bebida: " + str(drink_value)
	food_label.text = "Comida: " + str(food_value)
	games_label.text = "Juegos: " + str(games_value)
	music_label.text = "Música: " + str(music_value)

func _on_bebida_button_pressed():
	process_resource_usage("Bebida", 10) 

func _on_comida_button_pressed():
	process_resource_usage("Comida", 10)

func _on_juegos_button_pressed():
	process_resource_usage("Juegos", 10)

func _on_musica_button_pressed():
	process_resource_usage("Música", 10)
