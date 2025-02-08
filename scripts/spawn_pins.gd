extends Node2D  

<<<<<<< HEAD:scenes/spawn_pins.gd
var pin_texture = preload("res://assets/pop_up.png")
#var pin_positions = [Vector2(250, 200), Vector2(300, 250), Vector2(500, 100)]  
=======
var pin_positions = [Vector2(250, 200), Vector2(300, 250), Vector2(500, 100)]  # Lista de posiciones
>>>>>>> main:scripts/spawn_pins.gd
var current_index = 0
var pin_positions = [
	Vector2(250, 200),
	Vector2(300, 250),
	Vector2(400, 150),
	Vector2(350, 170),
	Vector2(620, 210),
	Vector2(350, 150),
	Vector2(500, 250),
	Vector2(200, 350),
	Vector2(450, 300),
	Vector2(300, 150),
	Vector2(650, 100),
	Vector2(550, 150),
	Vector2(550, 300),
	Vector2(520, 120),
	Vector2(310, 150),
	Vector2(450, 250),
	Vector2(650, 150),
	Vector2(300, 250)
]

var resource_types = ["Bebida", "Comida", "Juegos", "Música"]

@onready var timer = $Timer_pop  

#
var min_wait_time: float = 2

func _ready():
	randomize()
	timer.wait_time = 1.0  
	timer.start()
	timer.timeout.connect(_spawn_pin)  

func _spawn_pin():
<<<<<<< HEAD:scenes/spawn_pins.gd
	# Select a random position from the array.
	var pos_index = randi() % pin_positions.size()
	var spawn_position = pin_positions[pos_index]
	
	# Create the pin.
	var pin = TextureButton.new()
	pin.texture_normal = pin_texture
	pin.position = spawn_position
	pin.scale = Vector2(0.15, 0.15)  # Adjust the scale as needed.
	
	# Choose a random expected resource for this pin.
	var accepted_resource = resource_types[randi() % resource_types.size()]
	pin.set_meta("accepted_resource", accepted_resource)
	
	# Connect the "pressed" signal, passing the pin itself as an argument.
	pin.connect("pressed", Callable(self, "_on_pin_pressed").bind(pin))
	
	# Add the pin to the scene.
	add_child(pin)
	
	# Gradually decrease the timer wait time so pins spawn more frequently,
	# but never go below the minimum value.
	timer.wait_time = max(timer.wait_time - 0.005, min_wait_time)

func _on_pin_pressed(pin):
	print("Pin pulsado: ", pin)
	var resource_manager = get_node("Control")
	resource_manager.set_active_pin(pin)
	#_spawn_pin()
=======
	if current_index < pin_positions.size():
		var pin = $pin;
		pin.position = pin_positions[0]
		pin.pressed.connect(_on_pin_pressed.bind(current_index))  # Conectar evento clic
		
		#add_child(pin)
		current_index += 1
	else:
		timer.stop()
>>>>>>> main:scripts/spawn_pins.gd

#FUNCTIONAL SPAWN_PIN
#func _spawn_pin():
	#if current_index < pin_positions.size():
		#var pin = TextureButton.new()
		#pin.texture_normal = pin_texture
		#pin.position = pin_positions[current_index]
		#pin.scale = Vector2(0.15, 0.15)
		#
		#var accepted_resource = resource_types[randi() % resource_types.size()]
		#pin.set_meta("accepted_resource", accepted_resource)
		  #
		#pin.connect("pressed", Callable(self, "_on_pin_pressed").bind(pin))
		#
		#add_child(pin)
		#current_index += 1
	#else:
		#timer.stop()
