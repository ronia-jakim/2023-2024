(*** z elementow od a do b strumienia s robi liste *)

let rec tabulate s ?(a=0) b = 
  if b < a then []
  else (s a) :: (tabulate s ~a:(a+1) b)

let rec fibb n = if n <= 1 then 1 else fibb (n-1) + fibb (n-2);;

let _ =
  List.iter (Printf.printf "%i ") (tabulate fibb 9);
  print_string "\n";
  List.iter (Printf.printf "%i ") (tabulate fibb ~a:3 9);
  print_string "Dupa\n"
