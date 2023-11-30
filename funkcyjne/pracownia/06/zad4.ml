let rec fold_left_cps (f : 'a -> 'b -> ('a -> 'c) -> 'c) (init : 'a) (lst : 'b list) (init_cont : 'a -> 'c) : 'c = 
  match lst with 
  | [] -> init_cont init 
  | a :: ll -> f init a (fun x -> fold_left_cps f x ll init_cont)

let fold_left (f : 'a -> 'b -> 'a) (init : 'a) (lst : 'b list) = 
  let ff a b cont = cont (f a b) in 
  fold_left_cps ff init lst (fun x -> x)

let string_list = ["weles "; "jest "; "czarny "]

let _ = 
  Printf.printf "%s\n" (List.fold_left (^) "" string_list);
  Printf.printf "%s\n" (fold_left (^) "" string_list)
