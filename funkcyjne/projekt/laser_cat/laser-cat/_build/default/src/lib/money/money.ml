type pieniadz = {
  back : Sprite.sprite;

  touched : bool;
  txt_path : string;
  start_y : float;
}

let init_pieniadz pos_x pos_y s_y txt_path s = 
  Random.self_init ();

  let s_x = 0.5 +. 0.3 *. (Float.of_int (Random.int 4))
  in 

  Random.self_init ();

  let spr = Sprite.create 
    pos_x 
    pos_y 
    (1 == (Random.int 6))
    Sprite.Jump 
    s_x 
    s_y 
    txt_path 
    s 
    1.0
  in 

  let pieniadz = {
    back = spr; 

    start_y = pos_y;

    touched = false; 
    txt_path = txt_path;
  }
  in pieniadz

let reset_money pien = 
  let potential_x = (Float.of_int (Raylib.get_screen_width () + 100))
  in 
  let potential_y = (Float.of_int ( (Random.int (Raylib.get_screen_height () - 30)) + 15 ))
  in
  let p = 
      init_pieniadz potential_x potential_y (Sprite.return_speedY pien.back) pien.txt_path (Sprite.return_scale pien.back) 
  in p

let move pien = 
  let curr_y_dir = Sprite.return_directionY pien.back 
  in 

  let pos_y = (Sprite.return_y pien.back)
  in 

  let new_y_dir = match curr_y_dir with 
  | Jump -> 
      if pos_y <= (pien.start_y -. 5.0)
      then 
        Sprite.Fall 
      else 
        Sprite.Jump 
  | Fall ->
      if pos_y >= (pien.start_y +. 5.0) 
      then 
        Sprite.Jump 
      else 
        Sprite.Fall 
  | Stationary -> Sprite.Jump 
  in 

  let b = Sprite.change_directionY pien.back new_y_dir
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


  let p = 
    if (Sprite.return_x pien.back) < -60.0 
    then 
      reset_money pien
    else 
      {
        back = (Sprite.move b);

        start_y = pien.start_y;
        txt_path = pien.txt_path;
        touched = pien.touched;
      }
  in p

let touch pien = 
  let p = {
    back = pien.back;
    start_y = pien.start_y;
    txt_path = pien.txt_path;
    touched = true; 
  }
  in p



let draw_paused pien = 
  Sprite.draw_paused_unit pien.back; 
  pien

let return_sprite pien = pien.back 
let return_touch pien = pien.touched
