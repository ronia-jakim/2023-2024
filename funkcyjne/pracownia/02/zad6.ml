(*** Zdefiniuj funkcję zwracającą listę wszystkich permutacji zadanej listy. Można zrobić to na dwa istotnie różne sposoby: przez wybieranie i przez wstawianie. Czy potrafisz zaimplementować każdy z nich? 

 ~ NIE 
 *)

(*** Plan jest taki, że będę przechodzić po całej liście i brać sobie element i wrzucać go do wszystkich innych miejsc w permutacjach na "ogonie" od tego miejsca na którym trzymamy palec *)

(*** Zaczynam od funkcji, która będzie wrzucać element na wszystki możliwe miejsca *)

let rec make_mess a lst = 
  match lst with
  | [] -> [[a]]
  | b :: l -> 
      (a :: lst) :: (List.map (fun an -> b :: an) (make_mess a l))

let rec permutacje lst = 
  match lst with
  | [] -> [[]]
  | h :: l ->
      List.flatten (List.map (make_mess h) (permutacje l)) (*** make_mess będzie wyrzucać dla każdego elementu permutacje l listę list, a my chcemy zgubić jedną z tych list - stąd List.flatten *)



let test_list = [0 ; 1 ; 2 ; 3]

let list_helper ll = 
  Printf.printf "[ ";
  List.iter (Printf.printf "%d ") ll;
  Printf.printf "]\n"

let _ =
  Printf.printf "Testuję bałaganienie:\n";
  List.iter list_helper (make_mess 69 test_list);
  Printf.printf "\n\n";

  let perm = (permutacje test_list) in 
  Printf.printf "W permutacji wyszło mi %d elementów\n" (List.length perm);
  List.iter list_helper perm;
  Printf.printf "\n"
