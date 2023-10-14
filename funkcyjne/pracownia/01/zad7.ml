let zero f x = x

let succ prev f x = f (prev f x)

(*** dodawanie to tak jakby złożenie tych dwóch funkcji-liczb? bo tak dziala skladanie poteg :v *)
let add num1 num2 f x = num2 f (num1 f x)

(*** w mnożeniu chce zamienic f na to co wyjdzie z jednej z liczb? wtedy n-razy zrobie f^m *)
(*** num1 przyjmuje albo dwie rzeczy: funkcje i cos, albo przyjmuje tylko funkcje i zwraca funkcje, wiec chyba moge zrobic (num1 f) zeby zwrocic f podniosione do potegi num1 *)
let mul num1 num2 f x = num2 (num1 f) x

let ctrue : 'a -> 'a -> 'a = fun a b -> a

let cfalse : 'a -> 'a -> 'a = fun a b -> b

(*** nie mam pojecia jak bardzo to bedzie niewydajne patrzac na to jak wyglada succ, ale no kiedys false powienien sie zwrocic :v *)
let is_zero num = num (fun x -> cfalse) ctrue

let rec cnum_of_int n f x = 
  if n == 0 then x
  else f (cnum_of_int (n-1) f x)

let int_of_cnum cnum = cnum ((fun x -> x+1) 0)

let plus1 x = x + 1


