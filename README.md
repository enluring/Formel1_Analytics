# Formel1_Analytics
Dette er en test for å se om jeg klarer å lage en kontainer med noe fornuftig innhold osv...

## Datagrunnlag
Datagrunnlaget er hentet fra følgende: http://ergast.com/mrd/db/


# Install and configure
## Krav til løsning
* Docker og docer-comppse
* phyton 

Installasjon av phyton og addons
`````
sudo apt install python3-pip
sudo pip install mysql-connector-python

`````

## Las ned og installere repo
Først så skal vi clone ned repoet dette repositoriet 
````
sudo git clone https://github.com/enluring/Formel1_Analytics

cd Formel1_Analytics
`````

start docker
For å starte docker så kjører vi docer compse filen
`````
sudo docker-compose up -d
``````

## Lage tabeller i databasen
Du kan nå starte å lage tabeller i databasen i henhold til script ...
Installer sql  klient først og koble opp til basen
````
sudo apt install postgresql-client

psql -h 172.19.0.2 -d f1db -U f1admin
`````






