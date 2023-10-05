#!/bin/bash

green='\033[0;32m'
red='\033[0;31m'
white='\033[0;37m'
reset='\033[0;0m'

status(){
  clear
  if [[ "$2" == "/" ]]; then
    echo -e $green$1$reset
  else
    echo -e $green$@'...'$reset
  fi
  sleep 1
}

runCommand(){
    COMMAND=$1

    if [[ ! -z "$2" ]]; then
      status $2
    fi

    eval $COMMAND;
    BASH_CODE=$?
    if [ $BASH_CODE -ne 0 ]; then
      echo -e "${red}An error occurred:${reset} ${white}${COMMAND}${reset}${red} returned${reset} ${white}${BASH_CODE}${reset}"
      exit ${BASH_CODE}
    fi
}

function updateUpgrade() {
    status "System wird aktualisiert"
    runCommand "sudo apt-get update"
    runCommand "sudo apt-get upgrade -y"
}

function installDependencies() {
    status "Abhängigkeiten werden installiert"
    runCommand "apt install tar"
    runCommand "apt install screen"
}

function Direction () {
    status "Ordner wird erstellt"
    runCommand "mkdir -p /home/FiveM/server"
    runCommand "cd /home/FiveM/server"
}

function ArifactsInstall() {
    status "Gebe den artifacts link ein"
    read -p "Artifacts Link: " artifacts
    runCommand "wget $artifacts"
    sleep 1

    status "Entpacke die artifacts"
    runCommand "tar xf fx.tar.xz"
    runCommand "rm fx.tar.xz"
    runCommand "chmod +x run.sh"
}

function StartingScreenOptions() {
    status "Möchtest du den server jetzt direkt starten?"
    Options "Ja" "Nein"

    case $OPTIONS in
        1) StartingScreen;;
        2) exit;;
    esac
}

function StartingScreen() {
    status "Danke fürs benutzen des FiveM Installers von Crayy"
    sleep 2
    status "Der Server wird gestartet"
    runCommand "screen -dmS FiveM ./run.sh"
}

curl --version
if [[ $? == 127  ]]; then  apt -y install curl; fi

updateUpgrade
installDependencies
Direction
ArifactsInstall
StartingScreenOptions

