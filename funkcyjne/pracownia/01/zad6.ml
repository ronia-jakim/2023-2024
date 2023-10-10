let ctrue : 'a -> 'a -> 'a = fun a b -> a

let cfalse : 'a -> 'a -> 'a = fun a b -> b

let cbool_of_bool : bool -> 'a -> 'a -> 'a = fun x -> if x then ctrue else cfalse

let bool_of_cbool : (bool -> bool -> bool) -> bool = fun f -> f true false

let cand b1 b2 t f = b2 (b1 t f) f

let cor b1 b2 t f = b2 t (b1 t f)

let _ = 
  if cor ctrue ctrue ctrue cfalse |> bool_of_cbool then print_string "Hip hip hurra\n" else print_string "jest pegi 13 \n"
  
