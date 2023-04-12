#! /bin/bash

# This is automated testing mechanism for testing the factorial command
# TEST_CASES
# asserting {factorial 0} is equal to 1 .... yes
# asserting {factorial 1} is equal to 1 .... yes
# asserting {factorial 4} is equal to 24 .... yes
# asserting {factorial -1} is equal to 0 .... yes
# asserting {factorial -2} is equal to 0 .... yes
# asserting {factorial 6} is equal to 720 .... yes
# Summary : 6/6 tests passed
# EXIT with number of failed test cases

TOTAL_TESTS=0
PASSED_TESTS=0

INPUT=0
EXPECTED_OUTPUT=1
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST1 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
  echo "yes"
  PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
else
  echo "no"
fi

INPUT=1
EXPECTED_OUTPUT=1
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST2 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
  echo "yes"
  PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
else
  echo "no"
fi

INPUT=4
EXPECTED_OUTPUT=24
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST3 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
  echo "yes"
  PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
else
  echo "no"
fi

INPUT=-1
EXPECTED_OUTPUT=0
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST4 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
  echo "yes"
  PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
else
  echo "no"
fi

INPUT=-2
EXPECTED_OUTPUT=0
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST5 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
    echo "yes"
      PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
    else
        echo "no"
fi

INPUT=6
EXPECTED_OUTPUT=720
ACTUAL_OUTPUT=$(./factorial.sh $INPUT)
TOTAL_TESTS=$(dc -e "$TOTAL_TESTS 1 + p")

echo -n "TEST6 : { factorial.sh $INPUT } is equal to $EXPECTED_OUTPUT ...."
if [ $EXPECTED_OUTPUT -eq $ACTUAL_OUTPUT ];then
    echo "yes"
      PASSED_TESTS=$(dc -e "$PASSED_TESTS 1 + p")
    else
        echo "no"
fi

echo "Summary : $PASSED_TESTS/$TOTAL_TESTS tests passed"
EXIT_CODE=$(dc -e "$TOTAL_TESTS $PASSED_TESTS - p")
exit $EXIT_CODE
