type 'a zlist = 
  | Empty
  | Cursor of 'a list * 'a * 'a list

let of_list lst = 
  match lst with
  | [] -> Empty
  | a :: l -> Cursor([], a, l)

let to_list lst =
  match lst with
  | Empty -> []
  | Cursor(rhd, a, tl) -> (List.rev rhd) @ (a :: tl)

let elem lst =
  match lst with
  | Empty -> None
  | Cursor(rhd, a, tl) ->
      match tl with
      | [] -> None
      | b :: tll -> Some b

let move_left lst =
  match lst with
  | Empty -> Empty
  | Cursor(rhd, a, tl) -> 
      match rhd with
      | [] -> lst 
      | b :: hd -> Cursor (hd, b, a::tl)

let move_right lst =
  match lst with
  | Empty -> Empty
  | Cursor(rhd, a, tl) ->
      match tl with
      | [] -> lst
      | b :: hd -> Cursor(hd, b, (a::tl))

let insert x lst =
  match lst with 
  | Empty -> Cursor([], x, [])
  | Cursor(rhd, a, tl) -> 
      move_right (Cursor(a::rhd, x, tl))

let remove lst = 
  match lst with
  | Empty -> Empty
  | Cursor(rhd, a, tl) -> 
      match rhd with
      | [] -> lst
      | b :: hd ->
          Cursor(hd, a, tl)
