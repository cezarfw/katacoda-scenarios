Você é um engenheiro de nuvem responsável por todos os aspectos do Kubernetes no seu
companhia. Os desenvolvedores adotaram a plataforma Kubernetes para todas as suas novas
aplicativos e criaram pipelines para automatizar a implantação de seu código.

Durante um scrum diário, você é informado de que o novo cluster de desenvolvimento foi recentemente liberado para este grupo não está funcionando corretamente. Você pede desculpas pelo inconveniente e comprometa-se a resolver esse problema imediatamente, para que a compilação processos podem retornar ao estado normal.

Você começa verificando se os nós do Kubernetes são saudáveis.
`kubectl get nodes --request-timeout 5s`{{execute}}

Após algum tempo, você recebe uma mensagem de erro. Um tempo limite ou uma conexão recusada.

Seu primeiro instinto, para verificar os nós, identificou uma nova pista. Você não pode
acesse os nós. Depois de um segundo, você percebe que isso significa que o
A API do Kubernetes não está respondendo aos seus comandos, portanto, esse é um problema maior do que um único nó não sendo saudável. Você muda de foco para começar a identificar novas pistas relacionado ao servidor API.

Como a API do Kubernetes não está disponível, os comandos do kubectl não funcionarão. Você deve confie em alguns comandos do tempo de execução do contêiner, neste caso é
Docker. Dê uma olhada nos contêineres no cluster executando alguns comandos do docker.

`docker ps -a`{{execute}}

Você percebe que alguns de seus contêineres estão saindo, o que é outra pista. Qual
um é o problema embora? Você começa com o cérebro dos Kubernetes
máquina. Verifique os logs do docker para o contêiner do servidor API.

Identifique o ID do contêiner do servidor Kube-API copiando-o do
`docker ps -a`{{execute}} comando de cima.

Então execute

`docker logs CONTAINERID_GOES_HERE`

Vemos vários erros como:

`Transport failed to connect to 127.0.0.1:2379`

Esse é o número da porta etcd. Você acredita que o servidor da API não é capaz de ler ou
escreva de etcd. Seu foco muda para ver o que há de errado com o contêiner etcd
que também está em um estado de saída.

Encontre o ID do contêiner etcd em execução

`docker ps -a`{{execute}}

Em seguida, olhe para os logs do contêiner ETCD

`docker logs CONTAINERID_GOES_HERE`

O último log escrito por etcd parece ser a pista final que você precisava para resolver o
questão.

`/etc/kubernetes/pki/etcd/wrongca.crt: no such file or directory`

Parece que etcd não consegue encontrar o certificado da autoridade.No editor, abra o
arquivo etcd.yaml no diretório de manifestos.Atualize o caminho do certificado da CA para
`/etc/kubernetes/pki/etcd/ca.crt`.

Como o contêiner ETCD é uma vagem estática, o Kubelet iniciará o contêiner
logo após a configuração ser corrigida.Uma vez iniciado o contêiner ETCD
com sucesso a API Kubernetes deve voltar e o seguinte comando
vai funcionar novamente.

> Nota: Isso pode demorar um momento.Você pode executar novamente o comando abaixo conforme necessário até
> os nós aparecem.

`kubectl get nodes`{{execute}}