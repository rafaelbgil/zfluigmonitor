# zfluigmonitor
Template de monitoramento do Fluig Totvs via Zabbix obtendo informações do pacotes monitor.war do Fluig.

Descrição: Template criado com o objetivo de obter informações de monitoramento do Fluig gerados pelo pacote monitor.war.

Atualmente o template monitora os seguintes itens:
- Disponibilidade do Banco de Dados
- Disponibilidade de E-mail
- Disponibilidade do Indexador Solr
- Disponibilidade do Recurso de Chat/Realtime provido pelo serviço node
- Disponibilidade do Openoffice
- Disponibilidade do License Server
- Disponibilidade do Identity
- Disponibilidade do Analytics (Goodata)

Gera os seguintes Gráficos
- Tamanho do Banco de Dados
- Tamanho do Volume do Fluig
- Tamanho dos Logs
- Tamanho dos Templates

Para informações sobre configuração e instalação do template acesse: https://github.com/rafaelbgil/zfluigmonitor/wiki
