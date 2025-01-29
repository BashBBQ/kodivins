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
echo '<!DOCTYPE html>' > index.html
unalias ls
for i in $(ls -1 *.zip); do 
	echo $i; 
	echo "<a href=\"$i\">$i</a>" >> index.html;
	done


rm -rf ../repo/zips
cp -f *.zip repo/kodivins/

python _repo_generator.py

git add . ; git commit -m "comment" ; git push -u origin master

rm -rf ../repo/zips
