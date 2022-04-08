# The Storage class is a collection of Cells which contain Item data. It's used to manage states of items between multiple environments.
# 
# The class finds most use in player inventories, but it is also used to determine the drops of mobs and props, as well as contents of specific chests. 
extends Node
class_name Storage, "res://svg/storage.svg"

# A Table is an integer only 2D space (like [Vector2D]) that's optimized for human readability.
class Table:
	var row: int
	var column: int

	func area():
		return row * column
	
	func _init(_row: int, _column: int):
		row = _row
		column = _column

# A cell is a positioned and quantifiable Item reference, specific to Storages.
class Cell extends Item:
	var item : Item
	var quantity : int = 1
	var position : Table

var cells : Array[Cell]
var table : Table

func remove_cell(_cell: Cell):
	# Erase this Cell out of the Storage
	pass

func add_cell(item):
	if !(item is Cell):
		var added_successfully : bool = add_to_existing_cell(item)
		if (!added_successfully):
			item = generate_cell(item)
			if item is null: return
	cells.append(item)

func add_to_existing_cell(item : Item):
	var matching_cells : Array[Cell] = cells.filter(has_id(item.ID))
	if matching_cells.size() > 0: 
		matching_cells.sort_custom(sort_by_quantity)
		matching_cells[0].quantity += 1
		return true
	return false

func has_id(_id : int):
	pass

func sort_by_quantity():
	pass

# A free position is found: convert the Item into a Cell with the free position.
func generate_cell(item: Item):
	var cell = Cell.new
	for row in range(table.row + 1):
		for column in range(table.column + 1):
			if get_cell_by_position(Table.new(row, column)) == null:
				cell.position = Table.new(row, column)
				cell.item = item
				return cell
	return null

func find_free_position():
	return Table.new

func get_cell_by_position(_space: Table):
	return Cell.new

# Should be on the player base, regardless of the direction of the transaction.
# The player is the one putting the items in, and pulling them out, so there is no activity on the part of the crate/enemy they're looting.
func transfer(old_storage: Storage, new_storage: Storage, cell: Cell, _new_space: Table):
	if new_storage.get_cell_by_position(_new_space): return
	
	old_storage.remove_cell(cell)
	cell.position = _new_space
	new_storage.add_cell(cell)

func pick(storage: Storage, space: Table):
	if storage.get_cell_by_position(space): 
		return storage.get_cell_by_position(space)
	return