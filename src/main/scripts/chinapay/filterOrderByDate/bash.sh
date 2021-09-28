#!/bin/bash
awkFile=`pwd`"/filter-by-date.awk"
if [ $# -lt 1 ]; then echo "error! please input source path"; exit;
fi
ORIGIN_PATH=$1
cd "$ORIGIN_PATH" || exit
echo "enter origin directory: ${ORIGIN_PATH}"

DEST_PATH="${ORIGIN_PATH}-MODIFIED"

if [ ! -d "$DEST_PATH" ]; then
  /bin/mkdir -p "$DEST_PATH" || exit
  echo "dest directory created: ${DEST_PATH}"
else
  echo "dest directory already exists: ${DEST_PATH}"
  exit
fi

# shellcheck disable=SC2016
# shellcheck disable=SC2089
filelist=`/bin/ls *.txt.tmp`
for file in $filelist
do
  /usr/bin/awk -f "$awkFile" "$file" >> "${DEST_PATH}/${file}"
  echo "processed: ${file}"
done

cd $DEST_PATH || exit
echo "enter DEST_PATH: ${DEST_PATH}"
destFileList=`/bin/ls *.txt.tmp`
for file in $destFileList
do
  if [ ! -s $file ]; then
    /bin/rm -rf $file || exit
    echo "delete empty file: ${file}"
  fi
done
echo "success!"
exit