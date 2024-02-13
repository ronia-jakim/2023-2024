type background = {
  position_back : float;
  texture_back  : Raylib.Texture2D.t' Raylib.ctyp;

  position_mid  : float;
  texture_mid   : Raylib.Texture2D.t' Raylib.ctyp;

  position_fore : float;
  texture_fore  : Raylib.Texture2D.t' Raylib.ctyp
}

let init_back path_back path_mid path_fore = 
  let back_img = {
    position_back = 0.0;
    texture_back = Raylib.load_texture path_back;

    position_mid = 0.0;
    texture_mid = Raylib.load_texture path_mid;

    position_fore = 0.0;
    texture_fore = Raylib.load_texture path_fore;
  }
  in back_img


let place_texture txt pos = 
  let back_vec_1 = Raylib.Vector2.create 
    pos 
    0.0 
  in
  let back_vec_2 = Raylib.Vector2.create 
    (pos +. (4.0 *. (Float.of_int (Raylib.Texture2D.width txt)))) 
    0.0
  in
    
  Raylib.draw_texture_ex 
      txt 
      back_vec_1
      0.0 
      4.0 
      Raylib.Color.white ;
  Raylib.draw_texture_ex 
      txt
      back_vec_2
      0.0 
      4.0 
      Raylib.Color.white

let move_back (b : background) = 
  let new_back = {
    position_back = 
      if b.position_back <= -4.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_back) )
      then 
        0.0
      else 
        b.position_back -. 0.3;
    texture_back = b.texture_back;

    position_mid = 
      if b.position_mid <= -4.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_mid) )
      then 
        0.0
      else 
        b.position_mid -. 0.8;
    texture_mid = b.texture_mid;

    position_fore = 
      if b.position_fore <= -4.0 *. (Float.of_int (Raylib.Texture2D.width b.texture_fore))
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
