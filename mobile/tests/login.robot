*** Settings ***
Documentation           Testes de Login no App NinjaChef

Resource                  ../resources/base.robot

Test Setup          Open Session
Test Teardown       Close Session


*** Test Cases ***
Acessar o cardapio
    Dado que estou com fome e quero comer "Massas"
    Quando submeto o meu email "teste@roboweek.com"
    Entao deve a lista de pratos por tipo



*** Keywords ***
#Aqui ele fará a ação e a verificação
Dado que estou com fome e quero comer "${prato}"
    Set Test Variable       ${prato}    ## Variável Global para execução no escopo do teste para ser usada nas outras Keywords que vão de fato executar o teste
        
Quando submeto o meu email "${email}"
    Wait Until Page Contains        Buscar Prato                    10      #Checkpoint para verificar se a tela exibiu os componentes para as ações
    Input Text                      accessibility_id=emailInput     ${email}
    Input Text                      accessibility_id=plateInput     ${prato}
    Click Text                      Buscar Prato        ##Como o botão não possui acessibilityID e o Xpath é enorme, a ação de click será pelo nome

Entao deve a lista de pratos por tipo
    Wait Until Page Contains        Fome de ${prato}
    