extends Position2D
class_name Shooter

var weapon : Weapon
var bullet : Bullet

#func fire(dir: Vector2, speed: float, weapon: Weapon) -> void:
#  var bullet_instance = bullet.instantiate()
#  bullet.setup()