extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	$Label.text = "alguna logica se hizo"
	pass # Replace with function body.

#func _on_bebida_button_pressed():
	#process_resource_usage("Bebida", 10) 
#
#func _on_comida_button_pressed():
	#process_resource_usage("Comida", 10)
#
#func _on_juegos_button_pressed():
	#process_resource_usage("Juegos", 10)
#
#func _on_musica_button_pressed():
	#process_resource_usage("Música", 10)
