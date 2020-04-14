cwd=$(pwd)

echo $cwd
FILE=$( dirname ${BASH_SOURCE})
echo $FILE

srcpath=$(cat $FILE/srcpath.txt)

echo $srcpath
