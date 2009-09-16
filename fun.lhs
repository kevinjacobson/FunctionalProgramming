>       module Functions where
>	import Prelude hiding (take)

Examples, based on the talk by Rhys Price Jones and Jacob Rigby.
ats 12/2006

Some of the useful functions already exist in the Prelude.
To avoid a name clash some names in here have a trailing quote.

repeat' digit
returns an infinite list of the same digit
-- list construction (element : tail-list)
-- recursive function application (left-associative, high precedence)

>	repeat' n = n : repeat' n

add as bs
returns a list of the element-wise sum of two infinite lists
-- list patterns as parameters (car:cdr)
-- car/cdr pattern: act on first element, recurse on rest

>       add (a:as) (b:bs) = (a+b) : add as bs

ints
returns a list of all integers
-- function application, needs parentheses here

>       ints = 1 : add ints (repeat' 1)

take number-of-elements list
returns the first number-of-elements (or fewer) elements from the list
-- guards (header | condition = expression | ...)
-- empty list []
-- based off the Prelude take function

>       take n _  
>            | n <= 0 = []  -- Checks if the n is less than or equal to zero BEFORE evaluating the (x:xs) parameter
>       take _ []          = [] -- THEN Checks if the list parameter is empty
>       take n (x:xs)      = x : take (n-1) xs --FINALLY performs the "normal" functionality


odds
returns a list of all odd numbers
-- local definitions (definition where definition ...)

>	odds = sub evens (repeat' 1)
>	  where 
>	    evens = add ints ints
>           sub (a:as) (b:bs) = (a-b) : sub as bs

evens
returns a list of all even numbers

>       evens = add odds (repeat' 1)

fibs
returns a list of all Fibonacci numbers
-- local definitions (let definition ... in expression)
-- efficient solution

>	fibs =
>         let
>           f a b = a : f b (a+b)
>	  in
>           f 0 1

fac number
returns the factorial of a number
-- tail-recursive helper function
-- fac 30000 draws illegal instruction on hugs/G5, works in ghci/G5

>       fac n = f n 1
>         where
>           f 0 result = result
>           f n result = f (n-1) (n*result)

ack x y
returns the value of Ackermann's function
-- ack 0 0 through ack 3 4 is reasonable, others are not

>       ack 0 y = y + 1
>       ack x 0 = ack (x-1) 1
>       ack x y = ack (x-1) (ack x (y-1))

rats
returns a list of all rational numbers
-- enumerates diagonals of lattice: row/numerator, column/denominator
-- duplicates some
-- tuple (x, ...), heterogeneous, fixed length

>       rats = (1,1) : map next rats
>         where
>           next (n,1) = (1, (n+1))
>           next (n,m) = ((n+1), (m-1))

sieve list
returns the result of the Sieve of Erathostenes applied to a list
-- list comprehension: [expression | variable <- set, condition]
-- infix use of a function: `name`

>       sieve (p:x) = p : sieve [n | n <- x, n `mod` p > 0]

primes
returns the list of all primes
-- list pattern: [value, value ..]

>       primes = sieve [2..]

qsort list
returns sorted list
-- list concatenation (list ++ list)

>       qsort list =
>	  case list of
>	    [] -> []
>           (pivot:xs) -> qsort [x | x <- xs, x <= pivot]
>	                  ++ [pivot]
>	                  ++ qsort [x | x <- xs, x > pivot]

perms list
returns all permutations of a list
-- don't care parameter: _

>       perms [] = [[]]
>       perms s = 
>	    [x:y | x <- s, y <- perms (s `without` x)]
>         where
>           without [] _ = []
>           without (x:xs) y =
>	      if x == y then xs
>	      else x : (xs `without` y)

this version does not allow for repeated values

-	      if x == y then (xs `without` y)

queens n
returns a list of all lists placing n queens on a n by n board,
each list contains for each column the row where to place the queen
-- corrected from <http://cs.wwc.edu/KU/PR/Haskell.html>

>       queens n = place n
>         where

            place m
            returns all ways to place m of n queens on a m by n board
            -- performance is poor if generators are interchanged
            
>           place 0 = [[]]
>           place m = [ row:previous | previous <- place (m-1), row <- [1..n],
>                                      safe row previous 1 ]

            safe row (r:rs) i
            returns True if queen in row,1 does not collide with queens in r,i+1 ..
            
>           safe row [] _        = True -- no other queens
>           safe row (r:rs) i
>             | row == r         = False -- same row
>             | abs(row-r) == i  = False -- on same diagonal
>             | True             = safe row rs (i+1) -- depends on other columns

hanoi n
solves the Tower of Hanoi problem,
returns a list of pairs indicating the piles to move from and to  

>       hanoi n = f n 1 2 3
>         where
>           f 0 _ _ _ = []
>           f (n+1) from help to = f n from to help ++ [(from,to)] ++ f n help from to

factors n
returns the list of factors of a number, including 1
-- div does integer division

>       factors n = [i | i <- [1..n `div` 2], n `mod` i == 0]

perfects
returns the list of perfect numbers, i.e., n == sum of factors of n
-- anonymous function: \ pattern ... -> expression
-- from list where predicate: filter predicate list

>       perfects = filter (is_perfect) ints





perms' list
returns all permutations of a list
-- currying: function call with a missing parameter is a function

>       perms' [] = [[]]
>       perms' s = [ x:y | x <- s, y <- perms' (filter (x /=) s)]

pascal
returns a list of all rows of Pascal's triangle

>       pascal = f [1]
>         where
>           f row = row : (f.next) (0:row) -- collect rows
>           next (x:y:tail) = (x+y) : next (y:tail)
>           next [x] = [x]
