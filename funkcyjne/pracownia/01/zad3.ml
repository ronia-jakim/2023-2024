(*** ptk 1: hd, tl - funkcje zwracające odpowiednio głowę i ogon strumienia*)

let hd s = s 0

let tl s = let new_s x = s (x+1) in new_s

(*** add - funckja, która dla zadanego strumienia tworzy nowy strumień, którego każdy element jest większy o zadaną stałą od odpowiadającego mu elementu oryginalnego strumienia *)

let add s x = let new_s n = (s n) + x in new_s

(*** map - funkcja, która dla zadanego strumienia tworzy nowy strumień, którego każdy element jest wynikiem obliczenia zadanej funkcji dla argumentu będącego odpowiadającym mu elementem oryginalnego strumiena (tak, jak map dla list skończonych) *)

let map s f = let new_s n = f (s n) in new_s

(*** map2 - jak wyżej, ale dla podanej funkcji dwuargumentowej i dwóch strumieni, np. map2 (+) s1 s2 policzy sumę dwóch strumieni po współrzędnych *)

let map2 s1 s2 f = let new_s n = (f (s1 n)) (s2 n) in new_s

(*** replace -  funkcja, która dla zadanego indeksu n, wartosci a i strumienia s tworzy nowy strumień, w którym wszystkie wartości są takie jak w stumieniu s, oprócz n-tego elementu, któr ma wartość a *)

let replace n a s = let new_s k = if n == k then a else s k in new_s

(*** take_every - funkcja, która dla zadanego indeksu n i strumienia s tworzy nowy strumień złożony z co n-tego elementu strumienia s *)

let take_every n s = let new_s k = s (n * k) in new_s


(*** MOJE PRÓBY CZY DZIAŁA *)

let rec fibb n = if n <= 1 then 1 else fibb (n-1) + fibb (n-2);;

let rec even n = 2 * n;;

let power_two x = x * x;;

let _ = print_int (fibb 4); print_string " "; print_int (fibb 5); print_string "\n";
  print_int ((add fibb 3) 4); print_string " "; print_int ((add fibb 3) 5); print_string "\n";
  print_int ((map fibb power_two) 4); print_string " "; print_int ((map fibb power_two) 5); print_string "\n";

  print_int (fibb 4); print_string " "; print_int (even 4); print_string " "; print_int ((map2 fibb even (+)) 4); print_string "\n";

  print_int (fibb 3); print_string " "; print_int (fibb 4); print_string " "; print_int (fibb 5); print_string "\n";
  print_int ((replace 4 69 fibb) 3); print_string " "; print_int ((replace 4 69 fibb) 4); print_string " "; print_int ((replace 4 69 fibb) 5); print_string "\n";
  print_int ((take_every 2 fibb) 2); print_string "\n"
