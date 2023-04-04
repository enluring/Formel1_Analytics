# Formel1_Analytics
Dette er en test for å se om jeg klarer å lage en kontainer med noe fornuftig innhold osv...

## Datagrunnlag
Datagrunnlaget er hentet fra følgende: http://ergast.com/mrd/db/


# Install and configure
## Krav til løsning
* Docker og docer-comppse
* python 

Installasjon av python og addons for å kjøre script til tabell oppdatering osv
`````
sudo apt install python3-pip
sudo apt-get install python3-psycopg2
pip install psycopg2-binary
`````

## Installation
### Last ned repo
Først så skal vi clone ned repoet dette repositoriet 
````
sudo git clone https://github.com/enluring/Formel1_Analytics

cd Formel1_Analytics
`````

### Konfigurasjon
Om du vil endre på passord og lagringssted så gjøres dette i docker-compose filen. Default så er admin/admin og f1admin/f1admin brukt som brukernavn og passord. 

Grafana er satt til ekstern port 3001 slik at man ikke skal kræsje med andre docker instanser. 

### Start containere
For å starte containerene så kjører vi docker-compse filen for å kjøre opp alle kontainerene. 
`````
sudo docker-compose up -d
``````

## Lage tabeller og legg innhold inn i databasen
Du kan nå starte å lage tabeller i databasen i henhold til script ...
Installer sql  klient først og koble opp til basen
````
sudo apt install postgresql-client

psql -h 172.19.0.2 -d f1db -U f1admin
`````
Først oppretter vi alle tabeller som skal inn i databasen
`````
python3 InsertTable.py
``````
Så kan vi legge inn alle data som vi har, dette er data som ligger i data folder og som kan oppdateres med nye filer. Data er hentet fra csv filene til http://ergast.com/mrd/db/. Scriptet skal fungere også med nye oppdaterte filer som opppdaterer databasen
`````
python3 InsertDataToTable.py
`````

# Open and use
Default når man kjører opp data fra lokal docker installasjon kan man nå de forksjellige tjenestene igjennom localhost og port:
* Grafana: http://localhost:3001
* PGAdmin: http://localhost:8050



# Todo
Det er en rekke forbedringer som kan gjøres
* rydde i noen gamle filer
* Rydde i tabellene slik at de matcher ergast med typer og foreldre
* Fikse konfigurasjon av grafana blir lagt inn i imaget
* Lage default views som blir med inn i grafana
* Hente data fra ergast apiet i stede for fra csv
* Kombinere med fastf1 python bibloteket for oppdatering og live data





