(* val fold_left : ('acc -> 'a -> 'acc) -> 'acc -> 'a list -> 'acc *)
let rec fold_left f init lst = 
  match lst with
  | [] -> init 
  | a :: ll -> f (fold_left f init ll) a

exception Weles

let for_all (p : 'a -> bool) (lst : 'a list) : bool =
  let f acc a = 
    if p a then acc && ( p a ) else raise Weles
  in try fold_left f true lst with 
  Weles -> false

let mult_list (lst : int list) : int = 
  let f acc a = 
    if a == 0 then raise Weles else acc * a 
  in try fold_left f 1 lst with 
  Weles -> 0 

let sorted (lst : int list) : bool = 
  let f acc a = 
    match acc with 
    | None -> Some a
    | Some prec ->
        if prec > a then raise Weles else Some a
  in try let _ = fold_left f None lst in true
  with Weles -> false
