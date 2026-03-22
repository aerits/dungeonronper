@abstract
class_name Map
extends Node

signal send_chat(x: Array)
signal log_text(s: String, clr: bool)
signal switch_map(scene: PackedScene)
signal player_moved(pos: Vector3i, surround: Array[String])

var chat_node: Node = null
var finish_chat: Callable

func start_chat(x: Array, callback: Callable=func (): pass) -> void:
	$CharacterBody3D.process_mode = Node.PROCESS_MODE_DISABLED
	var scene: PackedScene = preload("res://scenes/chat.tscn")
	var n: Node = scene.instantiate()
	n.close_window.connect(_on_chat_close)
	n.log_text.connect(_on_chat_log_text)
	get_tree().root.get_child(0).get_child(1).add_sibling(n)
	emit_signal("send_chat", x)
	chat_node = n
	finish_chat = callback

func log_(s: String, clr: bool) -> void:
	emit_signal("log_text", s, clr)

func _on_character_body_3d_collide_with(item: String, pos: Vector3i) -> void:
	pass

func _on_character_body_3d_player_moved(pos: Vector3i, surround: Array[String]) -> void:
	emit_signal("player_moved", pos, surround)

func _on_chat_log_text(s: String, clr: bool) -> void:
	log_(s, clr)
	
func _on_chat_close() -> void:
	$CharacterBody3D.process_mode = Node.PROCESS_MODE_INHERIT
	chat_node.queue_free()
	chat_node = null
	finish_chat.call()
