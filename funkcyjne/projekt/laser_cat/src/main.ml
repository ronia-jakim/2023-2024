let width = 720
let height = 405

(*
  =============================================

  DZIAŁANIE NA TLE - PARALEXA I INNE CHUJU MUJU
  
  =============================================
*)

type background = {
  position_back : float;
  texture_back  : Raylib.Texture2D.t' Raylib.ctyp;

  position_mid  : float;
  texture_mid   : Raylib.Texture2D.t' Raylib.ctyp;

  position_fore : float;
  texture_fore  : Raylib.Texture2D.t' Raylib.ctyp
}

let place_texture txt pos = 
  let back_vec_1 = Raylib.Vector2.create 
    pos 
    0.0 
  in
  let back_vec_2 = Raylib.Vector2.create 
    (pos +. (3.0 *. (Float.of_int (Raylib.Texture2D.width txt)))) 
    0.0
  in
    
  Raylib.draw_texture_ex 
      txt 
      back_vec_1
      0.0 
      3.0 
      Raylib.Color.white ;
  Raylib.draw_texture_ex 
      txt
      back_vec_2
      0.0 
      3.0 
      Raylib.Color.white

let move_back (b : background) = 
  let new_back = {
    position_back = 
      if b.position_back <= -3.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_back) )
      then 
        0.0
      else 
        b.position_back -. 0.3;
    texture_back = b.texture_back;

    position_mid = 
      if b.position_mid <= -3.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_mid) )
      then 
        0.0
      else 
        b.position_mid -. 0.8;
    texture_mid = b.texture_mid;

    position_fore = 
      if b.position_fore <= -3.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_fore))
      then 
        0.0 
      else 
        b.position_fore -. 1.2;
      texture_fore = b.texture_fore
  }
  in 

  place_texture new_back.texture_back new_back.position_back;
  place_texture new_back.texture_mid new_back.position_mid;
  place_texture new_back.texture_fore new_back.position_fore;
  
  new_back

(*
  =============================
  
  DZIAŁANIE NA KOTKU - SKAKANIE 
  
  =============================
*)

module Kot = struct

type stanKotka = 
  | Jump
  | Fall
  | Stationary

type kotek = {
  x : float;
  y : float;

  static_texture  : Raylib.Texture2D.t' Raylib.ctyp;

  jump : stanKotka;

  speed : float;

  collider : Raylib.Rectangle.t' Raylib.ctyp;
}

let create_kotek kY kX texture j sp = 
  let w = (Float.of_int (Raylib.Texture2D.width texture)) *. 0.03
  in 
  let h = (Float.of_int (Raylib.Texture2D.height texture)) *. 0.03
  in 

  let coll = Raylib.Rectangle.create kX kY w h in 
  let kot = 
    {
      y = kY;
      x = kX;

    static_texture = texture;

    jump = j;

    speed = sp;

    collider = coll
  } in
  kot

let move_kotek player = 
  let new_y = match player.jump with 
  | Jump -> player.y -. ( 1.25 *. player.speed  )
  | Fall -> player.y +. player.speed
  | Stationary -> player.y
  in 

  let pos_vec = Raylib.Vector2.create
    player.x 
    new_y 
  in 

  Raylib.draw_texture_ex 
    player.static_texture 
    pos_vec
    0.0
    0.03
    Raylib.Color.white; 

  let new_jump = match player.jump with 
      | Jump -> 
          if new_y > (Float.of_int (Raylib.get_screen_height () / 3))
          then 
            Jump 
          else 
            Fall 
      | Fall -> 
          if new_y >= 2.0 *. (Float.of_int (Raylib.get_screen_height () / 3))
          then 
            Stationary 
          else 
            Fall 
      | Stationary -> Stationary
  in

  let new_player = create_kotek new_y player.x player.static_texture new_jump player.speed 
  in 
  new_player


let check_jump player = 
  match player.jump with 
    | Jump -> Jump 
    | Fall -> Fall 
    | Stationary -> 
        if (Raylib.is_key_pressed Raylib.Key.Space) 
        then 
          Jump 
        else
          Stationary 

let return_x player = player.x 
let return_y player = player.y

let return_width player = 
  (Float.of_int (Raylib.Texture2D.width player.static_texture)) *. 0.03
let return_height player = 
  (Float.of_int (Raylib.Texture2D.height player.static_texture)) *. 0.03

let return_collider player = player.collider
    

end

(*
  =============================
  
  PIESKI
  
  =============================
*)

module Pies = struct

type piesek = {
  start_y : float;

  x : float;
  y : float;

  upwards : bool;

  static_texture : Raylib.Texture2D.t' Raylib.ctyp;

  speed_x : float;
  speed_y : float;

  move : bool;

  collider : Raylib.Rectangle.t' Raylib.ctyp;
}

let create_piesek up init_y sx sy txt pos_y pos_x mv = 
  let w = (Float.of_int (Raylib.Texture2D.width txt)) *. 0.09
  in 
  let h = (Float.of_int (Raylib.Texture2D.height txt)) *. 0.09 
  in 

  let coll = Raylib.Rectangle.create pos_x pos_y w h  
  in 

  let p = {
    upwards = up;

    start_y = init_y;

    speed_x = sx;
    speed_y = sy;

    static_texture = txt;

    y = pos_y;
    x = pos_x;

    move = mv;

    collider = coll;
  }
  in p

let init_piesek nr mv = 
  Random.self_init ();

  let txt = Raylib.load_texture "./img/piesek.png"
  in

  let y1 =  Float.of_int (Random.int (Raylib.get_screen_height ()) - 60) +. 30.0
  in 

  let right_of_screen = (Float.of_int (Raylib.get_screen_width ())) +. 100.0 +. (100.0 *. (Float.of_int nr))
  in 

  Random.self_init();

  let speed = 1.5 +. (Float.of_int (Random.int 3))
  in 
  
  let w = (Float.of_int (Raylib.Texture2D.width txt)) *. 0.09
  in 

  let h = (Float.of_int (Raylib.Texture2D.height txt)) *. 0.09
  in 

  let coll = Raylib.Rectangle.create right_of_screen y1 w h 
  in
    
  let p = 
    {
      start_y = y1;

      y = y1; 
      x = right_of_screen;

      upwards = true; 

      static_texture = txt;

      speed_x = speed;
      speed_y = 0.8;

      move = mv;
      
      collider = coll;
    }
  in p

let move_piesek pies = 
  let new_y = match pies.upwards with 
  | false -> 
      pies.y +. pies.speed_y;
  | true ->
      pies.y -. pies.speed_y;
  in

  let new_upwards = 
    if pies.upwards && (new_y <= pies.start_y -. (Float.of_int (Raylib.get_screen_height () / 20)))
    then false 
    else if (not pies.upwards) && (new_y >= pies.start_y +. (Float.of_int (Raylib.get_screen_height () / 20)))
    then true 
    else pies.upwards
  in

  Random.self_init ();

  let rand_bool = Random.int 2
  in 

  let new_move = if pies.x < -60.0 then rand_bool == 1 else pies.move
  in
  
  (* new_start_y, new_y, new_speed, new_x *)
  let lst = 
    if pies.x < -60.0 
    then 
      let y_help = (Float.of_int (Random.int (Raylib.get_screen_height () - 60))) +. 30.0
      in 
      [ y_help ; 
        y_help ; 
        Float.of_int (Random.int 2) +. 1.5;
        (Float.of_int (Raylib.get_screen_width ())) +. 100.0;
      ]
    else 
      [
        pies.start_y;
        new_y; 
        pies.speed_x;
        pies.x -. pies.speed_x;
      ]
  in


  let pos_vec = Raylib.Vector2.create
    (List.nth lst 3)
    (List.nth lst 1)
  in 

  Raylib.draw_texture_ex 
    pies.static_texture 
    pos_vec
    0.0
    0.09

    Raylib.Color.white; 

  let new_pies = create_piesek 
                    new_upwards 
                    (List.nth lst 0) 
                    (List.nth lst 2) 
                    pies.speed_y 
                    pies.static_texture 
                    (List.nth lst 1) 
                    (List.nth lst 3) 
                    new_move 
  in 
  
  new_pies

  let return_collider pies = pies.collider
end 



(*
  =============================
  
  PROGRAM WŁAŚCIWY
  
  =============================
*)

let setup () = 

  Raylib.init_window width height "laserowy kotek";

  let back_image = {
    position_back = 0.0;
    texture_back = Raylib.load_texture "img/background.png";

    position_mid = 0.0;
    texture_mid = Raylib.load_texture "img/midground.png";

    position_fore = 0.0;
    texture_fore = Raylib.load_texture "img/foreground.png"
  } in

  let txt = Raylib.load_texture "img/cat.png"
  in

  let player = Kot.create_kotek (2.0 *. (Float.of_int (Raylib.get_screen_height () / 3))) 80.0 txt Stationary 3.0
  in

  Random.self_init ();

  let pies_list = [
    Pies.init_piesek 0 true ; Pies.init_piesek 1 true ; Pies.init_piesek 2 true ;
  ]
  in 

  Raylib.set_target_fps 60;

  (false, back_image, player, pies_list)




let helper player prev r = 
  prev || (Raylib.check_collision_recs (Kot.return_collider player) (Pies.return_collider r))

let rec loop (pause, back_img, player, pies_list) =
  match Raylib.window_should_close () with 
  | true -> Raylib.close_window () 
  | false ->
 
  
    let pause = if Raylib.is_key_pressed Raylib.Key.P then not pause else pause in
  
    Raylib.begin_drawing();
    Raylib.clear_background Raylib.Color.raywhite;


    let new_jump = Kot.check_jump player 
    in

    let player = Kot.create_kotek player.y player.x player.static_texture new_jump player.speed
    in

    let back_img = move_back back_img in
    let player = Kot.move_kotek player in
    let pies_list = List.map Pies.move_piesek pies_list
    in

    if List.fold_left (helper player) false pies_list
    then 
      Raylib.draw_text 
        "They be touchin"
        ((Raylib.get_screen_width () / 2) - (Raylib.measure_text "Game is paused" 20 / 2))
        ((Raylib.get_screen_height () / 2))
        20 Raylib.Color.black
    else 
      Raylib.draw_text 
        "They not be touchin"
        ((Raylib.get_screen_width () / 2) - (Raylib.measure_text "Game is paused" 20 / 2))
        ((Raylib.get_screen_height () / 2))
        20 Raylib.Color.black;

    if pause 
    then 
        Raylib.draw_text 
          "Game is paused"
          ((Raylib.get_screen_width () / 2) - (Raylib.measure_text "Game is paused" 20 / 2))
          ((Raylib.get_screen_height () / 2))
          20 Raylib.Color.black;


    Raylib.end_drawing ();
  
    loop (pause, back_img, player, pies_list)
    

let () = 
setup () |> loop 
