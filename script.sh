#!/usr/bin/bash
for file in estaciones/*.csv
  do
    cat "$file" | \
    # Transforms , for . as decimal separator
    sed 's/:\([0-9]*\)\;\([0-9]*\)\;\([0-9]\),\([0-9]*\)/:\1;\2;\3.\4/' | \

    # Calculates mean
    awk '/^[0-9]*\/[0-9]*\/06\;/ { print } '| \
    awk '/^[0-9]*\/[0-9]*\/06\;/ { split($0,fields,";"); sum += fields[3]; len += 1 }
         END {printf "%s;%s---", fields[1], sum/(len+1)}'
done