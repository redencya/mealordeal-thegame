extends GunState

func update(_delta: float):
  if Input.is_action_just_pressed("shoot"):
    gun.fire()