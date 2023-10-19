let sufiksy lst = List.fold_right (fun an init -> (an :: (List.hd init)) :: init) lst [[]]

let prefiksy lst = List.fold_left (fun init an -> ((List.hd init) @ [an]) :: init) [[]] lst

let lst1 = [1; 2; 3]

let helper l = 
  Printf.printf "[ ";
  List.iter (Printf.printf "%d ") l;
  Printf.printf "]\n"

let _ = 
  Printf.printf "ogonki listy [1; 2; 3]:\n";
  List.iter helper (sufiksy lst1);
  Printf.printf "\n\n";
  
  Printf.printf "główki listy [1; 2; 3]:\n";
  List.iter helper (prefiksy lst1);
  Printf.printf "\n\n";
