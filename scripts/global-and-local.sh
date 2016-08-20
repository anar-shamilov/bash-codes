#!/usr/bin/env bash

#!/bin/bash
pprint()
{
  local lvar="Local content"
  echo -e "Local variable value with in the function"
  echo $lvar
  gvar="Global content changed"
  echo -e "Global variable value with in the function"
  echo $gvar
}

gvar="Global content"
echo -e "Global variable value before calling function"
echo $gvar
echo -e "Local variable value before calling function"
echo $lvar
pprint
echo -e "Global variable value after calling function"
echo $gvar
echo -e "Local variable value after calling function"
echo $lvar
