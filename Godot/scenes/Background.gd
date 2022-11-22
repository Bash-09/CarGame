extends TextureRect

export var movespeed: float = 300;

func _ready():
	get_material().set_shader_param("width", texture.get_width())
	get_material().set_shader_param("movespeed", movespeed)
