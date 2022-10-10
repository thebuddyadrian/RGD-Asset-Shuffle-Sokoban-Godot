extends Node2D

onready var level = get_parent()


#Gets the box's position in grid coordinates
func get_grid_position() -> Vector2:
	return level.tile_map.world_to_map(global_position)


func can_move(offset: Vector2) -> bool:
	var new_position:Vector2 = get_grid_position() + offset
	
	#If there's a wall, then the box can't move there
	if level.check_for_wall(get_grid_position() + offset):
		return false
	
	#If there's another box, the box can't move there
	if level.check_for_box(get_grid_position() + offset):
		return false
	
	#If none of those were true, the box can move
	return true


func move(offset: Vector2):
	global_position = level.tile_map.map_to_world(get_grid_position() + offset)
