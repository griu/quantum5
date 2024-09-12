extends TileMap



func _ready():
	for xtile in Global.width_tilemap:
		for ytile in Global.height_tilemap:
			set_cell(0, Vector2i(xtile, ytile), 0, Vector2i(0, 0))
			#if ((xtile*ytile) % 3)*int(randf() > 0.6)!=0 and xtile > 0 and ytile > 0  and xtile < 17 and ytile < 8:
			if ((xtile*ytile) % 3)*int(randf() > 0.5)!=0 and Vector2i(xtile, ytile) != Vector2i(Global.key_x, Global.key_y):
				set_cell(0, Vector2i(xtile, ytile), 0, Vector2i(0, 3))
			



