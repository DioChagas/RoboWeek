*** Settings ***
Documentation       Aqui teremos palavras chaves de apoio

*** Keywords ***
Login Session
    [Arguments]     ${email}

    base.Open Session

    Go To       ${base_url}
    
    Input Text      ${CAMPO_EMAIL}        ${email}
    Click Element   ${BOTAO_ENTRAR}

    Wait Until Page Contains Element    ${DIV_DASH}

Get Api Login
    [Arguments]     ${email_param}

    &{headers}=             Create Dictionary           Content-Type=application/json   ## Dicionário de dados com os Headers
    &{payload}=             Create Dictionary           email=${email_param}       ## Dicionário de dados com os dados no 'Body' da requisição 

    ##  Criar sessão para captura do token do cozinheiro
    Create Session      api                 ${base_url_api}
    ${resp}=            Post Request        api         /sessions       data=${payload}         headers=${headers}
    Status Should Be    200                 ${resp}

    ${token}     Convert To String      ${resp.json()['_id']}    # Capturando o Token (id) para utilizar no contexto geral do teste
    [Return]       ${token}                             # Informando que esta variável será usada em mais de um contexto dentro do teste
