extends Control

signal send_chat(x: Array)

var chat_node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_node_3d_send_chat(x: Array) -> void:
	emit_signal("send_chat",x)


func _on_node_3d_log_text(s: String, clr: bool) -> void:
	if clr != null and clr == true:
		$ColorRect2/RichTextLabel.clear()
	$ColorRect2/RichTextLabel.append_text(
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
