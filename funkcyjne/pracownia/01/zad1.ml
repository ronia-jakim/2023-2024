(*** napisz wyrażenie, które jest identycznością, ale które ma typ int -> int *)

let dupa_id x = x + 0

(*** (a -> b) -> (c -> a) -> c -> b *)
(*** przyjmuje funkcje a->b i zwraca funkcje, ktora przyjmuje funkcje c->a ktora zwraca funkcje c->b *)

let exA f g = let cmp x = f (g x) in cmp

(*** chuju muju lukasza *)
let compose f g x = f (g x)


(*** a -> b -> a *)
(*** funkcja przyjmuje cos i oddaje funkcje, ktora oddaje cos tego samego typu *)

let exB a = let newB b = a in newB

(*** a -> a -> a *)

let exC : 'a -> 'a -> 'a = fun a b -> b

let exC2 a b = if true then a else b
