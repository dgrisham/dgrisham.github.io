module Main (main) where

-- Imports
-- =======

import Test.Hspec
import Test.QuickCheck
import qualified Data.HashMap.Strict as H

-- Local
-- -----

import Lib
import Parser

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

testingEnvFunc :: Env
testingEnvFunc = H.fromList [ ("f", CloVal [] (NumExpr 1) H.empty) ]

testingEnvFunc' :: Env
testingEnvFunc' = H.fromList [ ("f", CloVal ["x"] (VarExpr "x") H.empty) ]

testingEnvFunc'' :: Env
testingEnvFunc'' = H.fromList [ ("f", CloVal ["x", "y"] (AddExpr (VarExpr "x") (VarExpr "y")) H.empty) ]

-- Tests
-- =====

main :: IO ()
main = hspec $ describe "Calculator tests" $ do
  test_parser
  test_evaluator
  test_executor
  test_additional

-- Parser
-- ------

test_parser :: SpecWith ()
test_parser = describe "Parser tests" $ do
  test_p_funcStmt
  test_p_appExpr

test_p_funcStmt :: SpecWith ()
test_p_funcStmt = describe "Test p_funcStmt" $ do
  describe "function with no args" $
    it "f() := 2" $
      runParser p_funcStmt "f() := 2" `shouldBe` (Right (FuncStmt "f" [] (NumExpr 2)))

  describe "function with valid long name" $
    it "myFunc_1() := 2" $
      runParser p_funcStmt "myFunc_1() := 2" `shouldBe` (Right (FuncStmt "myFunc_1" [] (NumExpr 2)))

  describe "function with invalid long name (1)" $
    it "MyFunc_1() := 2" $
      runParser p_funcStmt "MyFunc_1" `shouldSatisfy` isParseError

  describe "function with invalid long name (2)" $
    it "1myFunc_1() := 2" $
      runParser p_funcStmt "1myFunc_1" `shouldSatisfy` isParseError

  describe "function with invalid long name (3)" $
    it "_myFunc_1() := 2" $
      runParser p_funcStmt "_myFunc_1" `shouldSatisfy` isParseError

  describe "function with 1 arg" $
    it "f(x) := x" $
      runParser p_funcStmt "f(x) := x" `shouldBe` (Right (FuncStmt "f" ["x"] (VarExpr "x")))

  describe "function with 2 args" $
    it "f(x, y) := x + y" $
      runParser p_funcStmt "f(x, y) := x + y" `shouldBe`
        (Right (FuncStmt "f" ["x", "y"] (AddExpr (VarExpr "x") (VarExpr "y"))))

test_p_appExpr :: SpecWith ()
test_p_appExpr = describe "Test p_appExpr" $ do
  describe "function with no args" $
    it "f()" $
      runParser p_appExpr "f()" `shouldBe` (Right (AppExpr "f" []))

  describe "function with 1 arg" $
    it "f(1)" $
      runParser p_appExpr "f(1)" `shouldBe` (Right (AppExpr "f" [NumExpr 1]))

  describe "function with 2 args" $
    it "f(x, y)" $
      runParser p_appExpr "f(x, y)" `shouldBe` (Right (AppExpr "f" [VarExpr "x", VarExpr "y"]))

  describe "function with AddExpr arg" $
    it "f(x + 2)" $
      runParser p_appExpr "f(x + 2)" `shouldBe`
        (Right (AppExpr "f" [AddExpr (VarExpr "x") (NumExpr 2)]))

-- ### Helper functions

isParseError :: Either String a -> Bool
isParseError (Left _) = True
isParseError _        = False

-- Executor
-- --------

test_executor :: SpecWith ()
test_executor = describe "Testing statement executor" $ do
  test_setStmt
  test_funcStmt

test_setStmt :: SpecWith ()
test_setStmt = describe "Testing statement evaluator" $ do
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

test_funcStmt :: SpecWith ()
test_funcStmt = describe "Testing function declarations" $ do
  describe "function with no args" $
    it "exec f() := 2" $
      exec (FuncStmt "f" [] (NumExpr 1)) H.empty `shouldBe` testingEnvFunc

  describe "function with 1 arg" $
    it "exec f(x) := x" $
      exec (FuncStmt "f" ["x"] (VarExpr "x")) H.empty  `shouldBe` testingEnvFunc'

  describe "function with 2 args" $
    it "exec f(x, y) := x + y" $
      exec (FuncStmt "f" ["x", "y"] (AddExpr (VarExpr "x") (VarExpr "y"))) H.empty  `shouldBe` testingEnvFunc''

-- Evaluator
-- ---------

test_evaluator :: SpecWith ()
test_evaluator = describe "Testing expression evaluator" $ do
  test_addExpr
  test_subtractExpr
  test_multiplyExpr
  test_divideExpr
  test_numExpr
  test_constExpr
  test_varExpr
  test_appExpr

-- ### NumExpr

test_numExpr :: SpecWith ()
test_numExpr = describe "Testing evaluator on NumExpr" $ do
  describe "simple eval NumExpr" $
    it "eval (NumExpr 3.3) -> NumVal 3.3" $
      eval (NumExpr 3.3) emptyEnv `shouldBe` NumVal 3.3

-- ### ConstExpr

test_constExpr :: SpecWith ()
test_constExpr = describe "Testing evaluator on ConstExpr" $ do
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

test_varExpr :: SpecWith ()
test_varExpr = describe "Testing evaluator on VarExpr" $ do
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

test_addExpr :: SpecWith ()
test_addExpr = describe "Testing evaluator on AddExpr" $ do
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

test_subtractExpr :: SpecWith ()
test_subtractExpr = describe "Testing evaluator on SubtractExpr" $ do
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

test_multiplyExpr :: SpecWith ()
test_multiplyExpr = describe "Testing evaluator on MultiplyExpr" $ do
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

test_divideExpr :: SpecWith ()
test_divideExpr = describe "Testing evaluator on DivideExpr" $ do
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

-- ### AppExpr

test_appExpr :: SpecWith ()
test_appExpr = describe "Testing evaluator on AppExpr" $ do
  describe "Test builtin sin function (1)" $
    it "sin 0" $
      eval (AppExpr "sin" [NumExpr 0]) H.empty `shouldBe` NumVal (sin 0)

  describe "Test builtin sin function (2)" $
    it "sin pi" $
      eval (AppExpr "sin" [ConstExpr "pi"]) H.empty `shouldBe` NumVal (sin pi)

  describe "Test builtin cos function (1)" $
    it "cos 0" $
      eval (AppExpr "cos" [NumExpr 0]) H.empty `shouldBe` NumVal (cos 0)

  describe "Test builtin cos function (2)" $
    it "cos pi" $
      eval (AppExpr "cos" [ConstExpr "pi"]) H.empty `shouldBe` NumVal (cos pi)

  describe "Test function with no args" $
    it "f() -> 2" $
      eval (AppExpr "f" []) testingEnvFunc `shouldBe` NumVal 1

  describe "Test function with 1 arg" $
    it "f(3 / 2) -> 1.5" $
      eval (AppExpr "f" [NumExpr 1.5]) testingEnvFunc' `shouldBe` NumVal 1.5

  describe "Test function with 2 args" $
    it "f(3, 4.5) -> 7.5" $
      eval (AppExpr "f" [NumExpr 3, NumExpr 4.5]) testingEnvFunc'' `shouldBe` NumVal 7.5

  describe "Test function name that doesn't exist" $
    it "test() not found" $
      eval (AppExpr "test" []) H.empty
        `shouldBe` ExnVal "Function name test is not defined."

  describe "Test name that isn't a CloVal" $
    it "n := 3; n() gives error" $
      eval (AppExpr "x" []) testingEnv
        `shouldBe` ExnVal "Can only apply CloVals."

-- ### Properties for QuickCheck tests

--prop_funcStmt_Args ::
--TODO

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

test_additional :: SpecWith ()
test_additional = sequence_ additionalTests

-- Add any tests you want to include to the list additionalTests.

additionalTests :: [SpecWith ()]
additionalTests = [ test_example ]

test_example :: SpecWith ()
test_example = describe "This test does nothing" $ do
  describe "" $
    it "" $
      True `shouldBe` True
