module Lib
    ( someFunc
    ) where

import System.Environment (getArgs)
import System.IO


dispatch :: [(String, [String] -> IO ())]
dispatch =  [ ("write", write)
            ]

someFunc :: IO ()
someFunc = do
  (command:args) <- getArgs
  let (Just action) = lookup command dispatch
  action args


write :: [String] -> IO ()
write _ = putStrLn "sa dude"