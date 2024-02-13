type pieniadz

val init_pieniadz : float -> float -> float -> string -> float -> pieniadz 

val move : pieniadz -> pieniadz 

val touch : pieniadz -> pieniadz 

val return_sprite : pieniadz -> Sprite.sprite
val return_touch : pieniadz -> bool 

val reset_money : pieniadz -> pieniadz

val draw_paused : pieniadz -> pieniadz
