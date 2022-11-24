*** Settings ***
Library    Collections
Library    String

*** Variables ***
${HOST}    https://pokeapi.co/api/v2/pokemon-color/

*** Keywords ***
Consulta de Pokemon
   Verificar cor    red
   Verificar id    1     
   Conferir Status Code    200

Verificar cor
   [Arguments]      ${COR}
   Create Session    pokeAPI    ${HOST}${COR}
   ${RESPOSTA}=  GET On Session   pokeAPI   ${HOST}${COR}
   Set Test Variable         ${RESPOSTA}
   Dictionary Should Contain Item   ${RESPOSTA.json()}    name   ${COR}

Verificar id 
   [Arguments]     ${URL}
   ${URL_Int}=   Convert To Integer    ${URL}
   Create Session    pokeAPI    ${HOST}${URL_Int}
   ${RESPOSTA_ID}=    GET On Session   pokeAPI    ${HOST}${URL_Int}
   Log    ${RESPOSTA_ID}
   Set Test Variable    ${RESPOSTA_ID}
   Dictionary Should Contain Item    ${RESPOSTA_ID.json()}   id    ${URL_Int}

Conferir Status Code
   [Arguments]   ${STATUS_CODE}
   Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUS_CODE}
   Should Be Equal As Strings    ${RESPOSTA_ID.status_code}   ${STATUS_CODE}