{-# LANGUAGE OverloadedStrings #-}

import Data.Vector as V (toList)
import Data.HashMap.Strict as HM (toList)
import Data.Aeson
import Data.Aeson.Types
import Data.Bool (bool)
import Data.Scientific (formatScientific, FPFormat (Fixed))
import Data.Text (unpack)
import qualified Data.ByteString.Lazy as LBS

main :: IO ()
main = do
    jsonStr <- LBS.getContents
    putStrLn $ jsonToPHP $ decode jsonStr

jsonToPHP :: Maybe Value -> String
jsonToPHP (Just x) = phpValue 0 x
jsonToPHP Nothing = "ERROR"

phpValue :: Int -> Value -> String
phpValue d (String v) = "\'" ++ unpack v ++ "\'"
phpValue d (Number v) = (formatScientific Fixed (Just 0) v) -- may break for complex num formats
phpValue d (Bool v) = bool "false" "true" v
phpValue d Null = "null"
phpValue d (Object v) = "[" ++ (ovals (d+1) v) ++ (itemIndent d) ++ "]"
phpValue d (Array v) = "[" ++ (vals (d+1) v) ++ (itemIndent d) ++ "]"

vals :: Int -> Array -> String
vals depth x = concatMap (sings depth) $ V.toList x

ovals :: Int -> Object -> String
ovals depth x = concatMap (tupes depth) $ HM.toList x

sings :: Int -> Value -> String
sings depth v = (itemIndent depth) ++ (phpValue depth v) ++ ","

tupes :: Int -> Pair -> String
tupes depth (k, v) = (itemIndent depth) ++ "'" ++ (unpack k) ++ "' => " ++ (phpValue depth v) ++ ","

itemIndent :: Int -> String
itemIndent depth = "\n" ++ (concat $ replicate depth "    ")
