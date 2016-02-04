in {1..2847}
    do
t=$(( ( RANDOM % 5 )  + 1 ))
    echo Sleeping for $t

    sleep ${t}s
m=$((i%10))
    if [ ! -d html/$m/$i ]; then
    mkdir -p html/$m
    fi;
    wget http://www.miicharacters.com/?mii=${i} -O html/$m/${i}.html
    done
