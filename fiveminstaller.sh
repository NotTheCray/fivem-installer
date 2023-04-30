#!/bin/bash

echo 'Was geht ab Bro, Installer startet Jetzt'


apt update && apt upgrade


apt install xf tar


mkdir -p /home/FiveM/server
cd /home/FiveM/server


echo 'Gebe den link zu deinen FiveM-Artifakten ein:'
read link
wget $link


echo 'Nun noch einmal entpacken...'
tar xf fx.tar.xz
echo 'Bums sind sie installiert'

rm -r fx.tar.xz

echo 'Jetzt noch einmal die Screen anwendung installieren...'
apt install screen

echo 'Alles hat geklappt! Gehe einfach in /home/FiveM/server und benutze den command --> screen ./run.sh'

cd /home/FiveM/server

screen ./run.sh

echo 'So Fertig Kollege!'
