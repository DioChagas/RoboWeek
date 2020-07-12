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
    