#!/bin/bash
set -euo pipefail
shopt -s nullglob

cd "$(dirname "$0")"

ADDON_XML=repo/kodivins/addon.xml

versione() {
	grep -oP '<addon [^>]*\bversion="\K[0-9]+'
}

# index.html: elenco degli zip che Kodi sfoglia come sorgente
{
	echo '<!DOCTYPE html>'
	echo '<html>'
	echo '<head><meta charset="utf-8"><title>kodivins</title></head>'
	echo '<body>'
	for i in *.zip; do
		echo "<a href=\"$i\">$i</a><br>"
	done
	echo '</body>'
	echo '</html>'
} > index.html

if [ -z "$(git status --porcelain)" ]; then
	echo "Nessuna modifica, niente da pubblicare"
	exit 0
fi

VERSIONEBBQ=$(versione < "$ADDON_XML") || { echo "Versione non trovata in $ADDON_XML" >&2; exit 1; }
echo "Versione corrente $VERSIONEBBQ"

# La versione sale solo se il sorgente dell'addon è cambiato e non è già stata incrementata
ADDON_MODIFICATO=$(git status --porcelain -- repo/kodivins)
if [ -n "$ADDON_MODIFICATO" ] && [ "$VERSIONEBBQ" = "$(git show "HEAD:$ADDON_XML" | versione)" ]; then
	NEWVERSIONEBBQ=$((VERSIONEBBQ + 1))
	sed -i -E "s/(<addon [^>]*\bversion=\")$VERSIONEBBQ\"/\1$NEWVERSIONEBBQ\"/" "$ADDON_XML"
	VERSIONEBBQ=$(versione < "$ADDON_XML")
	echo "Nuova versione $VERSIONEBBQ"
fi

ZIP_ADDON=repo/zips/kodivins/kodivins-$VERSIONEBBQ.zip
if [ -n "$ADDON_MODIFICATO" ] || [ ! -f "$ZIP_ADDON" ]; then
	rm -rf repo/zips
	python3 _repo_generator.py
	if [ ! -f "$ZIP_ADDON" ] || [ ! -f repo/zips/addons.xml.md5 ]; then
		echo "Generazione del repository fallita" >&2
		exit 1
	fi
fi

git add -A
git commit -m "Aggiornamento $(date +%F) (kodivins v$VERSIONEBBQ)"
git push -u origin master
