*** Settings ***
Documentation       Cadastro de Produtos/Pratos
...                 Sendo um cozinheiro amador
...                 Quero cadastrar meus melhores pratos
...                 Para que eu possa cozinha-los para outras pessoas


Resource        ../resources/base.robot
Resource        ../resources/helpers.robot


Test Setup      Login Session       fulano@email.com
Test Teardown   Close Session

***Variables***
## Objeto do tipo dicionário (Conjuto de dados com 'chave=valor')
&{pizza}        img=pizza.jpg    nome=Pizza Frango ao Catupiry       tipo=Massas      preco=20.00



*** Test Cases ***
## Variável simples é definida por "${nome}"
Novo Prato
    Dado que "${pizza}" é um dos meus pratos
    Quando faco o cadastro desse item
    Então devo ver este prato no meu dashboard
