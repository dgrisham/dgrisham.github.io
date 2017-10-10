--- Data Types
--- ==========

--- Simple Data Declaration
--- -----------------------


data Bool' = True' | False'
    deriving (Show, Eq)



true :: Bool'
true = True'

false :: Bool'
false = False'


--- ### `not`


not :: Bool' -> Bool'
not True'  = False'
not False' = True'


--- ### `and`


and :: Bool' -> Bool' -> Bool'
and True'  True'  = True'
and _     _       = False'


--- ### `or`


or :: Bool' -> Bool' -> Bool'
or False'  False'  = False'
or _     _         = True'


--- ### `xor`


xor :: Bool' -> Bool' -> Bool'
xor b1 b2
    | b1 == b2  = True'
    | otherwise = False'


--- Data Type with Parameters
--- -------------------------


data Person = Person Name Age
    deriving Show
type Name = String
type Age = Int



bigL = Person "Lamont Coleman" 24


--- ### Question


bob = Person "Bob" 50

trueIfBob50 :: Person -> Bool
trueIfBob50 (Person "Bob" 50) = True
trueIfBob50 (Person _     _ ) = False

trueIfBob :: Person -> Bool
trueIfBob (Person "Bob" _) = True
trueIfBob (Person _     _) = False

trueIfOld :: Person -> Bool
trueIfOld (Person _ age) = age > 24

trueIfOldBob :: Person -> Bool
trueIfOldBob (Person "Bob" age) = age > 24
trueIfOldBob (Person _     _  ) = False

-- `head` returns first element of string/list
firstInitial :: Person -> Char
firstInitial (Person name _) = head name


--- ### Tuples vs. Data Constructors

--- ### Type Synonym Example


data Point = Point Coordinate Coordinate

type Coordinate = Float



getX, getY :: Point -> Coordinate
getX (Point x _) = x
getY (Point _ y) = y


--- Recursive Data Types: Peano Numbers
--- -----------------------------------


data Peano = Zero | Succ Peano


--- ### Question {#question-2}


zero = Zero


--- ### Question {#question-3}

--- ### Increment/decrement functions


increment :: Peano -> Peano
increment p = Succ p



decrement :: Peano -> Peano
decrement (Succ p) = p
decrement Zero     = Zero

