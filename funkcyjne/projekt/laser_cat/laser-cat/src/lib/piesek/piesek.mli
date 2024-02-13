type piesek 

val init_piesek : float -> float -> Sprite.move_direction  -> float -> string -> float -> piesek

val move : piesek -> piesek
val draw_paused : piesek -> piesek

val return_sprite : piesek -> Sprite.sprite
val renew_piesek : piesek -> piesek
