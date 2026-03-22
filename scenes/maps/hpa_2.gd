extends Map

func _ready() -> void:
	log_("Location: Hopes Peak Academy", false)
	log_("Time: 30 seconds have passed", false)

func _on_character_body_3d_collide_with(item: String, pos: Vector3i) -> void:
	if item == "tree":
		log_("Inspect: Cool Tree", false)
