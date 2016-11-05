{-# LANGUAGE OverloadedStrings #-}

import Data.Vector as V (toList)
import Data.HashMap.Strict as HM (toList)
import Data.Aeson
import Data.Text (Text)
import Data.List
import Data.ByteString.Lazy.UTF8 (fromString) 

main :: IO ()
main = do
        putStr $ xxx (decode jsonStr :: Maybe Value)

xxx :: Maybe Value -> String
xxx (Just x) = phpValue 0 x
xxx Nothing = "ERROR"

jsonStr = fromString "[44, {\"x\": 123, \"name\": \"John\", \"age\": 20}, {\"age\": 30, \"name\": \"Frank\"} ]"

jsonStr2 = fromString "[\"foo\", 55]"

phpValue :: Int -> Value -> String
phpValue d (String v) = show v
phpValue d (Number v) = show v
-- phpValue d (Bool v) = show v
-- phpValue d Null = show v
phpValue d (Object v) = "[" ++ (ovals (d+1) v) ++ (itemIndent d) ++ "]"
phpValue d (Array v) = "[" ++ (vals (d+1) v) ++ (itemIndent d) ++ "]"

vals :: Int -> Array -> String
vals depth x = concat $ map (sings depth) $ V.toList x

ovals :: Int -> Object -> String
ovals depth x = concat $ map (tupes depth) $ HM.toList x

sings :: Int -> Value -> String
sings depth v = (itemIndent depth) ++ (phpValue depth v) ++ ","

tupes :: Int -> (Text, Value) -> String
tupes depth (k, v) = (itemIndent depth) ++ show k ++ " => " ++ (phpValue depth v) ++ ","

itemIndent :: Int -> String
itemIndent depth = "\n" ++ (concat $ replicate depth "    ")
