extends Node2D

onready var wall_detector = $WallDetector
onready var tile_map = $TileMap


#Checks if there's a wall at the corresponding X/Y coordinates on the Grid (TileMap)
func check_for_wall(grid_position: Vector2):
	#Gets the tile number at the specified coordinates
	var tile_at = tile_map.get_cellv(grid_position)
		
	#If the tile number is 1 (Brick), return true, otherwise return false
	return (tile_at == 1)


#Checks if there's a box at the corresponding X/Y coordinates on the Grid (TileMap)
#If there is a box there, return it
#Otherwise it will return null
func check_for_box(grid_position: Vector2):
	#Goes through all the boxes and checks if there's one that's in the requested posiiton
	for node in get_tree().get_nodes_in_group("box"):
		if node.get_grid_position() == grid_position:
			return node
	
	return null
