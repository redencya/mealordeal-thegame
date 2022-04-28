class_name PlayerState extends State

@export var stamina : Resource
var player: Player

func _ready() -> void:
  player = owner as Player
  assert(player != null)

# Virtual method for [Stamina] resource calculations. 
# Can be overriden by re-declaring with different contents.
func update_stamina(delta: float) -> void:
  stamina.replenish(delta)

func update(delta: float) -> void:
  update_stamina(delta)