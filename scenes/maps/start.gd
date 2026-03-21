extends Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	log_("Location: Just Outside Hopes Peak Academy", false)
	log_("Time: half a year after the events of Danganronpa 2", false)

var hajime_moved: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_character_body_3d_collide_with(item: String, pos: Vector3i) -> void:
	print("collided with " + str(pos))
	if item == "tree":
		if !hajime_moved:
			emit_signal("log_text", "Inspect: This tree is hopeful", false)
		else:
			emit_signal("log_text", "Inspect: This tree is hopeless", false)
	if item == "tree_transparent":
		emit_signal("log_text", "Inspect: This tree is filled with despair", false)
	if item == "MeshInstance3D":
		log_("Inspect: MeshInstance3D", false)
	if item == "MeshInstance3D2":
		log_("Inspect: Hopes Peak Academy", false)
		emit_signal("switch_map", load("res://scenes/maps/hpa1.tscn"))
	if pos == Vector3i(-6,0,3) and item == "hajime":
		start_chat(
			[["hajime",".. the school that we were supposed to have spent 4 years at --"],
			["hajime", "Whoa, you startled me Nagito, you are also revisiting the school today?"],
			["nagito", "... Yeah. There's something off about the basement of the school. You noticed it too, right?"],
			["hajime", "..."],
			["hajime", "what. bb I'm just reminiscing. After I lost my izuru god powers, I'm just an ordinary guy."],
			["*", "*sound of bones shuffling*"],
			["hajime", "*slightly startled* what was that?"],
			["nagito", "That was not a [b]Hopeful[/b] noise. We should investigate"],
		], func (): 
			$GridMap.set_cell_item(pos, -1)
			$GridMap.set_cell_item(Vector3i(-6,0,4), 1)
			)
		hajime_moved = true
	if pos == Vector3i(-6,0,4) and item == "hajime":
		start_chat([
			["hajime", "are you going to go in? it might be dangerous"], 
		])
