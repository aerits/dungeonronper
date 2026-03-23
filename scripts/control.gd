extends Control

signal send_chat(x: Array)
signal player_moved(pos: Vector3i, surround: Array[String])
signal switch_map(scene: PackedScene)
signal start_battle(n: Node)

var chat_node = null
var debug_hidden = true
var current_map: String = "res://scenes/maps/start.tscn"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_node_3d_switch_map(load(current_map))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("toggle_debug_tools"):
		#if debug_hidden:
			#$FoldableContainer.show()
			#debug_hidden = false
		#else:
			#debug_hidden = true
			#$FoldableContainer.hide()
	if Input.is_action_just_pressed("toggle_debug_tools"):
		self._on_node_3d_battle()

func _on_node_3d_send_chat(x: Array) -> void:
	emit_signal("send_chat",x)


func _on_node_3d_log_text(s: String, clr: bool) -> void:
	if clr != null and clr == true:
		$VBoxContainer/ColorRect2/RichTextLabel.clear()
	$VBoxContainer/ColorRect2/RichTextLabel.append_text(
		#"[font_size='5']" +
		#Time.get_time_string_from_system() + 
		#"[/font_size]" +
		" [font_size='10']" + s
				.replace("Hopes Peak Academy", "[color=blue]Hopes Peak Academy[/color]")
				.replace("hope", "[color=blue]hope[/color]")
				.replace("Hope", "[color=blue]Hope[/color]")
				.replace("despair", "[color=red]despair[/color]")
				.replace("Despair", "[color=red]Despair[/color]")
		  + "[/font_size]\n")


func _on_node_3d_switch_map(scene: PackedScene) -> void:
	emit_signal("switch_map", scene)
	var n = scene.instantiate()
	print("map is " + scene.resource_path)
	current_map = scene.resource_path
	n.connect("send_chat", _on_node_3d_send_chat)
	n.connect("log_text", _on_node_3d_log_text)
	n.connect("switch_map", _on_node_3d_switch_map)
	n.connect("player_moved", _on_node_3d_player_moved)
	var children = $VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport.get_child_count()
	if children != 0:
		var n2 = $VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport.get_child(0)
		n2.queue_free()
	$VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport.add_child(n)

func _on_line_edit_text_submitted(new_text: String) -> void:
	var scene = load("res://scenes/maps/" + new_text + ".tscn")
	if scene != null:
		_on_node_3d_switch_map(scene)


func _on_node_3d_player_moved(pos: Vector3i, surround: Array[String]) -> void:
	emit_signal("player_moved", pos, surround)
	
func _on_node_3d_battle():
	var s: PackedScene = load("res://scenes/battle.tscn")
	var n = s.instantiate()
	connect("start_battle", n._on_start_battle)
	get_parent().add_child(n)
	
	get_parent().remove_child(self)
	emit_signal("start_battle", self)
	
