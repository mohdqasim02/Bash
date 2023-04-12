#! /bin/bash

COMMAND_TO_TEST=$1
$COMMAND_TO_TEST 1>/dev/null 
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ];then
  say "ALL TESTS PASSED"
else
  say "$EXIT_CODE TESTS FAILED"
fi
