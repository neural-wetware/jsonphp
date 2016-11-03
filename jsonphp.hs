{-# LANGUAGE OverloadedStrings #-}

import Data.Vector (toList)
import Data.Aeson
import Data.List
import Data.ByteString.Lazy.UTF8 (fromString) 

main :: IO ()
main = do
        print $ xxx (decode jsonStr2 :: Maybe Value)

xxx :: Maybe Value -> String
xxx (Just x) = phpValue x
xxx Nothing = "ERROR"

jsonStr = fromString "[{\"x\": 123, \"name\": \"John\", \"age\": 20}, {\"age\": 30, \"name\": \"Frank\"} ]"

jsonStr2 = fromString "[\"foo\", 55]"

phpValue :: Value -> String
phpValue (String v) = show v
phpValue (Number v) = show v
--phpValue (Object v) = 
phpValue (Array v) = "[" ++ (vals v) ++ "]"


vals :: Array -> String
vals x = intercalate ", " $ map phpValue $ toList x
