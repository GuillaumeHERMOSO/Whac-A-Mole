#!/bin/bash


source fonctions.sh
source PageHelp.sh

while true
do
    OPTION=$(whiptail --title "BIENVENUE SUR LE MENU PRINCIPAL" --menu "Choisissez votre action" 15 60 4 \
    "1" "Démarrer le jeu" \
    "2" "Quitter" \
    "3" "Aide"  3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ "$exitstatus" -eq 0 ]
    then
        if [ "$OPTION" == '1' ]
        then
      	clear
      	echo "Combien de temps veux-tu jouer ? (temps en seconde) "
      	read temps
      	duration=0
      	score="0"
      	vitesse="3"
      	vie="3"
      	init_grid
        print_grid
      	start=$SECONDS
      	while [ $temps -ge $duration ]
      	do
              duration=$(( $SECONDS - $start ))
            	taupe1
            	read -s -N 1 -t $(( $RANDOM % 3 + 1))
      	done
      	clear
      	if [ -z $ok ] || [ $vie -eq "0" ]
      	then
          		echo "######### GAGNE #########"
          		echo "Score : " $score
          		sleep 2
          		clear
      	fi

    elif [ "$OPTION" == '3' ]
    then
        HelpPage
    elif [ "$OPTION" == '2' ]
    then
        clear
        exit
    else
        echo "vous avez annulé"
    fi
  fi
done