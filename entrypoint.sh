#! /usr/bin/env bash

cd /github/workspace

RESULTS_DIRECTORY=$1
REPORT_DIRECTORY=$2
RESULTS_HISTORY=$RESULTS_DIRECTORY/history
REPORT_HISTORY=$REPORT_DIRECTORY/history

echo "Starting script to generate Allure Report ..."
echo "Getting results from $RESULTS_DIRECTORY"
echo "Final report will be stored at $REPORT_DIRECTORY"

cp -r allure-report/history $RESULTS_DIRECTORY

if [ ! -d "$REPORT_DIRECTORY" ]; then
  echo "creating report directory"
  mkdir $REPORT_DIRECTORY
  echo "listing report directory"
  ls -l $REPORT_DIRECTORY
fi

if [ -d "$RESULTS_HISTORY" ]; then
  echo "copying $REPORT_HISTORY to $RESULTS_HISTORY  ..."
  cp -r $REPORT_HISTORY $RESULTS_HISTORY
fi

unset JAVA_HOME
echo "generating report ..."
allure generate $RESULTS_DIRECTORY --clean

echo "listing result directory after generation"
echo "DIRECTORY: $RESULTS_DIRECTORY"
ls -l $RESULTS_DIRECTORY
echo "DIRECTORY: allure-report"
ls -l allure-report

echo "copying report files to $REPORT_DIRECTORY"
rsync -av --progress /github/workspace/allure-report/ /github/workspace/$REPORT_DIRECTORY

echo "listing report directory ..."
ls -l $REPORT_DIRECTORY
