extends Position2D
class_name Gun

const BULLET = preload("res://shooter/bullet.tscn")

func fire():
	var bullet : Bullet = BULLET.instantiate()
	bullet.set_course_to(Vector2.RIGHT)