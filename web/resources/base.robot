*** Settings ***
Documentation       Aqui teremos a estrutura base do projeto

Library     SeleniumLibrary

Resource    kws.robot
Resource    helpers.robot
Resource    elements.robot

*** Variables ***
${base_url}         http://ninjachef-qaninja-io.umbler.net/


*** Keywords ***
##Hooks
Open Session
    Open Browser    about:blank     chrome

Close Session
    Capture Page Screenshot
    Close Browser
