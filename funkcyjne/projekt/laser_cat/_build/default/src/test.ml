let width = 1200
let height = 800

let screen_upper_limit = 40.0 

let setup () = 
  let open Raylib in 
  init_window width height "laser cat test";
  let player_box = Rectangle.create 200.0 200.0 50.0 50.0 
  in
  player_box

let rec loop player_box = 
  match Raylib.window_should_close () with 
  | true -> Raylib.close_window () 
  | false -> 
      let open Raylib in 
    
      begin_drawing();
      clear_background Color.raywhite;

      draw_rectangle_rec player_box Color.green;

      draw_fps 10 10; 

      end_drawing ();

      loop player_box

let () = setup () |> loop
