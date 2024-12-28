#!/bin/bash 

VERSIONEBBQ=`cat repo/kodivins/addon.xml | grep version | grep addon | grep -oP 'version="\K[0-9]+'`
echo "Versione corrente $VERSIONEBBQ"
echo
NEWVERSIONEBBQ=$((VERSIONEBBQ + 1))
echo "Nuova versione $NEWVERSIONEBBQ"
echo
echo
updated_input=$( sed -i  -E "s/version=\"$VERSIONEBBQ\"/version=\"$NEWVERSIONEBBQ\"/")
VERSIONEBBQ=`cat repo/kodivins/addon.xml | grep version | grep addon | grep -oP 'version="\K[0-9]+'`
echo "Versione corrente $VERSIONEBBQ"
echo


rm -rf repo/zips

python _repo_generator.py

git add . ; git commit -m "comment" ; git push -u origin master
