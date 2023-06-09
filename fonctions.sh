#!/bin/bash

#creation variable contenant 5 lettre pour choisir les mots affichés taupe et bombe
Mole= 'taupe'
Bomb= 'bombe'


function augmentation_score ()
{
		score="$(( $1 + $2 ))"
}

function diminution_score ()
{
		score="$(( $1 - $2 ))"
}

function get_action()
{
	my_key=$1
	my_case=$2

	#gestion bombe
	if [ $my_case == $Bomb ] && [ $vie -eq "1" ]
	then
			clear
			echo "######### PERDU #########"
			echo "Score : " $score
			sleep 2
			duration=999999
			ok=taperdugrosnullos

	elif [ $my_case == $Bomb ] && [ $vie -gt "1" ]
	then
			vie=$(( $vie -1 ))
	fi

#gestion score
	if [ $my_case == $Mole ]
	then
			augmentation_score $score 1
	else
			diminution_score $score 1
	fi
}

function get_key()
{
	key=$1
	a=$2
	z=$3
	e=$4
	q=$5
	s=$6
	d=$7
	case "$key" in
			"a") get_action "$key" "$a" ;;
			"z") get_action "$key" "$z";;
			"e") get_action "$key" "$e";;
			"q") get_action "$key" "$q";;
			"s") get_action "$key" "$s";;
			"d") get_action "$key" "$d";;
			*);;
  esac
}

function init_grid()
{
		a='     '
		z='     '
		e='     '
		q='     '
		s='     '
		d='     '
}

function print_grid()
{
		clear
    GRID="
Score: $score  	Vie: $vie
    +-------+-------+-------+
    | $a | $z | $e |
    |   "A"   |   "Z"   |   "E"   |
    +-------+-------+-------+
    | $q | $s | $d |
    |   "Q"   |   "S"   |   "D"   |
    +-------+-------+-------+
	"
		echo -e "\e[1;36m$GRID\e[0m"


}

function taupe1()
{

	CHOIX="$(( $RANDOM % 3 + 1))"
	PLAY="$(( $RANDOM % 6 + 1))"

	#Bombe
	if  [ "$CHOIX" -eq "1" ]
	then
	case "$PLAY" in
		"1") a= $Bomb ;;
		"2") z= $Bomb ;;
		"3") e= $Bomb ;;
		"4") q= $Bomb ;;
		"5") s= $Bomb ;;
		"6") d= $Bomb ;;
    esac
  else
		#Taupe
	case "$PLAY" in
		"1") a= $Mole ;;
		"2") z= $Mole ;;
		"3") e= $Mole ;;
		"4") q= $Mole ;;
		"5") s= $Mole ;;
		"6") d= $Mole ;;
    esac
  fi
	print_grid
	#Vitesse taupe
  if [ $score -eq "5" ]
  then
    	vitesse="2"
  elif [ $score -eq "10" ]
  then
    	vitesse="1"

  elif [ $score -eq "15" ]
  then
    	vitesse="0.5"
  fi

  read -s -N 1 -t $vitesse key
  # echo "** $key **"
	get_key "$key" "$a" "$z" "$e" "$q" "$s" "$d"

	#Si ok non vide alors le jeu continu
	if [ -z $ok ]
	then
		init_grid
		print_grid
	fi
}
