type formula = (* = TODO: tu wpisz swoją definicję *)
  | Zdanie of string
  | Falsz
  | Spojnik of formula * formula

let string_of_formula f =
  let rec ziom x czy_nawias = 
    match x with
    | Zdanie s -> s
    | Falsz -> "⊥"
    | Spojnik(a, b) -> 
        let wnetrznosci = (ziom a true) ^ " -> " ^ (ziom b false) in
        if czy_nawias then
          "[" ^ wnetrznosci ^ "]"
        else wnetrznosci
  in (ziom f false)
          
  (*** failwith "not implemented" *)

let pp_print_formula fmtr f =
  Format.pp_print_string fmtr (string_of_formula f)

type theorem = (* = TODO: tu wpisz swoją definicję *)
  | Bezdzietny of (formula list) * formula
  | Jedynak of (formula list) * formula * theorem
  | Blizniaki of (formula list) * formula * theorem * theorem
  | Adoptowany of (formula list) * formula * theorem

let assumptions thm =
  match thm with
  | Bezdzietny(l, f) -> l
  | Jedynak(l, f, t) -> l
  | Blizniaki(l, f, t1, t2) -> l
  | Adoptowany(l, f, t) -> l

let consequence thm =
  match thm with
  | Bezdzietny(l, f) -> f
  | Jedynak(l, f, t) -> f
  | Blizniaki(l, f, t1, t2) -> f
  | Adoptowany(l, f, t) -> f

let pp_print_theorem fmtr thm =
  let open Format in
  pp_open_hvbox fmtr 2;
  begin match assumptions thm with
  | [] -> ()
  | f :: fs ->
    pp_print_formula fmtr f;
    fs |> List.iter (fun f ->
      pp_print_string fmtr ",";
      pp_print_space fmtr ();
      pp_print_formula fmtr f);
    pp_print_space fmtr ()
  end;
  pp_open_hbox fmtr ();
  pp_print_string fmtr "⊢";
  pp_print_space fmtr ();
  pp_print_formula fmtr (consequence thm);
  pp_close_box fmtr ();
  pp_close_box fmtr ()

let by_assumption f =
  Bezdzietny([f], f)

let wywalanko lst x = 
  match lst with
  | [] -> []
  | a :: l ->
      if a == x then l else a :: l

let imp_i f thm =
  Jedynak((wywalanko (assumptions thm) f), Spojnik(f, consequence thm), thm)

let imp_e th1 th2 =
  let form1 = consequence th1 in
  let psi = consequence th2 in
    match form1 with
    | Spojnik(a, b) when b == psi -> Blizniaki(((assumptions th1) @ (assumptions th2)), psi, th1, th2)
    | _ -> failwith "error somewhere"
  (* Blizniaki((assumptions th1) @ (assumptions th2), *)

let bot_e f thm =
  Adoptowany((assumptions thm), f, Bezdzietny((assumptions thm), Falsz))
