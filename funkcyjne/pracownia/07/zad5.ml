module BT : sig
  type 'a t

  val return : 'a -> 'a t
  val bind   : 'a t -> ('a -> 'b t) -> 'b t

  (** Brak wyniku *)
  val fail : 'a t
  (** Niedeterministyczny wybór -- zwraca true, a potem false *)
  val flip : bool t

  val run : 'a t -> 'a Seq.t
end = struct
  (* Obliczenie typu 'a to leniwa lista wszystkich możliwych wyników *)
  type 'a t = 'a Seq.t

  let return x = List.to_seq [ x ]
  let rec bind m f = Seq.flat_map f m

  let fail = Seq.empty
  let flip = List.to_seq [ true; false ]

  let run m = m
end

(* ========================================================================= *)
(* Przykładowy kod wykorzystujący monadę BT -- znajdowanie wszystkich trójek *)
(* pitagorejskich                                                            *)
(* ========================================================================= *)
let (let* ) = BT.bind

type 'a regexp = 
  | Eps 
  | Lit  of ('a -> bool) 
  | Or   of 'a regexp * 'a regexp 
  | Cat  of 'a regexp * 'a regexp 
  | Star of 'a regexp 

let ( +% ) r1 r2 = Or(r1, r2) 
let ( *% ) r1 r2 = Cat(r1, r2)

let append a b = 
  let* c = BT.flip in 
  if c then a 
  else b

let rec match_regexp (exp : 'a regexp) (lst : 'a list) : ('a list option BT.t) = 
  match exp with 
  | Eps -> BT.return None
  | Lit p -> 
      begin match lst with 
      | [] -> BT.fail 
      | a :: ll -> if p a 
                    then BT.return (Some ll) 
                    else BT.fail
      end 
  | Or (a, b) -> 
      append (match_regexp a lst) (match_regexp b lst) 
  | Cat (a, b) -> 
      begin 
        let* beg = match_regexp a lst in 
        match beg with 
        | None -> match_regexp b lst 
        | Some ll -> 
            let* suff = match_regexp b ll in 
            BT.return (
              match suff with 
              | None -> Some ll 
              | Some llst -> Some llst
            )
      end
  | Star a -> 
      let* h = match_regexp (Or (a, Eps)) lst in 
      begin match h with 
      | None -> BT.return None 
      | Some ll -> append (match_regexp (Star a) ll) (BT.return (Some ll))
      end

let kolejna_warstwa (lst : char list option) =
  match lst with 
  | None -> Printf.printf " "
  | Some x -> List.iter (Printf.printf "%c \n") x 
  

let best_debug (lst : char list option BT.t) = 
  let rec dd (ziom : char list option list) = 
    match ziom with 
    | [] -> Printf.printf "\n"
    | a :: ll -> 
        kolejna_warstwa a;
        dd ll
  in dd (List.of_seq (BT.run lst))


let p = Star (Star (Lit ((<>) 'b')) +% (Lit ((=) 'b') *% Lit ((=) 'a')))
let z = match_regexp p ['w';'e';'l';'a';'b';'a';'b';'e';'s']

let str_to_list str = 
  let rec loooooop i upper = 
    if i == upper then 
      [] 
    else 
      (String.get str i) :: (loooooop (i + 1) upper)
  in 
  loooooop 0 (String.length str)

let _ = 
  let test = str_to_list "Welesik" in 
  List.iter (Printf.printf "%c ") test;
  Printf.printf "\n";
  best_debug z;
  Printf.printf "\n"
