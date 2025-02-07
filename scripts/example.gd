extends Control

var bebida_value: int = 100
var comida_value: int = 100
var juegos_value: int = 100  

@onready var bebida_label = $Bebida_Label
@onready var comida_label = $Comida_Label
@onready var juegos_label = $Juegos_Label 

func _ready():
	update_label()  

func use_resource(resource: String, amount: int):
	match resource:
		"Bebida":
			bebida_value = max(bebida_value - amount, 0)
		"Comida":
			comida_value = max(comida_value - amount, 0)
		"Juegos":
			juegos_value = max(juegos_value - amount, 0)
	update_label()

func update_label():
	bebida_label.text = "Bebida: " + str(bebida_value) + "%"
	comida_label.text = "Comida: " + str(comida_value) + "%"
	juegos_label.text = "Juegos: " + str(juegos_value) + "%"


func _on_bebida_button_pressed():
	use_resource("Bebida", 10) 

func _on_comida_button_pressed():
	use_resource("Comida", 10)


func _on_juegos_button_pressed():
	use_resource("Juegos", 10)
