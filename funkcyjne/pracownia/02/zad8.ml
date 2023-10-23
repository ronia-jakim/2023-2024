open Zad7
 
let fajne_sortowanie lst =
  let rec ff ziom = 
    match wez_daj_minimum ziom with
    | None -> []
    | Some x -> x :: ff (wyrzuc_smieci ziom)
  in ff (

 


      List.fold_left (fun x y -> dodaj_na_kolejke y x) pustak lst)

let tescior = [1; 5; 4; 7; 12; 3; 69]

let _ = 
  Printf.printf "Wielki test\n";
  List.iter (Printf.printf "%d ") (fajne_sortowanie tescior);
  Printf.printf "sukces!\n"
