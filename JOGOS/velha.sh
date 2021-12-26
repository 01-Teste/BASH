#!/bin/bash

# jogo da velha

pos="tput cup"
p1=0 p2=0 p3=0
_casasN()
  {
	a1='1' a2='2' a3='3'
	b1='4' b2='5' b3='6'
	c1='7' c2='8' c3='9'
	}
_casas()
	{
	a1=' ' a2=' ' a3=' '
	b1=' ' b2=' ' b3=' '
	c1=' ' c2=' ' c3=' '
	}
_matriz()
	{
	$pos 10 10; echo " $a1 | $a2 | $a3  "
	$pos 11 10; echo "---+---+---"
	$pos 12 10; echo " $b1 | $b2 | $b3  "
	$pos 13 10; echo "---+---+---"
	$pos 14 10; echo " $c1 | $c2 | $c3  "
	}
_tabela()
	{
	$pos 10 30; echo "=============================="
	$pos 11 30; echo "| empate | vitória | derrota |"
	$pos 12 30; echo "=============================="
	$pos 13 30; echo "|    $p1   |    $p2    |    $p3    |"
	$pos 14 30; echo "=============================="
	}
_vJogada()
	{
	case $key in
		1) [ -z $a1 ] && a1=$v && break ;;
		2) [ -z $a2 ] && a2=$v && break ;;
		3) [ -z $a3 ] && a3=$v && break ;;
		4) [ -z $b1 ] && b1=$v && break ;;
		5) [ -z $b2 ] && b2=$v && break ;;
		6) [ -z $b3 ] && b3=$v && break ;;
		7) [ -z $c1 ] && c1=$v && break ;;
		8) [ -z $c2 ] && c2=$v && break ;;
		9) [ -z $c3 ] && c3=$v && break ;;
		q) break && break ;;
	esac
	}
_jogador()
	{
	v='X'

	while [ 1 ]
	do
		read -s -n 1 key; _vJogada
	done
	}
_oponente()
	{
	v='O'

	while [ 1 ];
	do
		eval $game; _vJogada
	done
	}
_continua()
	{
	let p$x++
	_tabela
	$pos 18 10; echo "[1] para continuar"
	$pos 19 10; echo "[2] para sair"
	$pos 20 10; read -p "Digite uma opção: " op

	if [ $op = 1 ]
	then
		_casas; _matriz
	elif [ $op = 2 ]
	then
		exit 0
	fi
	}
_vGanhador()
	{
	[[ $a1 = $v ]] && [[ $a2 = $v ]] && [[ $a3 = $v ]] && _msgGanhador
	[[ $b1 = $v ]] && [[ $b2 = $v ]] && [[ $b3 = $v ]] && _msgGanhador
	[[ $c1 = $v ]] && [[ $c2 = $v ]] && [[ $c3 = $v ]] && _msgGanhador
	[[ $a1 = $v ]] && [[ $b1 = $v ]] && [[ $c1 = $v ]] && _msgGanhador
	[[ $a2 = $v ]] && [[ $b2 = $v ]] && [[ $c2 = $v ]] && _msgGanhador
	[[ $a3 = $v ]] && [[ $b3 = $v ]] && [[ $c3 = $v ]] && _msgGanhador
	[[ $a1 = $v ]] && [[ $b2 = $v ]] && [[ $c3 = $v ]] && _msgGanhador
	[[ $a3 = $v ]] && [[ $b2 = $v ]] && [[ $c1 = $v ]] && _msgGanhador
	}
_ganhador()
	{
	x='2' v='X' id='1'; _vGanhador
	x='3' v='O' id='2'; _vGanhador
	}
_empate()
	{
	if [ ! -z $a1 ] && [ ! -z $a2 ] && [ ! -z $a3 ] && \
		[ ! -z $b1 ] && [ ! -z $b2 ] && [ ! -z $b3 ] && \
		[ ! -z $c1 ] && [ ! -z $c2 ] && [ ! -z $c3 ]
	then
		let p1++ ; _tabela
		$pos 16 10; echo "Houve empate"; sleep .7
		$pos 16 10; echo "            "
		x= #_casas; _matriz
		_continua
	fi
	}
_msgGanhador()
	{
	$pos 16 10; echo jogador $id ganhou!; sleep .7
	$pos 16 10; printf ' %.0s' {1..17}; _continua
	}
_config()
	{
	$pos 2 10; echo "[1] jogar contra a máquina"
	$pos 3 10; echo "[2] jogar com outra pessoa"
	$pos 4 10; read -p "Digite um opção: " op

	[[ $op = 1 ]] && game='key=$(shuf -i 1-9 -n 1)'
	[[ $op = 2 ]] && game='read -s -n1 key'
	}
_gaming()
	{
	_matriz; _ganhador; _empate; _tabela
	$pos 8 10; echo " jogador=$j"; sleep .4
	}
clear; _config; _casasN; _matriz; _tabela
sleep 1.8; _casas
while [ 1 ]
do
	j=1 _gaming; _jogador
	j=2 _gaming; _oponente
done
