extends Control

var drink_value: int = 100
var food_value: int = 100
var games_value: int = 100  
var music_value: int = 100  

var active_pin = null

@onready var drink_label = $Drink_Label
@onready var food_label = $Food_Label
@onready var games_label = $Games_Label 
@onready var music_label = $Music_Label 

func _ready():
	update_label()  

func set_active_pin(pin):
	active_pin = pin
	print("Pin activo: ", pin)
	var expected = pin.get_meta("accepted_resource")
	print("El pin espera: ", expected)

func use_resource(resource: String, amount: int) -> bool:
	# Check if the resource is enough before subtracting
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
	return false  # Default return (shouldn't reach here)

func process_resource_usage(resource: String, amount: int):
	if active_pin != null:
		# Check if we can actually use the resource
		if use_resource(resource, amount):
			# Get the expected resource from the pin's metadata
			var expected_resource = active_pin.get_meta("accepted_resource", "")

			if resource == expected_resource:
				print("✅ Correcto! Usaste " + resource + " en el pin.")
			else:
				print("⚠️ Incorrecto! Este pin necesita " + expected_resource + ", pero usaste " + resource + ".")

			active_pin.queue_free()
			active_pin = null
	else:
		print("⚠️ ERROR: No seleccionaste ningún pin!")

func update_label():
	drink_label.text = "Bebida: " + str(drink_value) + "%"
	food_label.text = "Comida: " + str(food_value) + "%"
	games_label.text = "Juegos: " + str(games_value) + "%"
	music_label.text = "Música: " + str(music_value) + "%"

func _on_bebida_button_pressed():
	process_resource_usage("Bebida", 10) 

func _on_comida_button_pressed():
	process_resource_usage("Comida", 10)

func _on_juegos_button_pressed():
	process_resource_usage("Juegos", 10)

func _on_music_button_pressed():
	process_resource_usage("Música", 10)

#func use_resource(resource: String, amount: int):
	#match resource:
		#"Bebida":
			#drink_value = max(drink_value - amount, 0)
		#"Comida":
			#food_value = max(food_value - amount, 0)
		#"Juegos":
			#games_value = max(games_value - amount, 0)
	#update_label()
#
#func process_resource_usage(resource: String, amount: int):
	#if active_pin != null:
		#var expected_resource = active_pin.get_meta("accepted_resource")
		#if expected_resource == resource:
			#print("¡Recurso correcto! Se usó: ", resource)
		#else:
			#print("Recurso incorrecto, se usó: ", resource)
		#use_resource(resource, amount)
		#active_pin.queue_free()
		#active_pin = null
	#else:
		#print("No seleccionó ningún pin.")

