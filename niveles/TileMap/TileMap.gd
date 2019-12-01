extends TileMap

enum CellType {PISO,PARED,NOINFLAMABLE,MARCA,COMBUSTIBLE,FUEGO}

onready var fuego = preload("res://FireFighters/fire-particles/Particles2D.tscn")

var world
var cantFuego:int

func _ready():
	global.connect("apagarF", self, "apagarFuego")
	cantFuegos()

func cantFuegos():
	for cell in get_used_cells():
		var cellType = get_cellv(cell)
		contarFuego(cellType)

func contarFuego(cellType):
	match cellType:
		CellType.FUEGO: cantFuego += 1
		
func marcarExpancion():
	# me da todas las celdas para recorrer
	for cell in get_used_cells():  
		var cellNextType = get_cellv(cell)
		dejarMarca(cell, cellNextType)
		
func dejarMarca(cell, cellNextType):
	match cellNextType:
		CellType.FUEGO: marcar(cell)
		#CellType.COMBUSTIBLE: marcarSICombustible(cell)

# deja una marcar si las celdas vecinas
# son inflamable o combustibles
func marcar(cell):
	marcarSiInflamable(cell)
	marcarSICombustible(cell)

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
		CellType.PISO: set_cellv(cell,CellType.MARCA)   

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
	newFuego.global_position = map_to_world(cell)
	set_cellv(cell,CellType.FUEGO)
	cantFuego +=1
	add_child(newFuego)
	
func _on_Timer_timeout():
	marcarExpancion()
	expandirFuego()
	
func apagarFuego(posFuego):
	var cell = world_to_map(posFuego)
	set_cellv(cell,CellType.PISO)
	cantFuego -= 1
	if(cantFuego == 0):
		world.gano()