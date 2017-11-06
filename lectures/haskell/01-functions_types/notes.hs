--- Expressions
--- ===========

--- Bindings
--- --------

--- ### Question 1


x :: Int
x = 3


--- Simple Function
--- ---------------


f :: Int -> Int
f x = x + 1


--- Multiple Arguments
--- ------------------

--- ### Question 3


add :: Int -> Int -> Int
add x y = x + y


--- Guards
--- ------

--- ### Question 4


max' :: Float -> Float -> Float
max' x y
    | x >= y = x
    | otherwise = y



m = max' 3.5 2.0 -- binds 3 to m, also binds `Float` type
n = max' 3.5 4.0 -- binds 4 to n, also binds `Float` type


--- Fibonacci
--- ---------


fib :: Int -> Int
fib n
    | (n == 0) || (n == 1) = 1
    | otherwise            = fib (n - 1) + fib (n - 2)



fib' :: Int -> Int
fib' 0 = 1
fib' 1 = 1
fib' n = fib (n - 1) + fib (n - 2)
