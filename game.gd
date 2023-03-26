extends Control

@onready var player: Node2D = $Player
@onready var missiles: Area2D = $Missiles


func _ready() -> void:
	missiles.initialize(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
