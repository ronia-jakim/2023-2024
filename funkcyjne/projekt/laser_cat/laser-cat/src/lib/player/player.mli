type player_object

(* let create pos_x pos_y dir_y s_y txt_path s p dst g =  *)
(* pos_x pos_y dir_y speed_y texture scale points distance gameOver *)
val create : float -> float -> Sprite.move_direction -> float -> string -> float -> int -> float -> float -> player_object

val move : player_object -> player_object

val return_distance : player_object -> float
val return_points : player_object -> int

val draw_paused : player_object -> player_object 

val return_sprite : player_object -> Sprite.sprite

val add_points : player_object -> player_object

val change_texture : player_object -> string -> player_object 

val return_x : player_object -> float 
val return_y : player_object -> float 

val return_radius_texture : player_object -> float 
