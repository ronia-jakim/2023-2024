module Make(State : sig type t end) : sig
  type 'a t 
  val return : 'a -> 'a t 
  val bind   : 'a t -> ('a -> 'b t) -> 'b t 
  val fail   : 'a t 
  val flip   : bool t 
  val get    : State.t t 
  val put    : State.t -> unit t 
  val run    : State.t -> 'a t -> 'a Seq.t
end = struct 
  type 'a t = State.t -> ('a * State.t) Seq.t

  let return (a : 'a) : 'a t = 
    let r (s : State.t) = List.to_seq [ (a, s) ] 
    in r

  let bind (a : 'a t) (f : 'a -> 'b t) : 'b t = 
    let helping_hand (x : 'a * State.t) = 
      (f (fst x)) (snd x)
    in
    let r (s : State.t) = 
       Seq.flat_map helping_hand (a s) 
    in r

  let fail = fun s -> Seq.empty

  let flip = fun s -> List.to_seq [(true, s); (false, s)]

  let run (s : State.t) (a : 'a t) = Seq.map (fun (a, x) -> a) (a s)

  let get (s : State.t) = List.to_seq [(s, s)]

  let put (s : State.t) = 
    let ziom (r : State.t) = List.to_seq [((), s)]
    in ziom
end
