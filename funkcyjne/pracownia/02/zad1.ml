let length lst = List.fold_left (fun x y -> x + 1) 0 lst

let rev lst = List.fold_left (fun x y -> y :: x) [] lst

(*** to chyba jednak nie o to chodziło 
let map f lst = rev (List.fold_left (fun x y -> (f y) :: x) [] lst)
*)
let mapp f lst = List.fold_right (fun x y -> (f x) :: y) lst []


let append lst1 lst2 = List.fold_right (fun x y -> x :: y) lst1 lst2

let rev_append lst1 lst2 = List.fold_left (fun x y -> y :: x) lst2 lst1

let filter f lst = List.fold_right (fun x y -> if (f x) then x :: y else y) lst []

let rev_map f lst = List.fold_left (fun x y -> (f y) :: x) [] lst


let lst_1 = [1; 3; 2]
let lst_2 = [6; 8; 9]

let _ =
  Printf.printf "Długość listy [1, 3, 2]: %d\n\n" (length lst_1);

  Printf.printf "Przewrócona lista to:\n[ ";
  List.iter (Printf.printf "%d ") (rev lst_1);
  Printf.printf "]\n\n";

  Printf.printf "A teraz dodaję sobie do tej listy liczbę 2\n[ ";
  List.iter (Printf.printf "%d ") (mapp (fun x -> x + 2) lst_1);
  Printf.printf "]\n\n";

  Printf.printf "Teraz próba mojego appenda:\n[ ";
  List.iter (Printf.printf "%d ") (append lst_1 lst_2);
  Printf.printf "]\n\n";

  Printf.printf "Czas na rev_append:\n[ ";
  List.iter (Printf.printf "%d ") (rev_append lst_1 lst_2);
  Printf.printf "]\n\n";

  Printf.printf "Sprawdzanko filtera (lst_1 i liczby <= 2) \n[ ";
  List.iter (Printf.printf "%d ") (filter (fun x -> if x <= 2 then true else false) lst_1);
  Printf.printf "]\n\n";

  Printf.printf "Ostatnia część tej farsy, czyli sprawdzanie rev_map:\n[ ";
  List.iter (Printf.printf "%d ") (rev_map (fun x -> x + 2) lst_1);
  Printf.printf "]\n\n";
