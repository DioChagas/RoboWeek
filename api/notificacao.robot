*** Settings ***
Documentation       Aqui ficará o teste de solicitação de preparo do prato

*** Test Cases ***
Push notification
    Dado que eu tenho pratos cadastrados
    Quando o cliente solicita o preparo de um dos meus pratos
    Entao devo receber uma notificacao de preparo
    E posso aceitar ou rejeitar essa notificacao