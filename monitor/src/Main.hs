module Main where

import Data.Array
import System.Process
import System.Environment
import Control.Monad
import Text.Regex.Base
import Text.Regex

main :: IO ()
main = alter
main = do
  count <- read <$> getEnv "MONITOR_PING_COUNT" :: IO Int
  influx <- getEnv "MONITOR_INFLUXDB_ADDR"
  results <- map (\ y -> ping y count) <$> getArgs
  let resultStr = map (\ y -> show <$> y) results
  let str = unlines <$> sequence resultStr
  str >>= putStrLn

ping :: String -> Int -> IO (Maybe Float, Maybe Float)
ping target count = do
  (err, msg, _) <- readProcessWithExitCode "ping" ["-c", show count, target] ""
  let lossPtn = mkRegex "packets received, (.+)% packet loss"
  let latencyPtn = mkRegex "round-trip min\\/avg\\/max\\/stddev = (.+)\\/(.+)\\/(.+)\\/(.+) ms"
  let lossSub = head <$> matchRegex lossPtn msg
  let latencySub = head <$> matchRegex latencyPtn msg
  let loss = read <$> (lossSub :: Maybe String) :: Maybe Float
  let latency = read <$> (latencySub :: Maybe String) :: Maybe Float
  return (loss, latency)

