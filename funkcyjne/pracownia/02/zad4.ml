let rec merge_smutny cmp l1 l2 =
  match l1, l2 with
  | [], [] -> []
  | a :: l, [] -> l1
  | [], b :: ll -> l2
  | a :: l, b :: ll -> 
    if cmp a b then
      a :: (merge_smutny cmp l l2)
    else
      b :: (merge_smutny cmp l1 ll)

let rec merge cmp l1 l2 acc = 
  match l1, l2 with
  | [], [] -> List.rev acc
  | a :: l, [] -> (List.rev acc) @ l1
  | [], a :: l -> (List.rev acc) @ l2
  | a :: l, b :: ll -> 
    if cmp a b then
      merge cmp l l2 (a :: acc)
    else
      merge cmp l1 ll (b :: acc)

let rec chop_em lst acc1 acc2 = 
  match lst with
  | [] -> (acc1, acc2)
  | a :: [] -> ((a :: acc1), acc2)
  | a :: (b :: l) -> chop_em l (a :: acc1) (b :: acc2)


let rec merge_sort cmp lst =
  match lst with
  | [] -> []
  | [a] -> lst
  | list -> 
      let (l1, l2) = chop_em lst [] [] in 
      merge cmp (merge_sort cmp l1) (merge_sort cmp l2) []


let lst1 = [1; 2; 5]
let lst2 = [3; 4; 5]

let longer = [15; 2; 4; 5; 1; 2; 5; 3; 1; 22; 14]

let _ =
  Printf.printf "Test merge smutnego:\n";
  List.iter (Printf.printf "%d ") (merge_smutny (<=) lst1 lst2);
  Printf.printf "\n\n";

  Printf.printf "Test merge:\n";
  List.iter (Printf.printf "%d ") (merge (<=) lst1 lst2 []);
  Printf.printf "\n\n";

  let (l1, l2) = chop_em longer [] [] in
  Printf.printf "Ziom chopuś\n";
  List.iter (Printf.printf "%d ") l1;
  Printf.printf "\n";
  List.iter (Printf.printf "%d ") l2;
  Printf.printf "\n\n";

  Printf.printf "Testowanie merge srota B)\n";
  List.iter (Printf.printf "%d ") (merge_sort (<=) longer);
  Printf.printf "\n";
