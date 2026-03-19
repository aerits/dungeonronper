extends Control

var chat_node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_node_3d_collide_with(item: String) -> void:
	if item == "hajime":
		$HBoxContainer/SubViewportContainer/SubViewport/Node3D.process_mode = Node.PROCESS_MODE_DISABLED
		print("found hajime")
		var scene: PackedScene = load("res://chat.tscn")
		var n: Node = scene.instantiate()
		add_child(n)
		n.close_window.connect(_on_chat_close)
		chat_node = n
		
func _on_chat_close():
	$HBoxContainer/SubViewportContainer/SubViewport/Node3D.process_mode = Node.PROCESS_MODE_INHERIT
	remove_child(chat_node)
	chat_node = null
