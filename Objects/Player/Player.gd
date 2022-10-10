extends Node2D

#Gets the level the player is currently inside
onready var level = get_parent()


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		move_if_not_blocked(Vector2.LEFT)
	elif Input.is_action_just_pressed("move_right"):
		move_if_not_blocked(Vector2.RIGHT)
	elif Input.is_action_just_pressed("move_up"):
		move_if_not_blocked(Vector2.UP)
	elif Input.is_action_just_pressed("move_down"):
		move_if_not_blocked(Vector2.DOWN)


#Gets the players position in grid coordinates
func get_grid_position() -> Vector2:
	return level.tile_map.world_to_map(global_position)


func snap_to_grid():
	global_position = level.tile_map.map_to_world(get_grid_position())


#Will check the tile relative to the current position based on the offset
#And then move to the tile if there's no wall or immovable box
func move_if_not_blocked(offset: Vector2) -> bool:
	var new_position:Vector2 = get_grid_position() + offset
	
	#Don't move if there's a wall
	if level.check_for_wall(get_grid_position() + offset):
		return false
	
	var box = level.check_for_box(new_position)
	
	#If there's a box and you can move it, move it
	#If it's immovable, don't move
	if box:
		if box.can_move(offset):
			box.move(offset)
		else:
			return false
	
	global_position = level.tile_map.map_to_world(new_position)
	return true
