extends Area2D


func _ready():
	pass 
	
func _on_Area2D_area_entered(area):
	get_parent().queue_free()
