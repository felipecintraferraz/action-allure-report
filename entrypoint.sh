#! /usr/bin/env bash

cd /github/workspace

echo "listing files in workspace ..."
ls -l

echo "generating report ..."
RESULTS_DIRECTORY=$1
REPORT_DIRECTORY=$2
RESULTS_HISTORY=$RESULTS_DIRECTORY/history
REPORT_HISTORY=$REPORT_DIRECTORY/history

if [ ! -d "$REPORT_DIRECTORY" ]; then
  mkdir $REPORT_DIRECTORY
fi

if [ -d "$REPORT_HISTORY" ]; then
  echo "copying $REPORT_HISTORY to $RESULTS_HISTORY ..."
  cp -r $REPORT_HISTORY $RESULTS_HISTORY
fi


unset JAVA_HOME
allure generate --clean
echo "listing report directory ..."
ls -l $REPORT_DIRECTORY
