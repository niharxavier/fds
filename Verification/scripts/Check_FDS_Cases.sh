#!/bin/bash

DIR=.

# parse options
while getopts 'ACd:e:Ef:hHiILm:MNn:o:O:p:Pq:rsStT:vVw:' OPTION
do
case $OPTION  in
  d)
   DIR="$OPTARG"
   ;;
esac
done
shift $(($OPTIND-1))

case=$1
infile=$DIR/${case%.*}.fds
outfile=$DIR/${case%.*}.out
if [  -e $outfile ]; then
  if [[ `grep -rI 'completed successfully' $outfile` == "" ]] && [[  `grep -rI 'Set-up only' $outfile` == "" ]] && [[ `grep -rI 'stopped by KILL control' $outfile` == "" ]]; then
    echo "ERROR: $infile started but did not complete"
  fi
else
  echo "ERROR: $infile did not run"
fi
