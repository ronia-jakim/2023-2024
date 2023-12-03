type var = string

type formula =
  | Top
  | Var of var
  | Not of formula
  | And of formula * formula

module type S = sig
  type 'a t

  val return : 'a -> 'a t
  val bind   : 'a t -> ('a -> 'b t) -> 'b t

  val lookup : var -> bool t

  val exists : bool t -> bool
  val forall : bool t -> bool
end

(*

let* x = return e1 in e2   ==   let x = e1 in e2
let* x = e1 in return x    ==   e1

let* x = let* y = e1 in e2 in e3   ==  let* y = e1 in let* x = e2 in e3

*)

module Env : S = struct
  module VarMap = Map.Make(String)

  type ans = bool VarMap.t -> bool
  type 'a t = ('a -> ans) -> ans

  let return x cont = cont x
  let bind m f cont =
    m (fun x -> f x cont)

  let lookup x cont env =
    match VarMap.find_opt x env with
    | Some b -> cont b env
    | None   ->
      cont true  (VarMap.add x true  env) ||
      cont false (VarMap.add x false env)

  let exists c = c (fun b _ -> b) VarMap.empty
  let forall c = not (exists (fun cont -> c (fun b -> cont (not b))))
end

module F(Env : S) = struct
  let ( let* ) = Env.bind

  let rec eval f =
    match f with
    | Top   -> Env.return true
    | Var x -> Env.lookup x
    | Not f ->
      let* b = eval f in
      Env.return (not b)
    | And(f1, f2) ->
      let* b = eval f1 in
      if b then eval f2
      else Env.return false

  let sat   f = Env.exists (eval f)
  let tauto f = Env.forall (eval f)
end
include F(Env)
