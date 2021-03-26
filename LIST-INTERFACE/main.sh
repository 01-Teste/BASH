#!/bin/bahs

Desenvolvedor: Rafael Silva Santos
Descrição: script para listar informações das interfaces de rede

# depedências
DIR="/home/rafael/NET/"
source $DIR/vars/variaves && source $DIR/moduls/mod

# Programa
while true; do clear; MENU && if [ -z $OP1 ]; then echo ""; echo $MSG1; sleep 1

    elif [ $OP1 = 1 ]; then while true; do clear; MENU2

            if [ -z $OP2 ]; then echo ""; echo $MSG2; sleep 1
            elif [ $OP2 = 1 ]; then echo -e $MSG3; read ETH && if [ -z $ETH ]; then echo ""; echo $MSG4; sleep 1; clear; else clear; ifconfig $ETH; SAIR; fi
            elif [ $OP2 = 0 ]; then sleep 1; clear; break; else echo ""; echo $MSG4; sleep 1; fi
            
        done

    elif [ $OP1 = 0 ]; then sleep 1; clear; break; else echo ""; echo $MSG4; sleep 1; fi
    
done
