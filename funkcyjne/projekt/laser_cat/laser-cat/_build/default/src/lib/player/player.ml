type player_object = {
  backbone : Sprite.sprite;

  points : int;
  distance : float;
}

let create pos_x pos_y dir_y s_y txt_path s p dst txt_radius = 
  let spr = Sprite.create
                pos_x 
                pos_y 
                false
                dir_y 
                0.0
                s_y
                txt_path
                s
                txt_radius
  in 
  let pl = 
    {
      backbone = spr;

      points = p;
      distance = dst;
    }
  in pl

let move player = 
  let curr_y = Sprite.return_directionY player.backbone 
  in 

  let new_y = 
    match curr_y with 
    | Jump -> 
        if (Sprite.return_y player.backbone) > (Float.of_int (Raylib.get_screen_height () / 3))
        then 
          Sprite.Jump
        else 
          Sprite.Fall 
    | Fall -> 
        if (Sprite.return_y player.backbone) >= 2.0 *. (Float.of_int (Raylib.get_screen_height () / 3 - 10))
        then 
          Sprite.Stationary 
        else 
          Sprite.Fall 
    | Stationary -> 
        if (Raylib.is_key_pressed Raylib.Key.Space)
        then 
          Sprite.Jump
        else 
          Sprite.Stationary
  in

  let change_jump = Sprite.change_directionY player.backbone new_y 
  in 

  let change_jump =
    if new_y == Sprite.Fall && (Raylib.is_key_down Raylib.Key.Space) 
    then 
      Sprite.change_speedY change_jump 1.0
    else 
      Sprite.change_speedY change_jump 2.0
  in


  let new_back = Sprite.move change_jump 
  in 

  let new_p = 
    {
      backbone = new_back;

      points = player.points;
      distance = player.distance +. 0.1;
    }
  in new_p

let return_distance player = player.distance
let return_points player = player.points

let draw_paused player = 
  let b = player.backbone 
  in 
  Sprite.draw_paused_unit b;
  player

let return_sprite player = player.backbone

let add_points player=
  let new_player = 
    {
      backbone = player.backbone;
    
      points = player.points + 1;
      distance = player.distance;

    }
  in new_player

let change_texture player new_path = 
  let p = 
    {
      backbone = Sprite.change_texture player.backbone new_path;

      points = player.points; 
      distance = player.distance;
    }
  in p

let return_x p = Sprite.return_x p.backbone 
let return_y p = Sprite.return_y p.backbone

let return_radius_texture p = Sprite.return_radius_texture p.backbone
