let width = 1200
let height = 800

let screen_upper_limit = 40.0 

let setup () = 
  let open Raylib in 
  init_window width height "laser cat test";
  let player_box = Rectangle.create 100.0 
    (Float.of_int (get_screen_height () - 160) ) 
    150.0 150.0
  in 
  let player_speed_y = 0.0 in 

  let obstacle_box = Rectangle.create 
    ( Float.of_int ( (get_screen_width () ) - 110) )
    (Float.of_int ( get_screen_height () - 110 )) 
    100.0 100.0
  in
  let obstacle_speed = -12.0 in 

  set_target_fps 60;
  (false, false, player_box, obstacle_box, player_speed_y, obstacle_speed)

let rec loop (pause, jump, player_box, obstacle_box, player_box_speed_y, obstacle_speed) = 
  match Raylib.window_should_close () with 
  | true -> Raylib.close_window () 
  | false -> 
      let open Raylib in 
      (if not pause then 
        Rectangle.(set_x obstacle_box (x obstacle_box +. obstacle_speed));
        Rectangle.(set_y player_box (y player_box -. player_box_speed_y)) 
      );
      
      let spawn_new = Random.int 200 in

      (*draw_text 
        (string_of_int spawn_new)
        ((get_screen_width () / 2) - (measure_text "COLLISION!" 20 / 2))
        ((Int.of_float screen_upper_limit / 2) - 10)
        20 Color.black;*)


      if Rectangle.(x obstacle_box <= 0.0) && (spawn_new == 2)
      then
          Rectangle.(
            set_x obstacle_box ( Float.of_int ( ( get_screen_width  () )     - 110 )) 
          );


      let pause = if is_key_pressed Key.P then not pause else pause in

      let upper_border = Float.of_int (3 * (get_screen_height () / 8) )
      in

      let lower_border = Float.of_int ( get_screen_height () - 160 )
      in

      let jump = 
        if (is_key_pressed Key.Space && Rectangle.(y player_box >= lower_border)) || Rectangle.(y player_box < upper_border)
        then 
          not jump 
        else 
          jump 
      in

      let player_box_speed_y = 
        if jump 
        then 
          10.0 
        else if Rectangle.(y player_box < lower_border)
        then 
          -10.0 
        else
          0.0 
      in
    
      begin_drawing();
      clear_background Color.raywhite;

      draw_rectangle_rec player_box Color.green;
      draw_rectangle_rec obstacle_box Color.red;

      draw_fps 10 10; 

      end_drawing ();

      loop(pause, jump, player_box, obstacle_box, player_box_speed_y, obstacle_speed)

let () = setup () |> loop
