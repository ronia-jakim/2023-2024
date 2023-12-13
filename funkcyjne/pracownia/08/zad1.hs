import Data.Char

main = do
  echoLower
  putStrLn " "

checkUpper l = 
  if (ord l) > 64 && (ord l) < 91
  then
    chr ((ord l) + 32)
  else 
  l

echoLower :: IO () 
echoLower = do
  x <- getChar 
  putChar (checkUpper x)
  echoLower
