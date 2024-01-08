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

type kotek = {
  x : float;
  y : float;

  static_texture  : Raylib.Texture2D.t' Raylib.ctyp;

  jump : bool;
  fall : bool;

  speed : float;
}

let move_kotek player = 
  let new_y = 
    if player.jump 
    then 
      player.y -. player.speed
    else if player.fall 
    then 
      player.y +. player.speed
    else player.y 
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

  let new_player = 
    {
      x = player.x;
      y = new_y;

      static_texture = player.static_texture;

      jump = player.jump && (new_y > (Float.of_int (Raylib.get_screen_height () / 3)) );
      fall = player.fall;

      speed = player.speed;
    } in 
  new_player


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

  let player = {
    y = 2.0 *. (Float.of_int (Raylib.get_screen_height () / 3) );
    x = 80.0;

    static_texture = Raylib.load_texture "img/cat.png";

    jump = false;
    fall = false;

    speed = 2.0
  } in


  Raylib.set_target_fps 60;

  (false, back_image, player)

let rec loop (pause, back_img, player) =
  match Raylib.window_should_close () with 
  | true -> Raylib.close_window () 
  | false ->
    if pause 
    then 
        Raylib.draw_text 
          "Game is paused"
          ((Raylib.get_screen_width () / 2) - (Raylib.measure_text "Game is paused" 20 / 2))
          ((Raylib.get_screen_height () / 2))
          20 Raylib.Color.black; 
  
  
    let pause = if Raylib.is_key_pressed Raylib.Key.P then not pause else pause in
  
    Raylib.begin_drawing();
    Raylib.clear_background Raylib.Color.raywhite;

    let back_img = move_back back_img in

    let player = {
      x = player.x;
      y = player.y;

      static_texture = player.static_texture;

      fall = player.fall;
      jump = 
        if (Raylib.is_key_pressed Raylib.Key.Space) && (not player.jump)
        then 
          true 
        else 
          player.jump;

      speed = player.speed
    } in

    let player = move_kotek player in

    Raylib.end_drawing ();
  
    loop (pause, back_img, player)
    

let () = setup () |> loop 
