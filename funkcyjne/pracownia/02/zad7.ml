type tree =
  | Leaf
  | Node of int * tree * tree * int

let ptkA x t1 t2 =
  match t1 with
  | Leaf ->
      begin
        match t2 with
        | Leaf -> Node(1, t1, t2, x)
        | Node(d, _, _, _) -> Node((d+1), t2, t1, x)
      end
  | Node(d, _, _, _) ->
      begin
        match t2 with
        | Leaf -> Node((d+1), t1, t2, x)
        | Node(l, _, _, _) ->
            if d < l then
              Node((l+1), t2, t1, x)
            else
              Node((d+1), t1, t2, x)
      end

let rec ptkB t1 t2 =
  match t1, t2 with
  | Leaf, Leaf -> Leaf
  | Leaf, _ -> t2
  | _, Leaf -> t1
  | Node(d1, l1, r1, x1), Node(d2, l2, r2, x2) ->
      if x1 < x2 then
        ptkA x1 l1 (ptkB r1 t2)
      else
        ptkA x2 l2 (ptkB r2 t1)

let ptkC a t =
  ptkB (Node(0, Leaf, Leaf, a)) t

let ptkDupa t = 
  match t with
  | Leaf -> Leaf
  | Node(d, l, r, x) -> ptkB l r

(*** ZADANIE 8 *)

type t = tree

let dodaj_na_kolejke x t =
  ptkC x t

let wez_daj_minimum t =
  match t with
  | Leaf -> None
  | Node(_, _, _, x) -> Some x

let wyrzuc_smieci t =
  match t with
  | Leaf -> t
  | Node(_, l, r, _) -> ptkB l r

let czy_pustak t =
  match t with
  | Leaf -> true
  | Node(_, _, _, _) -> false

let pustak = Leaf
