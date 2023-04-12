#! /bin/bash

function style(){
  echo -n -e "\033[${2}m${1}\033[0m"
}

function red(){
  style "$1" 31
}

function green(){
  style "$1" 32
}

function yellow(){
  style "$1" 33
}

function blue(){
  style "$1" 34
}

function purple(){
  style "$1" 35
}

function cyan(){
  style "$1" 36
}

function red_hl(){
  style "$1" 41
}

function green_hl(){
  style "$1" 42
}

function yellow_hl(){
  style "$1" 44
}

function blue_hl(){
  style "$1" 44
}

function purple_hl(){
  style "$1" 45
}

function cyan_hl(){
  style "$1" 46
}

function underline(){
  style "$1" 4
}

function bold(){
  style "$1" 1
}

function blink(){
  style "$1" 5
}
