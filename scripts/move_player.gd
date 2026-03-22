extends CharacterBody3D

signal collideWith(item: String, pos: Vector3i)
signal player_moved(pos: Vector3i, surround: Array[String])
@export var gridmap: GridMap = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

var dir = Vector3(0,0,1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
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
		if mot.length_squared() > 0:
			send_move()
		self.global_translate(mot)
		if mot.length_squared() > 0:
			send_move()
	else:
		var pos = self.global_position + dir
		var coords = gridmap.local_to_map(pos)
		var itemID = gridmap.get_cell_item(coords)
		emit_signal("collideWith", gridmap.mesh_library.get_item_name(itemID), coords)
	return

func send_move() -> void:
	var coords: Vector3i = gridmap.local_to_map(self.global_position)
	var dirs: Array[Vector3i] = [coords + Vector3i(1,0,0),
	coords + Vector3i(-1,0,0),
	coords + Vector3i(0,0,1),
	coords + Vector3i(0,0,-1)]
	var dirs2 = dirs.map(func (e: Vector3i): return gridmap.get_cell_item(e))
	var dirs3 = dirs2.map(func (e: int): 
		if e == -1:
			return ""
		return gridmap.mesh_library.get_item_name(e))
	var dirs4: Array[String] = []
	for i in dirs3:
		if i is String:
			dirs4.append(i)
	emit_signal("player_moved", coords, dirs4)
	return
