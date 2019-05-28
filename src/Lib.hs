module Lib
    ( someFunc
    ) where

import System.Environment (getArgs)
import System.IO


dispatch :: [(String, [String] -> IO ())]
dispatch =  [("write", write)
            ,("sharpen", sharpen)
            ,("clear", clear)
            ]

someFunc :: IO ()
someFunc = do
  (command:args) <- getArgs
  let (Just action) = lookup command dispatch
  action args


write :: [String] -> IO ()
write [desiredText] = do
    pencilDat <- readFile "pencil.dat"
    let pencil = Pencil $ read pencilDat
        (newPencil, textToWrite) = calcText pencil desiredText
    appendFile "paper.txt" textToWrite
    writeFile "pencil.dat" (show (sharpness newPencil))
    thePaper <- readFile "paper.txt"
    putStrLn ("the paper:\n\n" ++ thePaper)


data Pencil = Pencil { sharpness :: Int } deriving (Show)


calcText :: Pencil -> String -> (Pencil, String)
calcText pencil text =
  let
    writeLength = min (sharpness pencil) (length text)
    textToWrite = take writeLength text
    updatedPencil = Pencil $ (sharpness pencil) - writeLength
  in (updatedPencil, textToWrite)


sharpen :: [String] -> IO ()
sharpen _ = do
  writeFile "pencil.dat" "100"
  putStrLn "pencil sharpened"



clear :: [String] -> IO ()
clear _ = do
  writeFile "paper.txt" ""
  putStrLn "all cleared"