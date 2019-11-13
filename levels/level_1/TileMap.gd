extends TileMap

enum CellType {MARCA,PARED,INFLAMABLE,PISO,COMBUSTIBLE,FUEGO}

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
		CellType.FUEGO: marcarSiInflamable(cell)
		CellType.COMBUSTIBLE: marcarSICombustible(cell)

# deja una marcar si las celdas vecinas
# son inflamable o combustibles
func marcarSiInflamable(cell):
	var cellNorte = Vector2(cell.x, cell.y - 1)
	var cellSur = Vector2(cell.x, cell.y + 1)
	var cellEste = Vector2(cell.x + 1, cell.y)
	var cellOeste = Vector2(cell.x - 1, cell.y)
	var cellNorEste = Vector2(cell.x + 1, cell.y - 1)
	var cellNorOeste = Vector2(cell.x -1 , cell.y - 1)
	var cellSurEste = Vector2(cell.x + 1, cell.y + 1)
	var cellSurOeste = Vector2(cell.x - 1, cell.y + 1)
	
	var celdasVecinas = [cellNorte, cellSur, cellEste, cellOeste, cellNorEste, cellNorOeste, cellSurEste, cellSurOeste]
	
	for cell in celdasVecinas:
		marcarInflamable(cell, get_cellv(cell))
	
func marcarInflamable(cell, cellType):
	match cellType:
		CellType.INFLAMABLE: set_cellv(cell,CellType.MARCA)   

func marcarSICombustible(cell):
	var cellNorte = Vector2(cell.x, cell.y - 1)
	var cellSur = Vector2(cell.x, cell.y + 1)
	var cellEste = Vector2(cell.x + 1, cell.y)
	var cellOeste = Vector2(cell.x - 1, cell.y)
	var cellNorEste = Vector2(cell.x + 1, cell.y - 1)
	var cellNorOeste = Vector2(cell.x -1 , cell.y - 1)
	var cellSurEste = Vector2(cell.x + 1, cell.y + 1)
	var cellSurOeste = Vector2(cell.x - 1, cell.y + 1)
	
	var celdasVecinas = [cellNorte, cellSur, cellEste, cellOeste, cellNorEste, cellNorOeste, cellSurEste, cellSurOeste]
	
	for cell in celdasVecinas:
		marcarCombustible(cell, get_cellv(cell)) 

func marcarCombustible(cell, cellType):
	match cellType:
		CellType.COMBUSTIBLE: marcarC(cell,cellType)

func marcarC(cell, cellType):
	set_cellv(cell,CellType.MARCA)
	marcarSICombustible(cell)   

func expandirFuego():
	for cell in get_used_cells():  
		var cellNextType = get_cellv(cell)
		agregarFuego(cell, cellNextType)

func agregarFuego(cell, cellType):
	match cellType:
		CellType.MARCA: crearFuego(cell)
	
func crearFuego(cell):
	var newFuego = fuego.instance()
	newFuego.position.x = 16 + 32 - cell.x
	newFuego.position.y = 16 + 32 * cell.y
	
	#newFuego.position.x = 655
	#newFuego.position.y = 241
	print(cell)
	print(newFuego.position)
	print(get_parent().name)
	set_cellv(cell,CellType.FUEGO)
	#get_parent().add_child(newFuego)
	#get_parent().crear(newFuego)
	#world.add_children(newFuego)
	

func _on_Timer_timeout():
	marcarExpancion()
	expandirFuego()
	pass