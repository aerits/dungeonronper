extends Map

func _ready() -> void:
	log_("Location: Hopes Peak Academy", false)
	log_("Time: 1 minute has passed", false)

var inspects = ["Thats Hopes Peak Academy, Isn't It?",
				"Hopes Peak Academy",
				"Despair Academy",
				"...",
				"What",
				"Academy",
				"Home",
				"I'm Nagito Komeada",
				"That is hopefully an Academy"]

func _on_character_body_3d_collide_with(item: String, pos: Vector3i) -> void:
	if item == "MeshInstance3D2":
		log_("Inspect: " + inspects.pick_random(), false)
	if item == "hajime":
		start_chat([["hajime", "nagito where are you going?"],
					["hajime", "i thought we were going to investigate"],
					["nagito", "Sorry, I must've gotten sidetracked"],
					["nagito", "[color=green]is this not the way to the academy?[/color]"],
					["hajime", "why are you just hiding in this grove? are you scared of whats inside those doors?"],
					["nagito", "no its nothing"],
					["nagito", "[color=green]My pills Must have worn off[/color]"],
					["nagito", "[color=green]I grabbed some more pills[/color]"]],
					func (): emit_signal("switch_map", load("res://scenes/maps/hpa2.tscn")))
