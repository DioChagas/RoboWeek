*** Settings ***
Documentation       Aqui teremos o mapeamento dos elementos e localizadores



*** Variables ***

# Página de cadastro
${CAMPO_EMAIL}      id:email
${BOTAO_ENTRAR}     css:button[type=submit]
${DIV_ALERT}        class:alert

# Dashboard
${DIV_DASH}             class:dashboard
${BOTAO_ADD}            class:btn-add
${IMAGEM}               css:input[id=thumbnail]
${CAMPO_NOME}           id:name
${CAMPO_TIPO}           id:plate
${CAMPO_VALOR}          id:price
${BOTAO_CADASTRAR}      class:btn-cadastrar

${DIV_LISTA}            class:product-list