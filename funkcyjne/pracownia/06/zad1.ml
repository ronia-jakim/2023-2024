type ('a, 'b) format = (string -> 'b) -> (string -> 'a)

(* (string -> 'a) -> (string -> (int -> 'a)) *)
let int (s_f : string -> 'a) : (string -> (int -> 'a))=
  let ret (s : string) (n : int) = s_f ( s ^ string_of_int( n ) ) 
  in ret 

(* (string -> 'a) -> (string -> string -> 'a) *)
let str (s_f : string -> 'a) : (string -> (string -> 'a)) = 
  let ret (s : string) (smth : string) = s_f ( s ^ smth )
  in ret

(* string -> ((string -> 'a) -> (string -> 'a)) *)
let lit (s : string) : ((string -> 'a) -> (string -> 'a)) = 
  let ret (s_l : string -> 'a) (s_r : string) = s_l (s_r ^ s) 
  in ret

  (* ('c 'a) format -> ('a, 'b) format -> (string -> 'b) *)
let (^^) (f : ('c, 'a) format) (s : ('a, 'b) format) (k : string -> 'b) : (string -> 'c) = f (s k)

(* ('a, 'b) format -> (string -> 'b) -> 'a *)
let ksprintf (f : ('a, 'b) format) (sb : string -> 'b) : 'a = f sb ""

(* ('a, string) format -> 'a *)
let sprintf (f : ('a, string) format) : 'a = ksprintf f (fun x -> x)

let _ = Printf.printf "%s\n" (sprintf( lit "Ala ma " ^^ int ^^ lit " kot" ^^ str ^^ lit ".") 5 "ów")
