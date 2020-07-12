*** Settings ***
Documentation       Suite dos Testes de cadastros

Resource        ../resources/base.robot


Test Setup      Open Session
Test Teardown   Close Session

*** Test Cases ***
Cadastro Simples
    Dado que acesso a pagina principal
    Quando submeto o meu email "fulano@gmail.com"
    Entao devo ser autenticado

Email incorreto
    Dado que acesso a pagina principal
    Quando submeto o meu email "fulano$hotmail.com"
    Entao devo ver a mensagem "Oops. Informe um email válido!"


Email não informado
    Dado que acesso a pagina principal
    Quando submeto o meu email "${EMPTY}"
    Entao devo ver a mensagem "Oops. Informe um email válido!"




