#!/bin/bash 

VERSIONEBBQ=`cat repo/kodivins/addon.xml | grep version | grep addon | grep -oP 'version="\K[0-9]+'`
echo "Versione corrente $VERSIONEBBQ"
echo
NEWVERSIONEBBQ=$((VERSIONEBBQ + 1))
echo "Nuova versione $NEWVERSIONEBBQ"
echo
echo
updated_input=$( sed -i  -E "s/version=\"$VERSIONEBBQ\"/version=\"$NEWVERSIONEBBQ\"/" repo/kodivins/addon.xml)
VERSIONEBBQ=`cat repo/kodivins/addon.xml | grep version | grep addon | grep -oP 'version="\K[0-9]+'`
echo
echo "Versione corrente $VERSIONEBBQ"
echo
echo

rm -rf ../repo/zips

python _repo_generator.py

git add . ; git commit -m "comment" ; git push -u origin master

rm -rf ../repo/zips
