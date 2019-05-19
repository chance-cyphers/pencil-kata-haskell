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
write [text] = do
  pencilDat <- readFile "pencil.dat"
  let sharpness = read pencilDat - 1
  if sharpness > 0 then
    do
      appendFile "paper.txt" text
      thePaper <- readFile "paper.txt"
      putStrLn ("the paper:\n\n" ++ thePaper)
    else
      putStrLn "not enough sharp"



sharpen :: [String] -> IO ()
sharpen _ = do
  writeFile "pencil.dat" "100"
  putStrLn "pencil sharpened"



clear :: [String] -> IO ()
clear _ = do
  writeFile "paper.txt" ""
  putStrLn "all cleared"