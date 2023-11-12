open Logic

type cel = ((string * formula) list) * formula

type proof_tree = 
  | Fatality of theorem
  | Dziurka of cel 
  | OnlyChild of ((string * formula) list) * formula * proof_tree
  | Adopted of ((string * formula) list) * formula * proof_tree
  | Twins of ((string * formula) list) * formula * proof_tree * proof_tree

type context = 
  | Empty
  | AdoptedCtx of ((string * formula) list) * formula * context (* wartość ojca, context ojca *)
  | OnlyChildCtx of ((string * formula) list) * formula * context (* wartość ojca, context ojca *)
  | LeftTwix of ((string * formula) list) * formula * context * proof_tree (* wartość ojca, context ojca, prawy brat *)
  | RightTwix of ((string * formula) list) * formula * context * proof_tree (* wartość ojca, context ojca, lewy brat *)

type proof = 
  | Gotowe of theorem
  | Dziura of context * cel (* DODAĆ JAKIEŚ CONTEXT *)

(* = TODO: tu wpisz swoją definicję *)

let proof g f =
  Dziura (Empty , g)

let qed pf =
  match pf with
  | Gotowe t -> t 
  | Dziura (ctx, c) -> failwith "there are holes in your pockets"

let goal pf =
  match pf with
  | Gotowe t -> None 
  | Dziura (ctx, c) -> Some c




let rec look_down ctx t = 
  match t with
  | Fatality thm -> failwith "co tutaj skoro to jest już skończony dowód"
  | Dziurka c -> Dziura (ctx, c)
  | OnlyChild (l, form, tt) -> look_down (OnlyChildCtx(l, form, ctx) ) tt
  | Adopted(l, form, tt) -> look_down ( AdoptedCtx(l, form, ctx) ) tt 
  | Twins(l, form, tt1, tt2) ->
      match tt1 with
      | Fatality thm -> look_down ( LeftTwix(l, form, ctx, tt1) ) tt2
      | _ -> look_down ( RightTwix(l, form, ctx, tt2) ) tt1

let rec look_up ctx t =
  match ctx with
  | Empty ->  look_down ctx t (* failwith "nie wiem jeszcze" *)
  | AdoptedCtx (l, form, c) -> look_up c ( Adopted(l, form, t) )
  | OnlyChildCtx (l, form, c) -> look_up c ( OnlyChild(l, form, t) )
  | LeftTwix (l, form, c, tt) -> look_up c ( Twins(l, form, t, tt) )
  | RightTwix (l, form, c, tt) -> look_up c ( Twins(l, form, tt, t) )

let next pf =
  match pf with
  | Gotowe t -> failwith "you have a sturdy proof"
  | Dziura (ctx, c) -> 
      look_up ctx (Dziurka c)



let intro name pf =
  match pf with
  | Gotowe thm -> failwith "Ale to już jest pokazane?"
  | Dziura(ctx, (lista, form)) ->
      match form with 
      | Spojnik(a, b) -> Dziura( ( OnlyChildCtx(lista, form, ctx) ), ((name, a)::lista, b))
      | _ -> failwith "Mate you need an implication"
  (* TODO: zaimplementuj *)

let apply f pf =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let apply_thm thm pf =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let apply_assm name pf =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

let pp_print_proof fmtr pf =
  match goal pf with
  | None -> Format.pp_print_string fmtr "No more subgoals"
  | Some(g, f) ->
    Format.pp_open_vbox fmtr (-100);
    g |> List.iter (fun (name, f) ->
      Format.pp_print_cut fmtr ();
      Format.pp_open_hbox fmtr ();
      Format.pp_print_string fmtr name;
      Format.pp_print_string fmtr ":";
      Format.pp_print_space fmtr ();
      pp_print_formula fmtr f;
      Format.pp_close_box fmtr ());
    Format.pp_print_cut fmtr ();
    Format.pp_print_string fmtr (String.make 40 '=');
    Format.pp_print_cut fmtr ();
    pp_print_formula fmtr f;
    Format.pp_close_box fmtr ()

