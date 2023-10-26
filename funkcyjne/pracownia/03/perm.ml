module type OrderedType = sig 
  type t 
  val compare : t -> t -> int 
end

module Make(Key : OrderedType) = struct 
  type key = Key.t 
  module NazwaZDuzej = Map.Make(Key : OrderedType)
  type t = (key NazwaZDuzej.t) * (key NazwaZDuzej.t)

  let apply sigma n = 
    let (s1, s2) = sigma in 
    match NazwaZDuzej.find_opt n s1 with
      | None -> n
      | Some x -> x

  let id = (NazwaZDuzej.empty, NazwaZDuzej.empty)

  let invert sigma =
    let (s1, s2) = sigma in (s2, s1)

  let swap k n =
    ((NazwaZDuzej.add k n NazwaZDuzej.empty), (NazwaZDuzej.add n k NazwaZDuzej.empty))

  let compare sigma1 sigma2 = 
    let (a, c) = sigma1 in 
    let (b, d) = sigma2 in
    NazwaZDuzej.compare Key.compare a b

  let compose sigma1 sigma2 = 
    let (a, b) = sigma1 in 
    let (x, y) = sigma2 in 
    let new_comp cosiek k val1 val2 = 
      match val1, val2 with
      | None, None -> None 
      | None, _ -> val2
      | Some v1, _ -> 
          let ziom = (apply cosiek v1) in 
          if ziom == k then None 
          else Some ziom 
      in 
    ((NazwaZDuzej.merge (new_comp sigma2) a b), (NazwaZDuzej.merge (new_comp (invert sigma1)) y x))
end
