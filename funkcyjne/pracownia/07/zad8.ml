type symbol = string 
type 'v term = 
  | Var of 'v 
  | Sym of symbol * 'v term list 

let return (x : 'a) : ('a term) = 
  Var x

let rec bind (x : 'a term) (f : 'a -> 'b term) : 'b term = 
  match x with 
  | Var y -> f y 
  | Sym (s, lst) -> 
      let ff (v : 'a term) : 'b term = bind v f in
      Sym (s, List.map ff lst)

(* podstawienie np w rownanie algebraiczne podstawiam cos za x, y, z *)
