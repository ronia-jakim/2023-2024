(*** Dla strumieni z poprzedniego ... *)
let scan f a s = let rec new_s n = if n > 0 then f (new_s (n-1)) (s n) else f a (s 0) in new_s

let rec fibb n = if n <= 1 then 1 else fibb (n-1) + fibb (n-2);;

let _ =
  print_string "Dupa\n";
  Printf.printf "%i : %i -> %i\n" 0 (fibb 0) ((scan (+) 9 fibb) 0);
  Printf.printf "%i : %i -> %i\n" 1 (fibb 1) ((scan (+) 9 fibb) 1);
  Printf.printf "%i : %i -> %i\n" 2 (fibb 2) ((scan (+) 9 fibb) 2);
  Printf.printf "%i : %i -> %i\n" 3 (fibb 3) ((scan (+) 9 fibb) 3);
  Printf.printf "%i : %i -> %i\n" 4 (fibb 4) ((scan (+) 9 fibb) 4);
