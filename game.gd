extends Control

@onready var player: Node2D = $Player
@onready var missiles: Area2D = $Missiles


func _ready() -> void:
	missiles.initialize(player)
