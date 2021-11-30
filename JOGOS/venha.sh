!/bin/bash

# jogo da velha

pos="tput cup"

a1=' ' a2=' ' a3=' ' b1=' ' b2=' ' b3=' ' c1=' ' c2=' ' c3=' '

_matriz()
    {
    $pos 10 10; echo " $a1 | $a2 | $a3  "
    $pos 11 10; echo "---+---+---"
    $pos 12 10; echo " $b1 | $b2 | $b3  "
    $pos 13 10; echo "---+---+---"
    $pos 14 10; echo " $c1 | $c2 | $c3  "
    }   
_vJogada()
    {
    case $key in
        1) [[ $a1 = ' ' ]] && a1=$v && break ;;
        2) [[ $a2 = ' ' ]] && a2=$v && break ;;
        3) [[ $a3 = ' ' ]] && a3=$v && break ;;
        4) [[ $b1 = ' ' ]] && b1=$v && break ;;
        5) [[ $b2 = ' ' ]] && b2=$v && break ;;
        6) [[ $b3 = ' ' ]] && b3=$v && break ;;
        7) [[ $c1 = ' ' ]] && c1=$v && break ;;
        8) [[ $c2 = ' ' ]] && c2=$v && break ;;
        9) [[ $c3 = ' ' ]] && c3=$v && break ;;
        q) break ; break ;;
    esac
    }
_jogador()
    {
    v='X'

    while [ 1 ]
    do
        read -s -n 1 key && _vJogada
        sleep .03
    done
    }
_oponente()
    {
    v='O'

    while [ 1 ]; do
        eval $game && _vJogada
        sleep .03
    done
    }
_vGanhador()
    {
    if [[ $a1 = $v ]] && [[ $a2 = $v ]] && [[ $a3 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $b1 = $v ]] && [[ $b2 = $v ]] && [[ $b3 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $c1 = $v ]] && [[ $c2 = $v ]] && [[ $c3 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $a1 = $v ]] && [[ $b1 = $v ]] && [[ $c1 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $a2 = $v ]] && [[ $b2 = $v ]] && [[ $c2 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $a3 = $v ]] && [[ $b3 = $v ]] && [[ $c3 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $a1 = $v ]] && [[ $b2 = $v ]] && [[ $c3 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    elif [[ $a3 = $v ]] && [[ $b2 = $v ]] && [[ $c1 = $v ]]; then
        $pos 20 10 ; echo jogador $id ganhou!
    fi
    }
_ganhador()
    {
    v='X' id='1'; _vGanhador
    v='O' id='2'; _vGanhador
    }

_matriz

$pos 10 30 ; echo "[1] jogar contra a máquina"
$pos 11 30 ; echo "[2] jogar com outra pessoa"
$pos 12 30 ; read -p "digite um opção: " op

if [[ $op = 1 ]]; then
    game='key=$(shuf -i 1-9 -n 1)'
elif [[ $op = 2 ]]; then
    game='read -s -n1 key'
fi

while [ 1 ]
do
    _matriz; _ganhador; _jogador; \
    _matriz; _ganhador; _oponente
done
