module type RandomMonad = sig 
  type 'a t 
  val return : 'a -> 'a t 
  val bind   : 'a t -> ('a -> 'b t) -> 'b t 
  val random : int t 
end 

type 'a t = int -> 'a * int 
    
let return x = fun y -> (x, y) 

let bind x f = fun y -> f (fst (x y))

let bi ai = 16807 * (ai mod 127773) - 2836 * (ai / 127773)

let random_from_seed seed = 
  let b = bi seed in 
  if b <= 0 then b + 2147483647 
  else b

let random (n : int) : int * int = 
  (random_from_seed n, random_from_seed n)

let run (seed : int) (f : int -> 'a * int) : 'a = 
  fst (f seed)
