# KODI - configurazioni suggerite

1 Player > Language > Preferred audio language = Set your Preferred language here

2 Player > Language > Preferred subtitle language = Forced only

3 Media > General > Show parent folder items = Off

4 Interface > Regional = Configure regional settings to your preference

5 System > Add-ons > Show notifications = ON

6 System > Add-ons > Unknown sources = ON

7 System > Add-ons > Update official add-ons from = Any repositories



# Struttura

- `*.zip` nella radice: gli addon e i repository installabili da Kodi, elencati in `index.html`
- `repo/kodivins/`: sorgente dell'addon-repository `kodivins`
- `repo/zips/`: generato da `_repo_generator.py`, non va modificato a mano

# Aggiornare il repo

1. Aggiungere, sostituire o rimuovere gli zip nella radice
2. Lanciare `./upgrade.sh`

Lo script rigenera `index.html`, fa commit e push. Se è cambiato qualcosa in `repo/kodivins/` incrementa anche la versione dell'addon e ricostruisce `repo/zips/`.

# Crediti

Basato sul template https://github.com/drinfernoo/repository.example
