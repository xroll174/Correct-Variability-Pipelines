sub=($@)
for ((i=0; i<${#sub[@]};i++))
do
    rm -Rf data/${sub[i]}
done
