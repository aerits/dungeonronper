extends Control

signal send_chat(x: Array)

var chat_node = null
var debug_hidden = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_debug_tools"):
		if debug_hidden:
			$FoldableContainer.show()
			debug_hidden = false
		else:
			debug_hidden = true
			$FoldableContainer.hide()

func _on_node_3d_send_chat(x: Array) -> void:
	emit_signal("send_chat",x)


func _on_node_3d_log_text(s: String, clr: bool) -> void:
	if clr != null and clr == true:
		$VBoxContainer/ColorRect2/RichTextLabel.clear()
	$VBoxContainer/ColorRect2/RichTextLabel.append_text(
		"[font_size='10']" +
		Time.get_time_string_from_system() + 
		"[/font_size]" +
		" " + s
				.replace("Hopes Peak Academy", "[color=blue]Hopes Peak Academy[/color]")
				.replace("hope", "[color=blue]hope[/color]")
				.replace("Hope", "[color=blue]Hope[/color]")
				.replace("despair", "[color=red]despair[/color]")
				.replace("Despair", "[color=red]Despair[/color]")
		  + "\n")


func _on_node_3d_switch_map(scene: PackedScene) -> void:
	var n = scene.instantiate()
	n.connect("send_chat", _on_node_3d_send_chat)
	n.connect("log_text", _on_node_3d_log_text)
	n.connect("switch_map", _on_node_3d_switch_map)
	$VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport.add_child(n)
	$VBoxContainer/HBoxContainer/SubViewportContainer/SubViewport.get_child(0).queue_free()


func _on_line_edit_text_submitted(new_text: String) -> void:
	var scene = load("res://scenes/maps/" + new_text + ".tscn")
	if scene != null:
		_on_node_3d_switch_map(scene)
