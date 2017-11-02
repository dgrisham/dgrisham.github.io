module Assignment3 where

import Data.List (sort)


--- Haskell -- Assignment 2
--- =======================

--- Problem 1 -- `map` and `filter`
--- -------------------------------


data Artist = Artist Name Genres
  deriving Show
type Name   = String
type Genres = [Genre]
type Genre  = String



band :: Artist
band = Artist "Talking Heads" ["New Wave", "Post Punk", "Pop Rock", "Funk Rock"]

artists :: [Artist]
artists = [
    Artist "Talking Heads" ["New Wave", "Post Punk", "Pop Rock", "Funk Rock"],
    Artist "Devin Townsend" ["Progressive Metal", "Ambient", "New Wave"],
    Artist "Brand New" ["Pop Punk", "Emo", "Alternative Rock", "Indie Rock"],
    Artist "Brian Eno" ["Art Rock", "Ambient", "Electronic"],
    Artist "The Front Bottoms" ["Indie Rock", "Folk Punk", "Anti-Folk"],
    Artist "Grimes" ["Electropop", "Dream Pop", "Synthpop"],
    Artist "My Bloody Valentine" ["Shoegaze", "Noise Pop", "Post Punk"],
    Artist "David Bowie" ["Art Rock", "Pop Rock", "Glam Rock", "New Wave"]
  ]


--- ### a. `getName`, `getGenres`

--- ### b. `getSortedNames`

--- ### c. `filterByGenre`


-- Problem 2 -- `$` and `.`
-- ------------------------

-- ### a. Function Application with `$`


-- ### b. Function Composition with `.`


-- Problem 3 -- `fold` Applications
-- --------------------------------


-- ### a. `totalDiscount`

-- ### b. `discountedItems`

