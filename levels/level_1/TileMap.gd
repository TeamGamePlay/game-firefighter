extends TileMap

enum CellType {HUMO,PARED,INFLAMABLE,PISO,COMBUSTIBLE,FUEGO}

onready var fuego = preload("res://FireFighters/fire-particles/Particles2D.tscn")

var world

func _ready():
	#marcarExpancion()
	#expandirFuego()
	#crearFuegos()
	pass
	
func marcarExpancion():
	# me da todas las celdas para recorrer
	for cell in get_used_cells():  
		var cellNextType = get_cellv(cell)
		expandirMarca(cell, cellNextType)
		
func expandirMarca(cell, cellNextType):
	match cellNextType:
		CellType.FUEGO: marcarSiCorresponde(cell)

# deja una marcar si las celdas vecinas
# son inflamable o combustibles
func marcarSiCorresponde(cell):
	var cellNorte = Vector2(cell.x, cell.y - 1)
	var cellSur = Vector2(cell.x, cell.y + 1)
	var cellEste = Vector2(cell.x + 1, cell.y)
	var cellOeste = Vector2(cell.x - 1, cell.y - 1)
	var cellNorEste = Vector2(cell.x + 1, cell.y - 1)
	var cellNorOeste = Vector2(cell.x -1 , cell.y + 1)
	var cellSurEste = Vector2(cell.x + 1, cell.y + 1)
	var cellSurOeste = Vector2(cell.x - 1, cell.y + 1)
	
	var celdasVecinas = [cellNorte, cellSur, cellEste, cellOeste, cellNorEste, cellNorOeste, cellSurEste, cellSurOeste]
	
	for cell in celdasVecinas:
		marcar(cell, get_cellv(cell))
	
func marcar(cell, cellType):
	match cellType:
		CellType.INFLAMABLE: set_cellv(cell,CellType.FUEGO)   
		
func expandirFuego():
	for cell in get_used_cells():  
		var cellNextType = get_cellv(cell)
		agregarFuego(cell, cellNextType)

func agregarFuego(cell, cellType):
	match cellType:
		CellType.FUEGO: crearFuego(cell)
	
func crearFuego(cell):
	var newFuego = fuego.instance()
	#newFuego.position.x = 16 + 32 - cell.x
	#newFuego.position.y = 16 + 32 * cell.y
	
	newFuego.position.x = 655
	newFuego.position.y = 241
	print(cell)
	print(newFuego.position)
	print(get_parent().name)
	get_parent().add_child(newFuego)
	#get_parent().crear(newFuego)
	#world.add_children(newFuego)
	

func _on_Timer_timeout():
	marcarExpancion()
	expandirFuego()
	pass