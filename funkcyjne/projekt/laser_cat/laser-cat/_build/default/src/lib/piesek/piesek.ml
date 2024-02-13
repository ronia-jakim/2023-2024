type piesek = {
  back : Sprite.sprite;
  start_y : float;

  path : string;
}

let init_piesek pos_x pos_y dir_y s_y txt_path s = 
  Random.self_init ();
  let s_x = 1.0 +. 0.3 *. (Float.of_int (Random.int 3))
  in 

  Random.self_init ();

  let spr = Sprite.create
    pos_x 
    pos_y 
    (1 == (Random.int 4))
    dir_y 
    s_x 
    s_y 
    txt_path 
    s 
    1.0
  in 

  let pies = {
    back = spr; 
    start_y = pos_y;
    path = txt_path;
  }
  in pies

let move pies = 
  let curr_y_dir = Sprite.return_directionY pies.back 
  in 

  let pos_y = (Sprite.return_y pies.back)
  in 

  let new_y_dir = match curr_y_dir with 
  | Jump -> 
      if pos_y <= (pies.start_y -. 10.0)
      then 
        Sprite.Fall 
      else 
        Sprite.Jump 
  | Fall ->
      if pos_y >= (pies.start_y +. 10.0) 
      then 
        Sprite.Jump 
      else 
        Sprite.Fall 
  | Stationary -> Sprite.Jump 
  in 

  let b = Sprite.change_directionY pies.back new_y_dir
  in 

  let curr_x_dir = Sprite.return_directionX b 
  in  

  Random.self_init ();

  let new_x_dir = 
    if curr_x_dir
    then 
      curr_x_dir 
    else 
      (1 == (Random.int 2))
  in
  
  let b = Sprite.change_directionX b new_x_dir 
  in

  let potential_x = (Float.of_int (Raylib.get_screen_width () + 100))
  in 
  let potential_y = (Float.of_int ( (Random.int (Raylib.get_screen_height () - 30)) + 15 ))
  in

  let p = 
    if (Sprite.return_x pies.back) < -30.0 
    then 
      init_piesek potential_x potential_y new_y_dir (Sprite.return_speedY pies.back) pies.path (Sprite.return_scale pies.back) 
    else 
      {
        back = (Sprite.move b);

        start_y = pies.start_y;
        path = pies.path;
      }
  in p

let draw_paused pies = 
    Sprite.draw_paused_unit pies.back; 
    pies 

let return_sprite pies = pies.back

let renew_piesek pies = 
  let potential_x = (Float.of_int (Raylib.get_screen_width () + 100))
  in 
  let potential_y = (Float.of_int ( (Random.int (Raylib.get_screen_height () - 30)) + 15 ))
  in
    init_piesek potential_x potential_y Jump (Sprite.return_speedY pies.back) pies.path (Sprite.return_scale pies.back) 
