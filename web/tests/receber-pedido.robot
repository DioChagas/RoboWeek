*** Settings ***
Documentation       receber pedidos
...                 Sendo um cozinheiro qe já possui um dashboard com pratos
...                 Quero receber solicitação de preparo dos meus pratos
...                 para que eu possa enviar aos meus clientes

Resource        ../resources/base.robot

Test Setup      Open Session
Test Teardown   Close Session


*** Test Cases ***
Receber novo pedido
    Dado que "fulano@bol.com.br" é a minha conta de cozinheiro
    E "esfomeado@bol.com.br" é o email do cliente
    E que "Sopa" está cadastrada no meu dashboard
    Quando o cliente solicita o preparo desse prato
    Entao devo receber uma notificacao de pedido
    E posso aceitar ou rejeitar esse pedido
