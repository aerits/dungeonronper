extends Node2D

class StoredMap:
	var pattern: TileMapPattern
	var start: Vector2i

var minimaps: Dictionary[String, StoredMap] = {"": null}
var current_map: String = ""

func _on_control_player_moved(pos: Vector3i, surround: Array[String]) -> void:
	var pos2 = Vector2i(pos.x, pos.z)
	var dirs = surround.map(func (e: String):
		if e.length() > 0:
			return 1
		return 0).map(func (e: int):
		return str(e)).reduce(func (acc: String, e: String):
		return acc + e)
	var id: Vector2i = Vector2i(0,0)
	match dirs: # right left down up
		"0001":
			id = Vector2i(1,0)
		"0010":
			id = Vector2i(2,0)
		"0011":
			id = Vector2i(1,1)
		"0100":
			id = Vector2i(3,0)
		"0101":
			id = Vector2i(3,1)
		"0110":
			id = Vector2i(1,2)
		"0111":
			id = Vector2i(2,3)
		"1000":
			id = Vector2i(0,1)
		"1001":
			id = Vector2i(0,2)
		"1010":
			id = Vector2i(2,2)
		"1011":
			id = Vector2i(1,3)
		"1100":
			id = Vector2i(2,1)
		"1101":
			id = Vector2i(0,3)
		"1110":
			id = Vector2i(3,2)
		"1111":
			id = Vector2i(3,3)
	$TileMapLayer.set_cell(pos2, 1, id)
	var dot_pos = $TileMapLayer.map_to_local(pos2)
	$TileMapLayer/map_dot.position = dot_pos
	
	
	# godot tilemaps are invisible in web
	# so we need to add nodes to draw the tilemap
	add_tile($TileMapLayer/map_dot, id)
	
func add_tile(map_dot: Sprite2D, id: Vector2i, offset: Vector2 = Vector2.ZERO):
	var s: Sprite2D = map_dot.duplicate()
	s.add_to_group("tilemap")
	var x = 0
	var y = 0
	match id.x:
		0: x=1
		1: x=5
		2: x=9
		3: x=13
	match id.y:
		0: y=1
		1: y=5
		2: y=9
		3: y=13
	s.region_rect.position = Vector2(x, y)
	$TileMapLayer/Node.add_sibling(s)
	s.position = offset + s.position
	print(s.position)
	
func _on_control_switch_map(scene: PackedScene) -> void:
	print("switchmap recieved")
	var old_map: String = current_map
	current_map = scene.resource_path
	
	var tilemap = $TileMapLayer
	var start = tilemap.get_used_rect().position
	var used_cells = tilemap.get_used_cells()
	var old_pattern: TileMapPattern = tilemap.get_pattern(used_cells)
	var map = StoredMap.new()
	map.pattern = old_pattern
	map.start = start
	minimaps[old_map] = map
	tilemap.clear()
	
	for child in tilemap.get_children():
		if child.is_in_group("tilemap"):
			child.queue_free()
	
	var map_dot = $TileMapLayer/map_dot
	map_dot.position = Vector2(1, 1)
	
	if minimaps.has(current_map):
		var new_map: StoredMap = minimaps[current_map]
		#print(new_pattern.pattern.get_used_cells())
		tilemap.set_pattern(new_map.start, new_map.pattern)
		for tile: Vector2i in tilemap.get_used_cells():
			
			var id = tilemap.get_cell_atlas_coords(tile)
			add_tile($TileMapLayer/map_dot, id, Vector2(tile.x*3, tile.y*3))
	
	map_dot.position = Vector2(1, 0)
	#tilemap.set_cell(Vector2i.ZERO, 0, Vector2i.ZERO)
	
