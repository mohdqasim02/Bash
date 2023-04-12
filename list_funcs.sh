#! /bin/bash

function list_func(){
  local SCRIPT=$1
  local FUNC_LIST=$(cat $SCRIPT | grep "function" | cut -d"(" -f1 | cut -d" " -f2)
  local FUNC_COUNT=$(echo $FUNC_LIST | wc -w )
  echo "TOTAL : $FUNC_COUNT"
  echo "$FUNC_LIST"
}

list_func $1
