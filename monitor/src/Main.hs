module Main where

import Data.Array
import System.Process
import Control.Monad
import Text.Regex.Base
import Text.Regex

main :: IO ()
main = do
  let count = 1
  let target = "192.168.1.1"
--  rst <- ping "192.168.1.1" 1
--  print rst
--
--ping :: String -> Int -> (Maybe Float, Maybe Float)
--ping target count = do
  (err, msg, _) <- readProcessWithExitCode "ping" ["-c", show count, target] ""
  let lossPtn = mkRegex "packets received, (.+)% packet loss"
  let latencyPtn = mkRegex "round-trip min\\/avg\\/max\\/stddev = (.+)\\/(.+)\\/(.+)\\/(.+) ms"
  let lossSub = head <$> matchRegex lossPtn msg
  let latencySub = head <$> matchRegex latencyPtn msg
  let loss = read <$> (lossSub :: Maybe String) :: Maybe Float
  let latency = read <$> (latencySub :: Maybe String) :: Maybe Float
  print latency

