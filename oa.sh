#!/bin/bash

quakestat -q3s 151.236.222.109:27966 -cn -P -R -xml -of city.dat

declare -a pole

oaMapa=$(xmllint --xpath '(//map)/text()' "city.dat")
oaCount=$(xmllint --xpath 'count(//score)' "city.dat")
oaSledujici=$(xmllint --xpath '(//numspectators)/text()' "city.dat")
printf "Map: %s \n" ${oaMapa}
printf "Players: %s \n" ${oaCount}

pole[0]=$oaMapa
pole[1]=$oaCount
let index=2
for (( i=1, a=2; i<${oaCount}+1; i++, a++))
do
    oaScore=$(xmllint --xpath '(//score)['"$i"']/text()' "city.dat")
    oaName=$(xmllint --xpath '(//name)['$a']/text()' "city.dat")
    oaPing=$(xmllint --xpath '(//ping)['$a']/text()' "city.dat")
    if [ $oaPing -eq '0' ]
    then
        oaPing=robot
    else 
        oaPing=human
    fi
    pole[$index]=$oaName
    let index=index+1
    pole[$index]=$oaScore
    let index=index+1
    pole[$index]=$oaPing
    let index=index+1
    echo $oaName    $oaScore    $oaPing  
done
echo $index

echo ${pole[*]}
