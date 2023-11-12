open Logic


type goal =
  {f : formula; a : (string * formula) list}

type proof_tree =
  | Goal of goal
  | Lemat of theorem
  | ImpI of {a : (string * formula) list; f : formula; x : proof_tree}
  | ImpE of {a : (string * formula) list; f : formula; x : proof_tree; y : proof_tree}
  | NegE of {a : (string * formula) list; f : formula; x : proof_tree}

type context = 
  | Root
  | NegEc  of {a : (string * formula) list; f : formula; ctx : context }
  | ImpEyc of {a : (string * formula) list; f : formula; x : proof_tree; ctx : context }
  | ImpExc of {a : (string * formula) list; f : formula; y : proof_tree; ctx : context }
  | ImpIc of   {a : (string * formula) list; f : formula; ctx : context }
  

let up_ctx (pt : proof_tree) (ctx : context) =
  match ctx with
  | Root -> (pt, ctx)
  | NegEc {a; f; ctx} -> NegE {a; f; x = pt}, ctx
  | ImpIc {a; f; ctx} -> ImpI {a; f; x = pt}, ctx
  | ImpExc {a; f; y; ctx} -> ImpE {a; f; x = pt; y}, ctx
  | ImpEyc {a; f; x; ctx} -> ImpE {a; f; x; y = pt}, ctx
type proof = 
  | Comp of theorem
  | Proof of context * goal

let proof g f =
  let g = {f = f; a = g} in
    Proof (Root , g)

let qed pf =
  match pf with
  | Comp th -> th
  | Proof _ -> failwith "nadal są dziurki"
  
let goal pf =
  match pf with
  | Comp _ -> None
  | Proof (_, {f; a}) -> Some (a, f)

let rec down_left (pt : proof_tree) (ctx : context) = 
  match pt with
  | Goal g -> Proof (ctx, g)
  | Lemat _ -> failwith "cos nie tak"
  | ImpI {a; f; x} -> down_left x  (ImpIc {a; f; ctx})
  | NegE {a; f; x} -> down_left x (NegEc {a; f; ctx})
  | ImpE {a; f; x; y} ->
    match x with 
    | Lemat _ -> down_left y (ImpEyc {a; f; x; ctx})
    | _ -> down_left x (ImpExc {a; f; y; ctx})

let rec up_right (pt : proof_tree) (ctx : context) =
  match ctx with
  | Root -> down_left pt ctx
  | NegEc {a; f; ctx} -> up_right (NegE {a; f; x = pt}) ctx
  | ImpIc {a; f; ctx} -> up_right (ImpI {a; f; x = pt}) ctx 
  | ImpEyc {a; f; x; ctx} -> up_right (ImpE {a; f; x; y = pt}) ctx
  | ImpExc {a; f; y; ctx} -> 
    match y with
    | Lemat _ -> up_right (ImpE {a; f; x = pt; y}) ctx
    | _ -> down_left y (ImpEyc {a; f; x = pt; ctx})

let next (pf : proof) =
  match pf with
  | Comp _ -> failwith "super dowód"
  | Proof (ctx, g) -> up_right (Goal g) ctx 

let intro name pf =
  (* TODO: zaimplementuj *)
  failwith "not implemented"

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

