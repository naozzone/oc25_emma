extends Node3D

var x = 2  # crée une variable, entrée du neurone
var target = 10 # valeur qu'on veut obtenir

@onready var slider = $CanvasLayer/Control/WeightSlider # va chercher le noeud et le stock dans la variable Slider ?
@onready var result_label = $CanvasLayer/Control/ResultLabel # va chercher le Label qui affiche le résultat
@onready var connection = $Connection1 # va chercher le cylindre qui représente la connexion

func _process(delta): # appelée à chaque frame ?

	var w = slider.value # récupère la valeur du slider -> devient le poids w ?

	var y = w * x # calcul le neurone

	result_label.text = "Résultat : " + str(y) # change le texte du Label, le str cahnge le nb en texte

	# Epaisseur de la connexion = poids
	connection.scale.y = abs(w) # change la taille du cylindre, abs = valeur absolue -> négatif casserait mesh

	# Si bonne réponse
	if abs(y - target) < 0.2: # vérifie victoire, < 0.2 car les sliders ne tombent pas toujours exactement sur la bonne valeur 
		result_label.text = "Neurone entraîné !"
