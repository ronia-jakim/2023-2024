let width = 960
let height = 540

let setup () = 
  Raylib.init_window width height "laserowy kotek";

  let player = Player.create 
    80.0 
    (2.0 *. (Float.of_int (Raylib.get_screen_height () / 3 - 10)))
    Sprite.Stationary
    2.0
    "img/cat_running_01.png"
    0.45 
    0
    0.0 
    0.5
  in 

  let back_img = Back.init_back "img/background.png" "img/midground.png" "img/foreground.png"
  in 

  let right_screen = (Float.of_int (Raylib.get_screen_width ())) +. 100.0 
  in 

  Random.self_init ();

  let pieski = 
    [
      Piesek.init_piesek 
        right_screen 
        (Float.of_int ( (Random.int (Raylib.get_screen_height () -30)) + 15 ) )
        Sprite.Jump 
        0.4
        "img/piesek.png"
        0.09 ; 
      
      Piesek.init_piesek 
        (right_screen +. 400.0)
        (Float.of_int ( (Random.int (Raylib.get_screen_height () -30)) + 15 ) )
        Sprite.Jump 
        0.45
        "img/piesek.png"
        0.09 ; 
      Piesek.init_piesek 
        (right_screen +. 500.0)
        (Float.of_int ( (Random.int (Raylib.get_screen_height () -30)) + 15 ) )
        Sprite.Jump 
        0.5
        "img/piesek.png"
        0.09 

    ]
  in
  let monetki = 
    [
      Money.init_pieniadz
        (right_screen  +. 50.0)
        (Float.of_int ( (Random.int (Raylib.get_screen_height () -200)) + 100 ) )
        0.2
        "img/coin.png"
        0.03 ; 
      
      Money.init_pieniadz 
        (right_screen +. 1500.0)
        (Float.of_int ( (Random.int (Raylib.get_screen_height () -200)) + 100 ) )
        0.15
        "img/coin.png"
        0.03 ; 
      Money.init_pieniadz 
        (right_screen +. 2000.0)
        (Float.of_int ( (Random.int (Raylib.get_screen_height () - 200)) + 100 ) )
        0.13
        "img/coin.png"
        0.03 

    ]
  in

  Raylib.set_target_fps 60;

  (false, player, back_img, pieski, monetki, false, 0, 0)


let draw_UI dst pts paused ended = 
  let mess_dst = Printf.sprintf "%.0f" dst
  in 

  let mess_pts = Printf.sprintf "%d" pts 
  in 

  let rect = Raylib.Rectangle.create (Float.of_int (Raylib.get_screen_width () / 2 - 80)) 10.0 160.0 40.0
  in

  Raylib.draw_rectangle_rounded rect 0.5 1 (Raylib.color_alpha Raylib.Color.white 0.3);

  Raylib.draw_text
   mess_dst
   ((Raylib.get_screen_width () / 2) - 30 - (Raylib.measure_text mess_dst 20 / 2))
   20
   20
   Raylib.Color.black;

  Raylib.draw_text
   mess_pts
   ((Raylib.get_screen_width () / 2) + 30 - (Raylib.measure_text mess_pts 20 / 2))
   20
   20
   Raylib.Color.black; 

   let mess = 
     if ended 
     then 
       "GAME OVER"
     else if paused 
     then 
       "GAME PAUSED"
     else ""
   in 

   if paused || ended 
   then 
     let x = ((Raylib.get_screen_width () / 2) - (Raylib.measure_text mess 30 / 2))
     in 
     let y = (Raylib.get_screen_height () / 2)
     in 
     let w = (Float.of_int (Raylib.measure_text mess 30 / 2))
     in 

     let r = Raylib.Rectangle.create 
              ((Float.of_int x) -. 20.0)
              ((Float.of_int y) -. 15.0)
              (w +. w +. 40.0)
              60.0 
     in 
      Raylib.draw_rectangle_rounded r 0.5 1 (Raylib.color_alpha Raylib.Color.white 0.6);
      Raylib.draw_text 
        mess 
        x 
        y 
        30 
        Raylib.Color.black
   

let helper player prev pies = 
  prev || (Sprite.check_collision (Player.return_sprite player) (Piesek.return_sprite pies))

let check_points player m = 
  if not (Money.return_touch m) && (Sprite.check_collision (Player.return_sprite player) (Money.return_sprite m))
  then 
    Money.touch m
  else 
    m

let add_point player m = 
  if (Money.return_touch m) 
  then 
    Player.add_points player 
  else player

let change_money m = 
  if (Money.return_touch m) 
  then 
    Money.reset_money m 
  else  
    m

let laser start_laser end_laser = 
    Raylib.draw_line_ex 
      start_laser 
      end_laser 
      8.0
      (Raylib.color_alpha Raylib.Color.green 0.6); 
    Raylib.draw_line_ex 
      start_laser 
      end_laser 
      3.0
      Raylib.Color.white 

let check_hit_piesek rect pieski = 
  if Sprite.check_collision_rec (Piesek.return_sprite pieski) rect
  then 
    Piesek.renew_piesek pieski 
  else 
    pieski


let draw_laser player pieski attack =
  let start_x = 
    ((Player.return_x player) +. (Player.return_radius_texture player) +. 30.0)
  in

  let start_y = 
    ((Player.return_y player) +. (Player.return_radius_texture player) -. 15.0)
  in

  let start_laser = Raylib.Vector2.create 
    start_x
    start_y
  in 

  let end_laser = Raylib.Vector2.create 
    (Float.of_int (Raylib.get_screen_width () + 10))
    start_y
  in 

  if attack > 0
  then 
    laser start_laser end_laser;

  let laser_rectangle = Raylib.Rectangle.create 
                          start_x 
                          (start_y -. 10.0) 
                          ((Float.of_int (Raylib.get_screen_width ())) -. start_x)
                          20.0 
  in 

  let pieski = 
    if attack > 0 
    then List.map (check_hit_piesek laser_rectangle) pieski 
    else 
      pieski
  in 
  pieski
    



let rec loop (paused, player, back_img, pieski, monetki, ended, frame_count, attack) = 
  match Raylib.window_should_close () with 
  | true -> Raylib.close_window () 
  | false ->
      Raylib.begin_drawing();
      Raylib.clear_background Raylib.Color.raywhite;

      let back_img = Back.move_back back_img
      in 
      

      let pieski = 
        if not paused && not ended 
        then 
          List.map Piesek.move pieski 
        else 
          List.map Piesek.draw_paused pieski 
      in

      let player = 
        if not paused  && not ended
        then 
          Player.move player 
        else 
          Player.draw_paused player 
      in

      let monetki = 
        if not paused && not ended
        then 
          List.map Money.move monetki
        else 
          List.map Money.draw_paused monetki 
      in 

      (* gracz dotyka monet *)
      let monetki = List.map (check_points player) monetki 
      in 

      let player = List.fold_left add_point player monetki 
      in 

      let monetki = List.map change_money monetki 
      in

      let pieski = draw_laser player pieski attack 
      in
      
      let frame_count = 
        if frame_count < 60
        then 
          frame_count + 1
        else 0
      in 

      let player = 
        if frame_count <= 14 
        then 
          Player.change_texture player "img/cat_running_01.png"
        else if frame_count <= 29 
        then 
          Player.change_texture player "img/cat_running_02.png"
        else if frame_count <= 44
        then 
          Player.change_texture player "img/cat_running_03.png"
        else 
          Player.change_texture player "img/cat_running_04.png" 
      in 

      let curr_distance = Player.return_distance player 
      in 
      let curr_points = Player.return_points player 
      in 

      let attack = 
        if Raylib.is_key_pressed Raylib.Key.H 
        then 
          if not paused 
          then 
            20 
          else 
            attack 
        else
          if attack > 0 
          then 
            attack - 1
          else 
            0 
      in

      
      let paused = 
        if Raylib.is_key_pressed Raylib.Key.P 
        then 
          not paused 
        else 
          paused 
      in

      draw_UI curr_distance curr_points paused ended;
      
      let ended = List.fold_left (helper player) ended pieski
      in

      Raylib.end_drawing ();
      loop (paused, player, back_img, pieski, monetki, ended, frame_count, attack) 

let () = setup () |> loop
