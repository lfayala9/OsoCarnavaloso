extends Control

var drink_value: int = 100
var food_value: int = 100
var games_value: int = 100  
var music_value: int = 100  

var active_pin = null  # Almacena el pin seleccionado

# Asegúrate de que las referencias a las etiquetas son correctas:
@onready var drink_label = $drinksButton/drinksLabel
@onready var food_label = $foodButton/foodLabel
@onready var games_label =  $gamesButton/gamesLabel
@onready var music_label =  $musicButton/musicLabel


@onready var sprite = $Sprite2D  # Referencia al sprite en la escena
@onready var control_node = $Control  # Referencia al nodo Control
var message_timer : Timer  # Temporizador para el mensaje

func _ready():
	update_label()

# ✅ Se ejecuta cuando se presiona un pin
func _on_node_2d_pin_selected(pin):
	print("⚠️ _on_node_2d_pin_selected llamada con pin: ", pin)
	if pin == null:
		print("⚠️ No se recibió un pin válido.")
		return
	
	# 1. Marcar el pin como seleccionado
	active_pin = pin  # Guardar el pin seleccionado
	print("Pin activo: ", pin)

	# 2. Asignar un recurso esperado al pin
	var accepted_resource = ["Bebida", "Comida", "Juegos", "Música"].pick_random()
	pin.set_meta("accepted_resource", accepted_resource)  # Asignar el recurso esperado al pin
	print("📌 El pin espera: ", accepted_resource)

# ✅ Función para gastar recursos y asignarlos al pin seleccionado
func process_resource_usage(resource: String, amount: int):
	print("Intentando usar recurso: " + resource + " con cantidad: " + str(amount))
	if active_pin != null:
		if use_resource(resource, amount):  # Si el jugador tiene suficientes recursos
			if active_pin.has_meta("accepted_resource"):
				var expected_resource = active_pin.get_meta("accepted_resource")
				#CAMBIO DE IMAGEN
				print("📌 Recurso esperado por el pin: ", expected_resource)
				if resource == expected_resource:
					print("✅ Correcto! Usaste " + resource + " en el pin.")
					#AQUI VA SONIDO CORRECTO
				else:
					print("⚠️ Incorrecto! Este pin necesitaba " + expected_resource + ", pero usaste " + resource + ".")
					#AQUI VA SONIDO INCORRECTO
			else:
				print("⚠️ ERROR: El pin seleccionado no tiene un recurso esperado asignado.")

			# Eliminar el pin después de asignar recurso
			active_pin.queue_free()
			active_pin = null
		else:
			print("❌ No tienes suficiente de este recurso!")
	else:
		print("⚠️ ERROR: No seleccionaste ningún pin!")

# ✅ Función que reduce el recurso si hay suficiente
func use_resource(resource: String, amount: int) -> bool:
	print("Verificando si hay suficiente " + resource + " para gastar.")
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

# ✅ Actualiza los textos de los recursos
func update_label():
	print("Actualizando las etiquetas de los recursos...")
	drink_label.text = "Bebida: " + str(drink_value)
	food_label.text = "Comida: " + str(food_value)
	games_label.text = "Juegos: " + str(games_value)
	music_label.text = "Música: " + str(music_value)

func twistter():
	pass
	

# ✅ Botones para usar recursos

func _on_food_button_button_down():
	print("Presionado el botón Comida")
	process_resource_usage("Comida", 10)

func _on_drinks_button_button_down():
	print("Presionado el botón Bebida")
	process_resource_usage("Bebida", 10)

func _on_games_button_button_down():
	print("Presionado el botón Juegos")
	process_resource_usage("Juegos", 10)

func _on_music_button_button_down():
	print("Presionado el botón Música")
	process_resource_usage("Música", 10)

