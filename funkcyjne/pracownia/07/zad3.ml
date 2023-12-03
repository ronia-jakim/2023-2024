type 'a t = 'a 

let return (x : 'a) : 'a t = x

let bind (x : 'a t) (f : 'a -> 'b t) : 
  'b t = f x



type 'a r = unit -> 'a 

let reutrn (x : 'a) : 'a r = fun (y : unit) -> x 

let bind (x : 'a r) (f : 'a -> 'b r) : 'b r = f (x ())
