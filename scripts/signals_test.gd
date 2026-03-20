extends Node3D

signal send_chat(x: Array)
signal log_text(s: String, clr: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("log_text", "Location: Hopes Peak Academy", false)
	emit_signal("log_text", "Time: 1 year after the events of Danganronpa 2", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var chat_node: Node = null

func _on_character_body_3d_collide_with(item: String) -> void:
	if item == "hajime":
		$CharacterBody3D.process_mode = Node.PROCESS_MODE_DISABLED
		print("found hajime")
		
		var scene: PackedScene = preload("res://scenes/chat.tscn")
		var n: Node = scene.instantiate()
		n.close_window.connect(_on_chat_close)
		n.log_text.connect(_on_chat_log_text)
		get_tree().root.add_child(n)
		emit_signal("send_chat", 
			[["hajime",".. the school that we were supposed to have spent 4 years at --"],
			["hajime", "Whoa, you startled me Nagito, you are also revisiting the school today?"],
			["nagito", "... Yeah. There's something off about the basement of the school. You noticed it too, right?"],
			["hajime", "..."],
			["hajime", "what. bb I'm just reminiscing. After I lost my izuru god powers, I'm just an ordinary guy."],
			["*", "*sound of bones shuffling*"],
			["hajime", "*slightly startled* what was that?"],
			["nagito", "That was not a [b]Hopeful[/b] noise. We'd should bring the rest of the alumni to investigate"],
			
			])
		
		chat_node = n

func _on_chat_ready():
	print("ready")

func _on_chat_log_text(s: String, clr: bool):
	emit_signal("log_text", s, clr)

func _on_chat_close():
	$CharacterBody3D.process_mode = Node.PROCESS_MODE_INHERIT
	chat_node.queue_free()
	chat_node = null
