#! /usr/bin/env bash

GITHUB_WORKSPACE=$1
REPORT_DIRECTORY=$2

RESULTS_HISTORY=$GITHUB_WORKSPACE/allure-results/history
REPORT_HISTORY=$GITHUB_WORKSPACE/$REPORT_DIRECTORY/history

cd $GITHUB_WORKSPACE

echo "Starting script to generate Allure Report ..."
echo "Getting results from allure/results"
echo "Final report will be stored at $REPORT_DIRECTORY"

if [ ! -d "$GITHUB_WORKSPACE/$REPORT_DIRECTORY" ]; then
  echo "creating report directory"
  mkdir -p $GITHUB_WORKSPACE/$REPORT_DIRECTORY
  echo "directory $GITHUB_WORKSPACE/$REPORT_DIRECTORY created"
fi

if [ -d "$RESULTS_HISTORY" ]; then
  echo "copying $REPORT_HISTORY to $RESULTS_HISTORY  ..."
  cp -r allure-report/history $RESULTS_HISTORY
fi

unset JAVA_HOME
echo "generating report ..."
allure generate $RESULTS_DIRECTORY --clean

echo "copying report files to $GITHUB_WORKSPACE/$REPORT_DIRECTORY"
rsync -av --progress ./allure-report/ $GITHUB_WORKSPACE/$REPORT_DIRECTORY

echo "listing report directory ..."
ls -l $GITHUB_WORKSPACE/$REPORT_DIRECTORY
