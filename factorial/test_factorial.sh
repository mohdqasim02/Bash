#! /bin/bash

# This is automated testing mechanism for testing the factorial command
# TEST_CASES
# asserting {factorial 0} is equal to 1 .... yes
# asserting {factorial 1} is equal to 1 .... yes
# asserting {factorial 4} is equal to 24 .... yes
# asserting {factorial -1} is equal to 0 .... yes
# asserting {factorial -5} is equal to 0 .... yes
# Summary : 5/5 tests passed
# EXIT with number of failed test cases

TOTAL_TESTS=7
TEST_RESULTS=0

function assert_factorial_of() {
  INPUT=$1
  EXPECTED=$2
  ACTUAL=$(./factorial.sh $INPUT)
  IS_PASSED="NO"
  EXIT_CODE=1

  if [ $EXPECTED -eq $ACTUAL ];then
    IS_PASSED="YES"
    EXIT_CODE=0
  fi

  echo "asserting (factorial $INPUT) is equal to $EXPECTED .... $IS_PASSED | (OUTPUT:$ACTUAL)"
  return $EXIT_CODE
}

# Zero
assert_factorial_of 0 1

# Positive Numbers
assert_factorial_of 1 1
assert_factorial_of 2 2
assert_factorial_of 3 6
assert_factorial_of 5 120

# Negative Numbers
assert_factorial_of -1 0
assert_factorial_of -2 0
assert_factorial_of -5 0


##echo $TEST_RESULTS
#TESTS_FAILED=$(dc -e "0 $TEST_RESULTS + p")
#echo #TESTS_FAILED
#TESTS_PASSED=$(dc -e "$TOTAL_TESTS $TESTS_FAILED - p")
#echo "Summary : $TESTS_PASSED/$TOTAL_TESTS tests passed"
#EXIT_CODE=$(dc -e "$TOTAL_TESTS $TESTS_PASSED - p")
#exit $EXIT_CODE
