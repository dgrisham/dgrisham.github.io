#!/bin/sh

runTest() {
    num="$1"
    input="$2"
    expected="$3"

    actual=$(printf "$input" | stack exec haskell-calculator-exe 2>/dev/null | sed 's/> //g')

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    NC='\033[0m'

    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}Test $num passed.${NC}"
    else
        echo -e "${RED}Test $num failed.${NC}"
        echo
        echo "Expected output"
        echo "---------------"
        echo "$expected"
        echo
        echo "Actual output"
        echo "-------------"
        echo "$actual"
        echo
    fi
}

input1=\
"n := 3
f(z) := z / n
g(x) := x
h(y) := g(y) + 1
n
f(9)
f(2 + 7)
f(g(9))
h(2)
"

expected1="\
3.0
3.0
3.0
3.0
3.0"

runTest 1 "$input1" "$expected1"

input2=\
"x := 2; f(x) := x
f(3)
g(x, y) := x * y - (x / y)
g(4, 2)
"

expected2="\
3.0
6.0"

runTest 2 "$input2" "$expected2"
