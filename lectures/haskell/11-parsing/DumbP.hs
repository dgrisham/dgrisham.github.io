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

majorVersion :: Parser String Int
majorVersion s = undefined

version1 :: Parser String Int
version1 s = undefined
