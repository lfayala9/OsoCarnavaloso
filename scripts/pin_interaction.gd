extends "res://scripts/spawn_pins.gd"

var resource_types = ["Bebida", "Comida", "Juegos", "Música"]
var min_wait_time: float = 0.5  # Minimum spawn delay

func _ready():
	randomize()
	timer.wait_time = 1.5  # Start at 1.5s and decrease over time
	timer.timeout.connect(_spawn_pin)  # Override spawn function

func _spawn_pin():
	# Select a random position
	var spawn_position = pin_positions[randi() % pin_positions.size()]
	
	# Create a new pin
	var pin = TextureButton.new()
	pin.position = spawn_position
	pin.scale = Vector2(0.15, 0.15)  

	# Assign a random expected resource
	var accepted_resource = resource_types[randi() % resource_types.size()]
	pin.set_meta("accepted_resource", accepted_resource)

	# Connect pin press event
	pin.pressed.connect(_on_pin_pressed.bind(pin))
	
	# Add pin to scene
	add_child(pin)

	# Reduce spawn interval gradually (up to a limit)
	timer.wait_time = max(timer.wait_time - 0.05, min_wait_time)

func _on_pin_pressed(pin):
	print("Pin pressed. Expected Resource: ", pin.get_meta("accepted_resource"))
	var resource_manager = get_node("Control")  # Adjust path if needed
	resource_manager.set_active_pin(pin)
