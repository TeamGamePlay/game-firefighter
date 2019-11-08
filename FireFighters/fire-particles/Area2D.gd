extends Area2D


func _ready():
	pass 
	
func _on_Area2D_area_entered(area):
	if area.get_name() == "Area2D":
	   get_parent().queue_free()