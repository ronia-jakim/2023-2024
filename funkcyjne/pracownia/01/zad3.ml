(*** ptk 1: hd, tl - funkcje zwracające odpowiednio głowę i ogon strumienia*)
let rec fibb n = if n <= 1 then 1 else fibb (n-1) + fibb (n-2);;

let hd s = s 0 
