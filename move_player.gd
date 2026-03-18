extends CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

var dir = Vector3(0,0,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var prev_pos = self.global_basis
	var mot = Vector3(0,0,0)
	if Input.is_action_just_pressed("forward"):
		mot = dir
	elif Input.is_action_just_pressed("back"):
		mot = -dir
	elif Input.is_action_just_pressed("look_left"):
		self.rotate_y(1.5707963268)
		dir = dir.rotated(Vector3(0,1,0), 1.5707963268)
	elif Input.is_action_just_pressed("look_right"):
		self.rotate_y(-1.5707963268)
		dir = dir.rotated(Vector3(0,1,0), -1.5707963268)
	var coll = self.move_and_collide(mot, true)
	if coll == null or coll.get_collision_count() < 1:
		self.global_translate(mot)
	return
