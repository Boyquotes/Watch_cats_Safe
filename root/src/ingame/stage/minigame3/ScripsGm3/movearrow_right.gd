extends Area2D

var speed = 100
var sensor = 0

func _process(delta):
	position.y -= speed * delta
	
	if position.y < -50:
		queue_free()
	if sensor == 1:
		if Global.sensorRight == 1:
			if Input.is_action_just_pressed("ui_right"):
				queue_free()


func _on_movearrow_right_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	Global.sensorRight = 1


func _on_movearrow_right_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
	Global.sensorRight = 0
