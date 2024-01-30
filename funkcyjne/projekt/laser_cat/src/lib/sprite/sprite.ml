type move_direction = 
  | Jump
  | Fall 
  | Stationary

type sprite = 
  {
    x : float;
    y : float;

    directionY : move_direction;
    directionX : bool;

    speedY : float;
    speedX : float;

    texture_path : string;
    static_texture : Raylib.Texture2D.t' Raylib.ctyp;
    
    scale : float;

    (*collider : Raylib.Rectangle.t' Raylib.ctyp;*)
    collider : Raylib.Vector2.t' Raylib.ctyp;
    radius : float;
  }

let create pos_x pos_y dir_x dir_y s_x s_y txt_path s = 
  let texture = Raylib.load_texture txt_path 
  in 

  let w = (Float.of_int (Raylib.Texture2D.width texture)) *. s 
  in  
  let h = (Float.of_int (Raylib.Texture2D.height texture)) *. s 
  in 

  let d = (w +. h) /. 2.0
  in 

 (*  let coll = Raylib.Rectangle.create pos_x pos_y w h 
  in*) 

  let coll = Raylib.Vector2.create 
    (pos_x +. (0.5 *. d))
    (pos_y +. (0.5 *. d))
  in 


  let new_sprite = 
    {
      x = pos_x;
      y = pos_y;

      directionY = dir_y;
      directionX = dir_x;

      speedY = s_y;
      speedX = s_x;
      
      texture_path = txt_path;
      static_texture = texture;

      scale = s;

      collider = coll;
      radius = d /. 2.0;
    }
  in new_sprite

let draw_sprite sp pos_vec = 
  Raylib.draw_texture_ex 
    sp.static_texture 
    pos_vec 
    0.0
    sp.scale 
    Raylib.Color.white

let draw_paused_unit sp = 
  let pos_vec = Raylib.Vector2.create 
    sp.x 
    sp.y 
  in 
  draw_sprite sp pos_vec

let draw_paused sp = 
  let pos_vec = Raylib.Vector2.create 
    sp.x 
    sp.y 
  in 
  draw_sprite sp pos_vec;
  sp
  
let move_coll new_x new_y = 
  (* let w = (Float.of_int (Raylib.Texture2D.width sp.static_texture)) *. sp.scale
  in

  let h = (Float.of_int (Raylib.Texture2D.height sp.static_texture)) *. sp.scale
  in
  
  let coll = Raylib.Rectangle.create new_x new_y w h 
  in *) 
  let coll = Raylib.Vector2.create new_x new_y 
  in 
  coll

let move sp = 
  let pos_vec = Raylib.Vector2.create
    sp.x 
    sp.y 
  in 

  draw_sprite sp pos_vec;

  let new_y = match sp.directionY with 
  | Jump -> 
      sp.y -. (1.5 *. sp.speedY)
  | Fall ->
      sp.y +. sp.speedY
  | Stationary -> 
      sp.y
  in 

  let new_x = match sp.directionX with 
  | true -> 
      sp.x -. sp.speedX
  | false ->
      sp.x 
  in 


  let new_sp = {
    x = new_x;
    y = new_y;
    directionX = sp.directionX;
    directionY = sp.directionY; 
    speedX = sp.speedX;
    speedY = sp.speedY;
    texture_path = sp.texture_path;
    static_texture = sp.static_texture;
    scale = sp.scale;
    collider = move_coll new_x new_y;
    radius = sp.radius;
  }
  in 
  new_sp

let return_x sp = sp.x 
let return_y sp = sp.y

let return_directionX sp = sp.directionX
let return_directionY sp = sp.directionY

let return_width sp = 
  (Float.of_int (Raylib.Texture2D.width sp.static_texture)) *. sp.scale 
let return_height sp = 
  (Float.of_int (Raylib.Texture2D.height sp.static_texture)) *. sp.scale

let change_directionY sp new_dir = 
  let new_sp = {
    x = sp.x;
    y = sp.y;
    
    directionX = sp.directionX;
    directionY = new_dir; 

    speedX = sp.speedX;
    speedY = sp.speedY;

    texture_path = sp.texture_path;
    static_texture = sp.static_texture;
    scale = sp.scale;

    collider = move_coll sp.x sp.y; 
    radius = sp.radius;
  }
  in new_sp

let change_directionX sp new_dir = 
  let new_sp = {
    x = sp.x;
    y = sp.y;
    
    directionX = new_dir;
    directionY = sp.directionY; 

    speedX = sp.speedX;
    speedY = sp.speedY;

    texture_path = sp.texture_path;
    static_texture = sp.static_texture;
    scale = sp.scale;

    collider = move_coll sp.x sp.y; 
    radius = sp.radius;
  }
  in new_sp

let change_speedX sp new_sp = 
  let new_sp = {
    x = sp.x;
    y = sp.y;
    
    directionX = sp.directionX;
    directionY = sp.directionY; 

    speedX = new_sp;
    speedY = sp.speedY;

    texture_path = sp.texture_path;
    static_texture = sp.static_texture;
    scale = sp.scale;

    collider = move_coll sp.x sp.y;
    radius = sp.radius;
  }
  in new_sp


let change_speedY sp new_sp = 
  let new_sp = {
    x = sp.x;
    y = sp.y;
    
    directionX = sp.directionX;
    directionY = sp.directionY; 

    speedX = sp.speedX;
    speedY = new_sp;

    texture_path = sp.texture_path;
    static_texture = sp.static_texture;
    scale = sp.scale;

    collider = move_coll sp.x sp.y;
    radius = sp.radius;
  }
  in new_sp

let return_scale sp = sp.scale 

let check_collision sp1 sp2 = 
  (* Raylib.check_collision_recs sp1.collider sp2.collider *)
  Raylib.check_collision_circles sp1.collider sp1.radius sp2.collider sp2.radius

let return_speedY sp = sp.speedY
