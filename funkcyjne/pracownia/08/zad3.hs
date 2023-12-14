import Data.Char
import System.IO (isEOF)

data StreamTrans i o a 
  = Return a 
  | ReadS (Maybe i -> StreamTrans i o a) 
  | WriteS o (StreamTrans i o a)

checkUpper l = 
  if (ord l) > 64 && (ord l) < 91
  then
    chr ((ord l) + 32)
  else 
  l

myToLower :: StreamTrans Char Char a 
myToLower = ReadS (
  \x -> case x of 
    Just y -> WriteS (checkUpper y) myToLower 
    Nothing -> myToLower
  )

runIOStreamTrans :: StreamTrans Char Char a -> IO a 
runIOStreamTrans stream =
  case stream of 
    Return a -> return a 
    WriteS val cont -> do
      putChar val
      runIOStreamTrans cont 
    ReadS f -> do
      e <- isEOF 
      if e
      then 
        runIOStreamTrans (f Nothing) 
      else do
        x <- getChar 
        runIOStreamTrans $ f (Just x)


listTrans :: StreamTrans i o a -> [i] -> ([o], a)
listTrans stream lst = 
  case (stream, lst) of 
    -- miało być Return, więc zwróćmy obojętnie jaką listę i ten element który chcemy returnować
    ( Return a, _ ) -> 
      ( [], a )
    -- mamy wypisać o i kontynuować, czyli wywołać listTrans na ogonku t oraz is 
    ( WriteS o t, is ) -> (o : ll, a) 
      where (ll, a) = listTrans t is 
    -- chcemy coś wyczytać z listy, ale tak troszkę jest ona pusta, więc przerywamy obliczenia
    ( ReadS f, [] ) -> listTrans (f Nothing) [] 
    -- teraz chcemy coś wyczytać, więc wyczytujemy to co nam mówi f i kontynuujemy na ogonku listy
    ( ReadS f, x : ll ) -> listTrans (f (Just x)) ll 

abc = take 3 $ fst $ listTrans myToLower ['A' ..]

main = do
  putStrLn abc
