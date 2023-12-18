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
    Just y -> WriteS (checkUpper y) (myToLower) 
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
    -- ReadS f -> getChar >>= runIOStreamTrans . f . Just

main = do
  runIOStreamTrans myToLower

