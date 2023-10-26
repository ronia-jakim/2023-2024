module type OrderedType = sig
  type t
  val compare : t -> t -> int 
end

module type S = sig 
  type key
  type t 
  
  val apply : t -> key -> key 

  val id : t 

  val invert : t -> t 

  val swap : key -> key -> t 

  val compose : t -> t -> t 

  val compare : t -> t -> int 

end

module Make(Key : OrderedType) : S with type key = Key.t
