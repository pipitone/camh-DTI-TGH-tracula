#!/bin/bash
# Usage: gather-pathstats tracula_outputs/
#
# Dumps a file the current folder for combined pathstats for each tract for all
# subjects that have them. 
tracula_outputs=$1

trac_paths_done=($(find $tracula_outputs -maxdepth 3 -name trac-paths.done))

if [ -z "$trac_paths_done" ]; then
  echo "No subjects with completed paths found in $tracula_outputs"
  exit 1;
fi 

model=$(dirname $(dirname ${trac_paths_done[0]}))
for pathstatsfile in $(find $model/dpath -name pathstats.overall.txt); do 
  tract=$(basename $(dirname $pathstatsfile))
  inputs="$tracula_outputs/*/dpath/${tract}/pathstats.overall.txt"
  tractstats2table --inputs $inputs --overall --tablefile ${tract}.csv
done
