#!/bin/bash

cd $(dirname $0)

echo "
--------------------
hugo-theme-vivliocli
config      : ${1}
hugo        : $(hugo version)
vivliostyle : $(vivliostyle -v)
--------------------"

# environment exist check
config_path=./config/${1}/config.toml
if [ ! -e $config_path ]; then
  echo "${config_path} does not exist in config directory."
  exit 1
fi

echo "
--------------------
Hugo Build
--------------------"
hugo --environment ${1}
if [ $? != 0 ]; then exit; fi
echo "Hugo Build was Completed."


echo "
--------------------
Build PDF (jp)
--------------------"
cd public_${1}/jp
vivliostyle build -c _pdf.vivlio.config.js
if [ $? != 0 ]; then exit; fi
echo "Build PDF was Completed."
