*** Settings ***
Documentation       Aqui teremos a estrutura base do projeto

Library     SeleniumLibrary

Library     RequestsLibrary     #Biblioteca de requisições API REST
Library     OperatingSystem     #Biblioteca para abrir o arquivo de imagem (Get Binary File)

Resource    kws.robot
Resource    helpers.robot
Resource    elements.robot

*** Variables ***
${base_url}         http://ninjachef-qaninja-io.umbler.net/
${base_url_api}         http://ninjachef-api-qaninja-io.umbler.net  #URI da API (faclitar o seu reuso)

*** Keywords ***
##Hooks
Open Session
    Open Browser    about:blank     chrome

Close Session
    Capture Page Screenshot
    Close Browser
