#!/bin/bash


source fonctions.sh
source PageHelp.sh

while true
do
    OPTION=$(whiptail --title "BIENVENUE SUR LE MENU PRINCIPAL" --menu "Choisissez votre action" 15 60 4 \
    "1" "Démarrer le jeu" \
    "2" "Quitter" \
    "3" "Aide"  \
    "4" "Hight score" 4>&1 3>&2 1>&3 2>&4)

    exitstatus=$?
    if [ "$exitstatus" -eq 0 ]
    then
        if [ "$OPTION" == '1' ]
        then
      	clear
        echo "Pseudo: "
        read pseudo

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
        echo $score - $vie - $pseudo - $temps "s \n">> hightscore.txt
      	if [ -z $ok ] && [ $score -ge "0" ]
      	then
          		echo "######### GAGNE #########"
          		echo "Score : " $score
          		sleep 2
          		clear
        elif [ -z $ok ]
        then
              echo "######### Perdu #########"
              echo " Score négatif : " $score
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
    elif [ "$OPTION" == '4' ]
    then
        clear
        echo -e $(cat hightscore.txt |sort -nr)
        sleep 5
    else
        echo "vous avez annulé"
    fi
  fi
done
