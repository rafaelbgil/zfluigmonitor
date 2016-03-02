#!/bin/bash
#Coletor de informações para template zfluigmonitor no Zabbix
#Autor: Rafael Benites Gil
SERVIDOR_MONITORADO='127.0.0.1';

function ConverterMega(){
        valor_real=$1
                #converter GB em MB
        echo $valor_real | grep GB &> /dev/null
        if test $? -eq "0" ; then
                valor_real=$(echo "$1" | grep -o "[0-9]\{1,\}")
                valor_real=$(($valor_real * 1000));
                valor_real=$(($valor_real * 1000));
                valor_real=$(($valor_real * 1000));
                echo $valor_real
        fi
                #utilizar MB
                echo $valor_real | grep MB &> /dev/null
        if test $? -eq "0" ; then
                valor_real=$(echo $valor_real | grep -o "[0-9]\{1,\}")
                valor_real=$(($valor_real * 1000));
                valor_real=$(($valor_real * 1000));
                echo $valor_real
        fi
                #Converter KB em MB
                echo $valor_real | grep KB &> /dev/null
                if test $? -eq "0" ; then
                valor_real=$(echo "$1" | grep -o "[0-9]\{1,\}")
                valor_real=$(($valor_real * 1000));
                echo $valor_real
        fi
}

case $1 in
                #Triggers
        -d)
                DB_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/databaseAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $DB_DISP; #exibe status do DB
        ;;
        -e)
                EMAIL_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/mailServerAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $EMAIL_DISP; #exibe status do E-MAIL
        ;;
        -s)
                SOLR_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/solrServerAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $SOLR_DISP; #exibe status do SOLR
        ;;
        -n)
                NODE_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/nodeJSAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $NODE_DISP; #exibe status do NODE
        ;;
		-m)
                MEMCACHED_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/memcachedAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $MEMCACHED_DISP; #exibe status do MEMCACHED
        ;;
        -o)
                OPENOFFICE_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/openOfficeServerAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $OPENOFFICE_DISP; #exibe status do OPENOFFICE
        ;;
        -l)
                LS_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/nodeJSAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $LS_DISP; #exibe status do LS
        ;;
        -i)
                IDENTITY_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/identityAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $IDENTITY_DISP; #exibe status do IDENTITY
        ;;
        -g)
                GOODATA_DISP=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/goodDataAvailability" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                echo $GOODATA_DISP; #exibe status do IDENTITY
        ;;

        #Graficos
        -gdbs)
                GRAPH_DBS=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/databaseSize" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                ConverterMega "$GRAPH_DBS";
                ;;

        -gvds)
                GRAPH_VDS=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/volumeDirSize" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                ConverterMega "$GRAPH_VDS";
                ;;
        -gtds)
                GRAPH_TDS=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/templateDirSize" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                ConverterMega "$GRAPH_TDS";
                ;;
        -glds)
                GRAPH_LDS=$(curl -s "http://$SERVIDOR_MONITORADO/monitor/report/logDirSize" | cut -f 2 -d ":" | grep -o '".*"' | sed 's/\"//g');
                ConverterMega "$GRAPH_LDS";
                ;;
        *)
                echo "+================================================================================+";
                echo "# O script zfluigmonitor foi desenvolvido para permitir a coleta de informacoes  #";
                echo "# geradas pelo pacote monitor.war do fluig que pode ser baixado via link abaixo: #";
                echo "+================================================================================+"
                echo ""
                echo "+=====================================================================================================+";
                echo "# http://tdn.totvs.com/display/fluigeng/Fluig+Services+Monitor#MonitordeServi%C3%A7osFluig-AcessoREST #";
                echo "+=====================================================================================================+";
                echo "________________________________________________________________________________"
                echo "# OPCOES:                                                                      #";
                echo "--------------------------------------------------------------------------------";
                echo "| -d : Exibe status de disponibilidade do banco de dados                       |"
                echo "| -e : Exibe status de disponibilidade de email                                |"
                echo "| -s : Exibe status de disponibilidade do indexador solr                       |"
                echo "| -n : Exibe status de disponibilidade do node, utilizado para chat e realtime |"
                echo "| -o : Exibe status de disponibilidade do openoffice                           |"
                echo "| -l : Exibe status de disponibilidade do License Server                       |"
                echo "| -i : Exibe status de disponibilidade do Identity                             |"
                echo "| -g : Exibe status de disponibilidade do Goodata                              |"
		echo "| -gdbs :Exibe valor numerico do tamanho do banco de dados em bytes            |"
		echo "| -gvds :Exibe valor numerico do tamanho do volume em bytes                    |"
		echo "| -glds :Exibe valor numerico do tamanho dos logs em bytes                     |"
		echo "| -gtds :Exibe valor numerico do tamanho dos templates em bytes                |"
                echo "+==============================================================================+"


        ;;
esac
