extends TileMap
onready var t = $Timer
enum CellType {PISO,PARED,NOINFLAMABLE,MARCA,COMBUSTIBLE,FUEGO}

onready var fuego = preload("res://FireFighters/fire-particles/Fuego.tscn")

var world
var cantFuego:int

var celdasMarcadas:Array = []
var celdasFuego:Array = []
var fuegos:Array = []

var cantCel:int = 0

func _ready():
	global.connect("apagarF", self, "apagarFuego")
	cantFuegos()
	cantCelda()
	crearFuegos()
	
func crearFuegos():
	for c in 550:
		crearFuego()

func crearFuego():
	var newFuego = fuego.instance()
	newFuego.global_position = map_to_world(Vector2(-880,0))
	fuegos.push_front(newFuego)
	add_child(newFuego)
	
func cantCelda():
	for cell in get_used_cells():
		var cellType = get_cellv(cell)
		contarCelda(cellType)
		
func contarCelda(cellT):
	match cellT:
		CellType.PISO : cantCel +=1
		  
func cantFuegos():
	for cell in get_used_cells():
		var cellType = get_cellv(cell)
		contarFuego(cellType,cell)

func contarFuego(cellType,cell):
	match cellType:
		CellType.FUEGO: agregarALista(cell)

func agregarALista(cell):
	celdasFuego.push_front(cell)
	cantFuego += 1
		
func marcarExpancion():
	# me da todas las celdas para recorrer
	for cell in celdasFuego:  
		var cellNextType = get_cellv(cell)
		dejarMarca(cell, cellNextType)
		
func dejarMarca(cell, cellNextType):
	match cellNextType:
		CellType.FUEGO: marcar(cell)

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
		CellType.PISO: marcarI(cell)

func marcarI(cell):
	set_cellv(cell,CellType.MARCA)
	celdasMarcadas.push_front(cell)   

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
	celdasMarcadas.push_front(cell) 
	marcarSICombustible(cell)   

func expandirFuego():
	for cell in get_used_cells():  
		var cellNextType = get_cellv(cell)
		agregarFuego(cell, cellNextType)

func agregarFuego(cell, cellType):
	match cellType:
		CellType.MARCA: crearCelFuego(cell)
	
func crearCelFuego(cell):
	set_cellv(cell,CellType.FUEGO)
	celdasFuego.push_front(cell)
	var v = map_to_world(cell)
	if(fuegos.size() == 0):
		var f = fuego.instance()
		f.global_position = Vector2(v.x+16,v.y+16)
	else:
		fuegos.pop_front().global_position = Vector2(v.x+16,v.y+16)
	cantFuego +=1
	
func _on_Timer_timeout():
	marcarExpancion()
	expandirFuego()
	
func apagarFuego(unFuego):
	var cell = world_to_map(unFuego.global_position)
	set_cellv(cell,CellType.PISO)
	fuegos.push_front(unFuego)
	unFuego.global_position = map_to_world(Vector2(-8,0))
	cantFuego -= 1
	if(cantFuego == 0):
		world.gano()

func modificarTimer(value):
	t.set_wait_time(value)