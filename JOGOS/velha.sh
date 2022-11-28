#!/bin/bash

# --------------------------------------------
# Descrição: Jogo da velha
# Versão: 0.01 Beta
# --------------------------------------------
# Validação realizar no Ubuntu-16.04
# pode haver erros em versções diferentes
# --------------------------------------------

# variavel que define status do jogo
run=true

# para definir posições de exibição do cursor
pos="tput cup"

# Definicação de pontuação no painel de placar
p0=0 p1=0 p2=0

# Limpa as casas da matriz
_casasN ()
{
	a1='1' a2='2' a3='3' b1='4' b2='5' b3='6' c1='7' c2='8' c3='9'
}

# Ilustração de como realizar jogadas
_casas ()
{
	a1=' ' a2=' ' a3=' ' b1=' ' b2=' ' b3=' ' c1=' ' c2=' ' c3=' '
}

# Exibindo a matriz na tela
_matriz ()
{
	$pos 10 10; echo " $a1 | $a2 | $a3  "
	$pos 11 10; echo "---+---+---"
	$pos 12 10; echo " $b1 | $b2 | $b3  "
	$pos 13 10; echo "---+---+---"
	$pos 14 10; echo " $c1 | $c2 | $c3  "
}

# Exinbindo o painel de placar na tela
_placar ()
{
	$pos 10 30; echo "=============================="
	$pos 11 30; echo "| empate | vitória | derrota |"
	$pos 12 30; echo "=============================="
	$pos 13 30; echo "|    $p0   |    $p1    |    $p2    |"
	$pos 14 30; echo "=============================="
}

# Verificando se as jogadas são válidas
_vJogada ()
{
	case $key in
		# Verifica se a primeira casa esta livre
		1) [ -z $a1 ] && a1=$v && break ;;
		# Verifica se a segunda casa esta livre
		2) [ -z $a2 ] && a2=$v && break ;;
		# Verifica se a terceira casa esta livre
		3) [ -z $a3 ] && a3=$v && break ;;
		# Verifica se a quarta casa esta livre
		4) [ -z $b1 ] && b1=$v && break ;;
		# Verifica se a quinta casa esta livre
		5) [ -z $b2 ] && b2=$v && break ;;
		# Verifica se a sexta casa esta livre
		6) [ -z $b3 ] && b3=$v && break ;;
		# Verifica se a sétima casa esta livre
		7) [ -z $c1 ] && c1=$v && break ;;
		# Verifica se a oitava casa esta livre
		8) [ -z $c2 ] && c2=$v && break ;;
		# Verifica se a nona casa esta livre
		9) [ -z $c3 ] && c3=$v && break ;;
		# Define o status de jogo para finalizar
		q) run=false; break ;;
	esac
}

# Capturando a jogada do jogador principal
_jogador ()
{
	v='X'; while :; do read -s -n1 key; _vJogada; done
}

# Verificando as casas para definir se ataca ou defende
jogadaspc ()
{
	passou=1
	# Primeira linha horizontal
	if   [[ $a1 = $valor && $a2 = $valor && $a3 = ' ' ]];then key='3'
	elif [[ $a1 = $valor && $a3 = $valor && $a2 = ' ' ]];then key='2'
	elif [[ $a3 = $valor && $a2 = $valor && $a1 = ' ' ]];then key='1'

	# Segunda linha horizontal
	elif [[ $b1 = $valor && $b2 = $valor && $b3 = ' ' ]];then key='6'
	elif [[ $b1 = $valor && $b3 = $valor && $b2 = ' ' ]];then key='5'
	elif [[ $b3 = $valor && $b2 = $valor && $b1 = ' ' ]];then key='4'

	# Terceira linha horizontal
	elif [[ $c1 = $valor && $c2 = $valor && $c3 = ' ' ]];then key='9'
	elif [[ $c1 = $valor && $c3 = $valor && $c2 = ' ' ]];then key='8'
	elif [[ $c3 = $valor && $c2 = $valor && $c1 = ' ' ]];then key='7'

	# Primeira linha verticial
	elif [[ $a1 = $valor && $b1 = $valor && $c1 = ' ' ]];then key='7'
	elif [[ $a1 = $valor && $c1 = $valor && $b1 = ' ' ]];then key='4'
	elif [[ $b1 = $valor && $c1 = $valor && $a1 = ' ' ]];then key='1'

	# Segunda linha verticial
	elif [[ $a2 = $valor && $b2 = $valor && $c2 = ' ' ]];then key='8'
	elif [[ $a2 = $valor && $c2 = $valor && $b2 = ' ' ]];then key='5'
	elif [[ $b2 = $valor && $c2 = $valor && $a2 = ' ' ]];then key='2'

	# Terceira linha verticial
	elif [[ $a3 = $valor && $b3 = $valor && $c3 = ' ' ]];then key='9'
	elif [[ $a3 = $valor && $c3 = $valor && $b3 = ' ' ]];then key='6'
	elif [[ $b3 = $valor && $c3 = $valor && $a3 = ' ' ]];then key='3'

	# linhas diagonal
	elif [[ $a1 = $valor && $b2 = $valor && $c3 = ' ' ]];then key='9'
	elif [[ $a1 = $valor && $c3 = $valor && $b2 = ' ' ]];then key='5'
	elif [[ $b2 = $valor && $c3 = $valor && $a1 = ' ' ]];then key='1'
	elif [[ $a3 = $valor && $b2 = $valor && $c1 = ' ' ]];then key='7'
	elif [[ $a3 = $valor && $c1 = $valor && $b2 = ' ' ]];then key='5'
	elif [[ $c1 = $valor && $b2 = $valor && $a3 = ' ' ]];then key='3'
	
	# seguimento para realizar outras validações
	else passou='0'
	fi
}

# Realizando moviemento de ataque na matriz
ataquepc ()
{	
	valor='O'; jogadaspc
	if [[ $passou = 0 ]]; then defesapc; fi
}

# Realizando moviemento de defesa na matriz
defesapc ()
{
	valor='X'; jogadaspc
	if [[ $passou = '0' ]]; then key=$(shuf -i 1-9 -n 1) ; fi
}


# Capturando jogadas do jogador 2 com base na escolha do inicío
_oponente ()
{
	v='O'; while :; do game; _vJogada; done
}

# Verifica se ainda quer jogar após o termino da partida
_continua ()
{
	:  $((p$x++))
	_placar
	$pos 18 10; echo "[1] para continuar"
	$pos 19 10; echo "[2] para sair"
	$pos 20 10; read -p "Digite uma opção: " op
	$pos 20 10; echo "Digite um opção:   "

	case $op in
		1) _casas; _matriz ;;
		2) break ;;
		*) $pos 22 10; echo "digite uma opção váilida"; x='' _continua;;
	esac
}

# Verifica se algun dos jogadores ganhou a partida
_vGanhador ()
{
	# Primeira linha horizontal
	test "$a1" = "$v" -a "$a2" = "$v" -a "$a3" = "$v" && _msgGanhador
	# Secunda linha horizontal
	test "$b1" = "$v" -a "$b2" = "$v" -a "$b3" = "$v" && _msgGanhador
	# Terceira linha horizontal
	test "$c1" = "$v" -a "$c2" = "$v" -a "$c3" = "$v" && _msgGanhador
	# primeira linha vertical
	test "$a1" = "$v" -a "$b1" = "$v" -a "$c1" = "$v" && _msgGanhador
	# Secunda linha vertical
	test "$a2" = "$v" -a "$b2" = "$v" -a "$c2" = "$v" && _msgGanhador
	# Terceira linha vertical
	test "$a3" = "$v" -a "$b3" = "$v" -a "$c3" = "$v" && _msgGanhador
	# Linhas na diagonal
	test "$a1" = "$v" -a "$b2" = "$v" -a "$c3" = "$v" && _msgGanhador
	test "$a3" = "$v" -a "$b2" = "$v" -a "$c1" = "$v" && _msgGanhador
}

# Dados para definir qual o jogador que ganhou a partida
_ganhador ()
{
	x='1' v='X' id='1'; _vGanhador
	x='2' v='O' id='2'; _vGanhador
}

# Verifica se houve empate na partida
_empate ()
{
	# Verifica se todas as casas estão ocupadas
	if	[ ! -z $a1 ] && [ ! -z $a2 ] && [ ! -z $a3 ] &&	\
		[ ! -z $b1 ] && [ ! -z $b2 ] && [ ! -z $b3 ] && \
		[ ! -z $c1 ] && [ ! -z $c2 ] && [ ! -z $c3 ]
	then
		# atualiza os dados da tebela
		let p0++ ; _placar

		# Emite mensagem informando que foi empate
		$pos 16 10; echo "Houve empate"; sleep .8
		$pos 16 10; echo "            "
		x= #_casas; _matriz
		_continua
	fi
}

# Exibe mensagem para ganhador!
_msgGanhador ()
{
	$pos 16 10; echo jogador $id ganhou!; sleep .7
	$pos 16 10; printf ' %.0s' {1..17}; _continua
}

# Realiza configurações para o segundo jogador
_config ()
{
	# Exibe menu para selecionar
	# metodo de entrada do segundo jogador
	$pos 2 10; echo "[1] jogar contra a máquina"
	$pos 3 10; echo "[2] jogar com outra pessoa"
	$pos 4 10; read -p "Digite um opção: " op

	# Configurando o funcionando do segundo jogador
	[[ $op = 1 ]] && game () { ataquepc; }
	[[ $op = 2 ]] && game () { read -s -n1 key; }
}

# Define o metodo de entrada do segundo jogador
_gaming ()
{
	_matriz; _ganhador; _empate; _placar

	$pos 8 10 && echo " jogador = $j"
	sleep .4
}

# Realizando limpeza de tela e exibindo a matriz e tabela de placar
clear; _config; _casasN; _matriz; _placar

sleep 2; _casas

# Funcionamento do game
while $run
do 
	j=1 _gaming && _jogador
	j=2 _gaming && _oponente
done

clear
