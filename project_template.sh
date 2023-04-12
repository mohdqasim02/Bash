#! /bin/bash

PROJECT_NAME=$1
PROJECT_DIR=$2
TEMPLATE="/Users/mohdqasim/workspace/JavaScript/project-template"

function kebab_to_camel() {
  local NAME=$1
  for CHAR in $(echo $NAME | grep -o "\-.")
  do
    CAPITAL_CASE=$(echo $CHAR | tr "[:lower:]" "[:upper:]" | sed "s/-//g")
    NAME=$(echo $NAME | sed "s/$CHAR/$CAPITAL_CASE/g")
  done
  echo "$NAME"
}

function copy_dir() {
  cp -R "$TEMPLATE" "$PROJECT_DIR/$PROJECT_NAME" 
}

function rename_files() {
  mv "$PROJECT_DIR/$PROJECT_NAME/src/source.js" "$PROJECT_DIR/$PROJECT_NAME/src/$PROJECT_NAME.js" 
  mv "$PROJECT_DIR/$PROJECT_NAME/tests/source-test.js" "$PROJECT_DIR/$PROJECT_NAME/tests/$PROJECT_NAME-test.js" 
}

function update_tests() {
  OBJECT_NAME=$(kebab_to_camel $PROJECT_NAME)
  sed -i "" "s/source/$PROJECT_NAME/g" "$PROJECT_DIR/$PROJECT_NAME/tests/$PROJECT_NAME-test.js"
  sed -i "" "s/number/$OBJECT_NAME/g" "$PROJECT_DIR/$PROJECT_NAME/tests/$PROJECT_NAME-test.js"
}

function main() {
  copy_dir
  rename_files
  update_tests
}

main
