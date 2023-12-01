let rec fold_left_cps (f : 'a -> 'b -> ('a -> 'c) -> 'c) (init : 'a) (lst : 'b list) (init_cont : 'a -> 'c) : 'c = 
  match lst with 
  | [] -> init_cont init 
  | a :: ll -> f init a (fun x -> fold_left_cps f x ll init_cont)

let for_all (p : 'a -> bool) (lst : 'a list) : bool = 
  let f a b cont = 
    if p b then cont a
    else false 
  in fold_left_cps f true lst (fun x -> x)

let mult_list (lst : int list) : int = 
  let f a b cont = 
    if b == 0 then 0
    else cont (a * b) 
  in fold_left_cps f 1 lst (fun x -> x)

let sorted (lst : int list) : bool = 
  let f a b cont = 
    match a with 
    | None -> cont (Some b)
    | Some aa -> 
      if b <= aa then false
      else cont (Some aa)
  in fold_left_cps f None lst (fun x -> true)
