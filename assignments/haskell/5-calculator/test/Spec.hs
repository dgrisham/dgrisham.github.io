module Main (main) where

-- Imports
-- =======

import Test.Hspec
import Test.QuickCheck
import qualified Data.HashMap.Strict as H

-- Local
-- -----

import Lib

-- Constants
-- =========

emptyEnv :: Env
emptyEnv = H.empty

testingEnv :: Env
testingEnv = H.fromList [ ("w", NumVal 6)
                        , ("x", NumVal 4.5)
                        , ("y", NumVal 3)
                        , ("z", NumVal 1.1)
                        ]

testingEnv' :: Env
testingEnv' = H.fromList [ ("n", NumVal 2)
                         , ("w", NumVal 6)
                         , ("x", NumVal 4.5)
                         , ("y", NumVal 3)
                         , ("z", NumVal 1.1)
                         ]

testingEnv'' :: Env
testingEnv'' = H.fromList [ ("n", NumVal 2)
                          , ("w", NumVal 6)
                          , ("x", NumVal 5)
                          , ("y", NumVal 3)
                          , ("z", NumVal 1.1)
                          ]

-- Tests
-- =====

main :: IO ()
main = do
  test_evaluator
  test_executor
  test_additional

-- Executor
-- --------

test_executor :: IO ()
test_executor = hspec $ describe "Testing statement evaluator" $ do
  describe "variable assignment" $
    it "check exec 'n := 2' adds to environment" $
      exec (SetStmt "n" (NumExpr 2)) testingEnv `shouldBe` testingEnv'

  describe "multiple variable assignment" $
    it "check exec 'w := 6; x := 4.5; y := 3; z := 1.1' updates env" $
      exec (SeqStmt [ SetStmt "w" (NumExpr 6)
                    , SetStmt "x" (NumExpr 4.5)
                    , SetStmt "y" (NumExpr 3)
                    , SetStmt "z" (NumExpr 1.1)
                    ])
        emptyEnv `shouldBe` testingEnv

  describe "change existing variable" $
    it "check exec 'x := 5' updates x" $
      exec (SetStmt "x" (NumExpr 5)) testingEnv' `shouldBe` testingEnv''

  describe "overlapping variable assignment" $
    it "check exec 'n := 1; n := 2' adds second val to environment" $
      exec (SeqStmt [ SetStmt "n" (NumExpr 1)
                    , SetStmt "n" (NumExpr 2)
                    ])
        testingEnv `shouldBe` testingEnv'

-- Evaluator
-- ---------

test_evaluator :: IO ()
test_evaluator = do
  test_addExpr
  test_subtractExpr
  test_multiplyExpr
  test_divideExpr
  test_numExpr
  test_constExpr
  test_varExpr

-- ### NumExpr

test_numExpr :: IO ()
test_numExpr = hspec $ describe "Testing evaluator on NumExpr" $ do
  describe "simple eval NumExpr" $
    it "eval (NumExpr 3.3) -> NumVal 3.3" $
      eval (NumExpr 3.3) emptyEnv `shouldBe` NumVal 3.3

-- ### ConstExpr

test_constExpr :: IO ()
test_constExpr = hspec $ describe "Testing evaluator on ConstExpr" $ do
  describe "simple eval ConstExpr" $
    it "eval (ConstExpr \"pi\") -> NumVal pi" $
      eval (ConstExpr "pi") emptyEnv `shouldBe` NumVal pi

  describe "adding two ConstExpr's" $
    it "eval 'pi + e'" $
      eval (AddExpr (ConstExpr "pi") (ConstExpr "e")) emptyEnv
        `shouldBe` NumVal (pi + exp 1)

  describe "undefined const" $
    it "eval (ConstExpr \"G\") -> ExnVal \"...\"" $
      eval (ConstExpr "G") emptyEnv
        `shouldBe` ExnVal "Constant G is not defined."

-- ### VarExpr

test_varExpr :: IO ()
test_varExpr = hspec $ describe "Testing evaluator on VarExpr" $ do
  describe "simple eval VarExpr" $
    it "eval (VarExpr \"x\") -> NumVal 4.5" $
      eval (VarExpr "x") testingEnv `shouldBe` NumVal 4.5

  describe "check addition between variable and constant" $
    it "eval 'x + 5' -> 9" $
      eval (AddExpr (VarExpr "x") (NumExpr 5)) testingEnv `shouldBe` NumVal 9.5

  describe "check division between variable and constant" $
    it "x / 3 -> 1.5" $
      eval (DivideExpr (VarExpr "x") (NumExpr 3)) testingEnv `shouldBe` NumVal 1.5

  describe "undefined variable name" $
    it "eval (VarExpr \"m\") -> ExnVal \"...\"" $
      eval (VarExpr "m") emptyEnv
        `shouldBe` ExnVal "Variable name m is not defined."

  describe "undefined variable in calculation" $
    it "eval 'm + 1' -> ExnVal \"...\""$
      eval (AddExpr (VarExpr "m") (NumExpr 1)) testingEnv
        `shouldBe` ExnVal "Cannot lift."

-- ### AddExpr

test_addExpr :: IO ()
test_addExpr = hspec $ describe "Testing evaluator on AddExpr" $ do
  describe "additive identity" $
    it "Quickcheck: eval 'x + 0' -> x" $
      property prop_additiveIdentity

  describe "check simple addition" $
    it "7.1 + 2 -> 9" $
      eval (AddExpr (NumExpr 7.1) (NumExpr 9)) emptyEnv `shouldBe` NumVal 16.1

  describe "check addition with small negative" $
    it "7.1 + (-2) -> 5" $
      eval (AddExpr (NumExpr 7.1) (NumExpr (-2))) emptyEnv `shouldBe` NumVal 5.1

  describe "check addition with large negative" $
    it "7.5 + (-10) -> 2.5" $
      eval (AddExpr (NumExpr 7.5) (NumExpr (-10))) emptyEnv `shouldBe` NumVal (-2.5)

-- ### SubtractExpr

test_subtractExpr :: IO ()
test_subtractExpr = hspec $ describe "Testing evaluator on SubtractExpr" $ do
  describe "additive identity (for subtraction)" $
    it "Quickcheck: eval 'x - 0' -> x" $
      property prop_subtractiveIdentity

  describe "check simple subtraction" $
    it "8 - 0.5 -> 7.5" $
      eval (SubtractExpr (NumExpr 8) (NumExpr 0.5)) emptyEnv `shouldBe` NumVal 7.5

  describe "check subtraction with negative" $
    it "8 - (-1) -> 9" $
      eval (SubtractExpr (NumExpr 8) (NumExpr (-1))) emptyEnv `shouldBe` NumVal 9

-- ### MultiplyExpr

test_multiplyExpr :: IO ()
test_multiplyExpr = hspec $ describe "Testing evaluator on MultiplyExpr" $ do
  describe "multiplicative identity" $
    it "Quickcheck: eval 'x * 1' -> x" $
      property prop_multiplicativeIdentity

  describe "check simple multiplication" $
    it "5 * 4 -> 20" $
      eval (MultiplyExpr (NumExpr 5) (NumExpr 4)) emptyEnv `shouldBe` NumVal 20

  describe "check multiplication with negative" $
    it "5 * (-4) -> (-20)" $
      eval (MultiplyExpr (NumExpr 5) (NumExpr (-4))) emptyEnv `shouldBe` NumVal (-20)

  describe "check multiplication with two negatives" $
    it "(-10) * (-4.5) -> 45" $
      eval (MultiplyExpr (NumExpr (-10)) (NumExpr (-4.5))) emptyEnv `shouldBe` NumVal 45

-- ### DivideExpr

test_divideExpr :: IO ()
test_divideExpr = hspec $ describe "Testing evaluator on DivideExpr" $ do
  describe "multiplicative identity (for division)" $
    it "Quickcheck: eval 'x / 1' -> x" $
      property prop_divideIdentity

  describe "check division by zero (1)" $
    it "5 / 0 -> ExnVal \"Division by zero.\"" $
      eval (DivideExpr (NumExpr 5) (NumExpr 0)) emptyEnv
        `shouldBe` ExnVal "Division by zero."

  describe "check division by zero (2)" $
    it "5 / (1 * 0)-> ExnVal \"Division by zero.\"" $
      eval (DivideExpr (NumExpr 5) (MultiplyExpr (NumExpr 1) (NumExpr 0)))
        emptyEnv `shouldBe` ExnVal "Division by zero."

  describe "check simple division" $
    it "6 / 3 -> " $
      eval (DivideExpr (NumExpr 6) (NumExpr 3)) emptyEnv `shouldBe` NumVal 2

  describe "check division by negative" $
    it "6 / (-3) -> (-2)" $
      eval (DivideExpr (NumExpr 6) (NumExpr (-3))) emptyEnv `shouldBe` NumVal (-2)

  describe "check division with two negatives" $
    it "(-10) / (-4) -> 2.5" $
      eval (DivideExpr (NumExpr (-10)) (NumExpr (-4))) emptyEnv `shouldBe` NumVal 2.5

-- ### Properties for QuickCheck tests

prop_additiveIdentity :: Float -> Bool
prop_additiveIdentity x =
  eval (AddExpr (NumExpr x) (NumExpr 0)) emptyEnv == NumVal x

prop_subtractiveIdentity :: Float -> Bool
prop_subtractiveIdentity x =
  eval (SubtractExpr (NumExpr x) (NumExpr 0)) emptyEnv == NumVal x

prop_multiplicativeIdentity :: Float -> Bool
prop_multiplicativeIdentity x =
  eval (MultiplyExpr (NumExpr x) (NumExpr 1)) emptyEnv == NumVal x

prop_divideIdentity :: Float -> Bool
prop_divideIdentity x =
  eval (DivideExpr (NumExpr x) (NumExpr 1)) emptyEnv == NumVal x

-- Additional Tests
-- ----------------

test_additional :: IO ()
test_additional = sequence_ additionalTests

-- Add any tests you want to include to the list additionalTests.

additionalTests :: [IO ()]
additionalTests = [ test_example ]

test_example :: IO ()
test_example = hspec $ describe "This test does nothing" $ do
  describe "" $
    it "" $
      True `shouldBe` True
