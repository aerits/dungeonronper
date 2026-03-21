extends Map

func _ready() -> void:
	log_("Location: Hopes Peak Academy", false)
	log_("Time: 30 seconds have passed", false)

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
