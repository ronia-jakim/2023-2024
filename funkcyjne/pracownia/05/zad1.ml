let rec fix_with_limit max_depth f x =
  if max_depth > 0 then 
    f (fix_with_limit (max_depth - 1) f) x
  else
    failwith "Za głęboko by się chciało"

let rec fix_memo f x = 
  let h = Hashtbl.create 69 in 
  let rec g y = 
    try Hashtbl.find h x 
    with Not_found -> let z = f g y in Hashtbl.add h y z; 
    z 
    in g x


let fibf_f fib n = 
  if n <= 1 then n 
  else fib (n-1) + fib (n-2) 

let _ = 
  Printf.printf "%d\n" (fix_with_limit 80 fibf_f 5);
  Printf.printf "%d\n" (fix_memo fibf_f 5);
  Printf.printf "%d\n" (fix_memo fibf_f 5)
