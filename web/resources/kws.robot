*** Settings ***
Documentation       Aqui teremos todas as palavras chaves de automatização dos comportamentos


*** Keywords ***
Dado que acesso a pagina principal
    Go To       ${base_url} 
    
# Cadastro/Login usuário
Quando submeto o meu email "${email}"
    Input Text      ${CAMPO_EMAIL}        ${email}
    Click Element   ${BOTAO_ENTRAR}

Entao devo ser autenticado
    Wait Until Page Contains Element    ${DIV_DASH}

# ==== MSG. PADRÃO PARA CASOS DE INSUCESSO ====    
Entao devo ver a mensagem "${expect_message}"
    Wait Until Element Contains     ${DIV_ALERT}     ${expect_message}



# Cadastro de Pratos

Dado que "${produto}" é um dos meus pratos
    ## Palavras chaves do Selenium com Iniciais Sempre Maiúsculas  ;)
    Set Test Variable       ${produto}

Quando faco o cadastro desse item
# Aguardar o botão de add produto aparecer na tela
    Wait Until Element Is Visible       ${BOTAO_ADD}       5

    Click Element                       ${BOTAO_ADD}
# Pego a imagem no diretório
    Choose File                         ${IMAGEM}         ${EXECDIR}/resources/images/${produto['img']}

## Preenchimento de todos os dados
    Input Text          ${CAMPO_NOME}           ${produto['nome']}
    Input Text          ${CAMPO_TIPO}           ${produto['tipo']}
    Input Text          ${CAMPO_VALOR}          ${produto['preco']}

## Aguarda a imagem ser carregada    
    Wait Until Page Contains Element    ${IMAGEM}   5

## Clique no botão de cadastrar
    Click Element       ${BOTAO_CADASTRAR}
Então devo ver este prato no meu dashboard
    Wait Until Element Contains     ${DIV_LISTA}      ${produto['nome']}
    

################################################    API     ################################################

## Keywords do Cenário: Receber novo pedido

Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}
    ${token_cozinheiro}=    Get Api Login       ${email_cozinheiro}

    Set Test Variable       ${token_cozinheiro}     # Informando que esta variável será usada em mais de um contexto dentro do teste

    ##  Criar sessão para captura do token do cliente
E "${email_cliente}" é o email do cliente
    Set Test Variable       ${email_cliente}
    ${token_cliente}=       Get Api Login       ${email_cliente}
    
    Set Test Variable       ${token_cliente}                                # Informando que esta variável será usada em mais de um contexto dentro do teste


E que "${produto}" está cadastrada no meu dashboard
    Set Test Variable       ${produto}

    &{payload}=             Create Dictionary       name=${produto}     plate=Tipo      price=10.50       ## Dicionário de dados com os dados no 'Body' da requisição 
    
    ${image_file}=          Get Binary File         ${EXECDIR}/resources/images/sopa.jpg
    &{files}=               Create Dictionary       thumbnail=${image_file}

    &{headers}=             Create Dictionary       user_id=${token_cozinheiro}   ## Dicionário de dados com os Headers

    Create Session      api                 ${base_url_api}
    ${resp}=            Post Request        api         /products       files=${files}       data=${payload}         headers=${headers}
    Status Should Be    200                 ${resp}

    ${produto_id}     Convert To String      ${resp.json()['_id']}    # Capturando o Token (id) para utilizar no contexto geral do teste
    Set Test Variable       ${produto_id}                             # Informando que esta variável será usada em mais de um contexto dentro do teste

    ##Login como cozinheiro para que seja possível acompanhar a notificação chegando em tempo real (via "ação do usuário")
    Go To       ${base_url}
    
    Input Text      ${CAMPO_EMAIL}        ${email_cozinheiro}
    Click Element   ${BOTAO_ENTRAR}

    Wait Until Page Contains Element    ${DIV_DASH}


Quando o cliente solicita o preparo desse prato
    
    &{headers}=             Create Dictionary           Content-Type=application/json   user_id=${token_cliente}   ## Dicionário de dados com os Headers
    &{payload}=             Create Dictionary           payment=Dinheiro       ## Dicionário de dados com os dados no 'Body' da requisição 

    Create Session      api                 ${base_url_api}
    ${resp}=            Post Request        api         /products/${produto_id}/orders       data=${payload}         headers=${headers}
    Status Should Be    200                 ${resp}



Entao devo receber uma notificacao de pedido
    ${mensagem_esperada}            Convert To String       ${email_cliente} está solicitando o preparo do seguinte prato: ${produto}
    Wait Until Page Contains        ${mensagem_esperada}    5

E posso aceitar ou rejeitar esse pedido
    Wait Until Page Contains        ACEITAR         5
    Wait Until Page Contains        REJEITAR        5