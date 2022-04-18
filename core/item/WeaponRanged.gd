extends Weapon
class_name WeaponRanged

@export_enum(AUTOMATIC, SEMI, LASER) var projectile_type
@export var automatic : bool
@export var clip_size : int
@export var recoil_force : float
@export var bullet_speed : float
@export var cooldown : float