open Zad3

let ptkA = imp_i (Zdanie "p") (by_assumption (Zdanie "p"))
(*
  ⊢ p -> p   
*)


let ptkB = imp_i (Zdanie "p") 
                  (imp_i (Zdanie "q") 
                      (by_assumption (Zdanie "r"))
                  )
(*
  ⊢ p -> q -> p   
*)


let ptkC = imp_i (Spojnik ((Spojnik ((Zdanie "p"), (Zdanie "q"))), (Zdanie "r")))
                  (imp_i (Spojnik ( (Zdanie "p"), (Zdanie "q") )) 
                    (imp_i (Zdanie "p") (by_assumption (Zdanie "r")) )
                  )

(*
  ⊢ (p -> q -> r) -> (p -> q)  -> p  -> r
 *)


let ptkD = imp_i Falsz 
            (bot_e (Zdanie "p") (by_assumption Falsz))

(*
  ⊢ ⊥ -> p   
*)

let _ =  
  pp_print_theorem Format.std_formatter ptkC;
