type move_direction = 
  | Jump 
  | Fall 
  | Stationary

type sprite


(* pos_x pos_y dir_x dir_y s_x s_y texture scale *)
val create : float -> float -> bool -> move_direction -> float -> float -> string -> float -> sprite

val move : sprite -> sprite

val return_x : sprite -> float 
val return_y : sprite -> float 

val return_directionX : sprite -> bool  
val return_directionY : sprite -> move_direction 

val return_width  : sprite -> float 
val return_height : sprite -> float

val change_directionY : sprite -> move_direction -> sprite
val change_directionX : sprite -> bool -> sprite

val change_speedY : sprite -> float -> sprite 
val change_speedX : sprite -> float -> sprite 

val check_collision : sprite -> sprite -> bool

val draw_paused : sprite -> sprite 
val draw_paused_unit : sprite -> unit

val return_scale : sprite -> float

val return_speedY : sprite -> float
