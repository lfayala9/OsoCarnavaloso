extends Node2D

var pin_scene = preload("res://assets/pop_up.png")  # Asegúrate de que el camino sea correcto
var timer
var pin_positions = [Vector2(100, 150), Vector2(200, 250), Vector2(300, 350)]  # Lista de posiciones donde aparecerán los pines

func _ready():
	timer = $Timer
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	var pin_instance = pin_scene.instance()
	var position_index = randi() % pin_positions.size()
	pin_instance.position = pin_positions[position_index]
	add_child(pin_instance)
