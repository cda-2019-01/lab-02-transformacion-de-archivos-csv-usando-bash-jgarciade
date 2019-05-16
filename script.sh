#!/usr/bin/bash

##########################################################################################
#
# Developed by: Jose Garcia as assigment evidence for Data Science course @UNAL
# @jotathebest at github: https://github.com/jotathebest
#
##########################################################################################

# Average speed per month
for file in estaciones/*.csv
do
  for a in {01..12}  # From Jan to Dec
  do
    # Extracts all the rows that fits the month number
    grep -r "^../$a/" $file | \

    # Transforms , for . as decimal separator
    sed 's/:\([0-9]*\)\;\([0-9]*\)\;\([0-9]\),\([0-9]*\)/:\1;\2;\3.\4/' | \

    #splits by semicolon and extracts the speed value
    awk -F ";" '{ print $4 }' | \

    # Calculates mean
    awk -v var=$a -v file=$file '{ sum += $0 } { len += 1 }
                                END {
                                  split(file, file_name,  "/");
                                  split(file_name[2], station_name, ".");
                                  print station_name[1] "," var "," (sum / (len+1))
                                }'
  done
done | awk 'BEGIN{print "Estacion, Mes, Velocidad"} {print $0}' > velocidad-por-mes.csv

# Average speed per year
for file in estaciones/*.csv
do
  for a in {05..17}  # From 2005 to 2017, change the iterator to calculate different years
  do
    # Extracts all the rows that fits the month number
    grep -r "^../../$a" $file | \

    # Transforms , for . as decimal separator
    sed 's/:\([0-9]*\)\;\([0-9]*\)\;\([0-9]\),\([0-9]*\)/:\1;\2;\3.\4/' | \

    #splits by semicolon and extracts the speed value
    awk -F ";" '{ print $4 }' | \

    # Calculates mean
    awk -v var=$a -v file=$file '{ sum += $0 } { len += 1 }
                                END {
                                  split(file, file_name,  "/");
                                  split(file_name[2], station_name, ".");
                                  print station_name[1] ",20" var "," (sum / (len+1))
                                }'
  done
done | awk 'BEGIN{print "Estacion, Anno, Velocidad"} {print $0}' > velocidad-por-anno.csv

# Average speed per hour
for file in estaciones/*.csv
do
  for a in {00..23}  # From 00:00 to 23:59
  do
    # Extracts all the rows that fits the month number
    grep -r "^../../..;$a:" $file | \

    # Transforms , for . as decimal separator
    sed 's/:\([0-9]*\)\;\([0-9]*\)\;\([0-9]\),\([0-9]*\)/:\1;\2;\3.\4/' | \

    #splits by semicolon and extracts the speed value
    awk -F ";" '{ print $4 }' | \

    # Calculates mean
    awk -v var=$a -v file=$file '{ sum += $0 } { len += 1 }
                                END {
                                  split(file, file_name,  "/");
                                  split(file_name[2], station_name, ".");
                                  print station_name[1] "," var ":00," (sum / (len+1))
                                }'
  done
done | awk 'BEGIN{print "Estacion, Anno, Velocidad"} {print $0}' > velocidad-por-hora.csv
