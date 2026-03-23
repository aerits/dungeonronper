extends Node3D

var plays: int = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		end_battle()

func _on_start_battle(n: Node):
	$SubViewport.add_child(n)
	$SubViewport.process_mode = Node.PROCESS_MODE_DISABLED
	$AnimationPlayer.play("intro_battle")

func end_battle():
	$AnimationPlayer.play_backwards("intro_battle")

func exit():
	var sv: SubViewport = $SubViewport
	sv.process_mode = Node.PROCESS_MODE_INHERIT
	var base_scene: Node = sv.get_child(0)
	sv.remove_child(base_scene)
	get_parent().add_child(base_scene)
	self.queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	plays += 1
	if plays == 2:
		exit()
