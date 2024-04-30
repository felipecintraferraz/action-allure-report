#! /usr/bin/env bash

cd /github/workspace

RESULTS_DIRECTORY=$1
REPORT_DIRECTORY=$2
RESULTS_HISTORY=$RESULTS_DIRECTORY/history
REPORT_HISTORY=$REPORT_DIRECTORY/history

echo "Starting script to generate Allure Report ..."
echo "Getting results from $RESULTS_DIRECTORY"
echo "Final report will be stored at $REPORT_DIRECTORY"


if [ ! -d "$REPORT_DIRECTORY" ]; then
  echo "creating report directory"
  mkdir $REPORT_DIRECTORY
fi

ls -l
if [ ! -d "allure-report" ]; then
  echo "allure-report directory must be created"
  mkdir allure-report
  echo "allure-report folder created"
fi

if [ -d "$RESULTS_HISTORY" ]; then
  echo "copying $RESULTS_HISTORY to $REPORT_HISTORY ..."
  cp -r $RESULTS_HISTORY $REPORT_HISTORY
  cp -r $RESULTS_HISTORY allure-report
fi

unset JAVA_HOME
echo "generating report ..."
allure generate $RESULTS_DIRECTORY --clean

echo "copying report files to $REPORT_DIRECTORY"
cp -r allure-report/* $REPORT_DIRECTORY/

echo "listing report directory ..."
ls -l $REPORT_DIRECTORY
