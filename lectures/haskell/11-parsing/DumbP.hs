import Data.Char (isDigit)
import Data.List
import Data.Maybe

type Parser s a = s -> Maybe (a,s)

string :: String -> Parser String String
string pat input =
  case stripPrefix pat input of
    Nothing   -> Nothing
    Just rest -> Just (pat, rest)

number :: Parser String Int
number s =
  case reads digitStr of
    [(n, _)] -> Just (n, rest)
    _        -> Nothing
  where (digitStr, rest) = span isDigit s

-- Exercise 1: Using the `string` and `number` parsers above, write a parser
-- that does the following:
-- > majorVersion "HTTP/1"
-- Just (1,"")
-- > majorVersion "HTTP/1.1"
-- Just (1,".1")

majorVersion :: Parser String Int
majorVersion s =
  case string "HTTP/" s of
    Nothing -> Nothing
    Just (_, rest) ->
      case number rest of
        Nothing -> Nothing
        Just (maj, rest2) -> Just (maj, rest2)











versionDumb :: Parser String (Int, Int)
versionDumb s =
  case string "HTTP/" s of
    Nothing -> Nothing
    Just (_, rest0) ->
      case number rest0 of
        Nothing -> Nothing
        Just (maj, rest1) -> Just (maj, rest1)
        case string "." rest1 of
          Nothing -> Nothing
          Just (_, rest2) ->
            case number rest2 of
              Nothing -> Nothing
              Just (minor, rest3) -> Just ((major, minor), rest3)

case parser s of
  Nothing -> Nothing
  Just (result, rest) -> case parser2 rest of ....

andThen :: Parser s a -> (a -> Parser s b) -> Parser s b
andThen parse next = \input ->
  case parse input of
    Nothing -> Nothing
    Just (x, rest) -> next x rest

stuff :: a -> Parser s a
stuff x = \input -> Just (x, input)
