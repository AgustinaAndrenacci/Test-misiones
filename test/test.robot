*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs
# Importa tu archivo Python como una librería para usar la función get_chrome_options
Library    InternetOculto.py
Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Portal Leandro git/Test-Portal-main/Resources/EmbedScreenshotLibrary.py
Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

*** Variables ***
${URL}               https://tsgqa.digitrack.com.ar/auth/signin
${BROWSER}           Chrome
${USERNAME}          tu_usuario@ejemplo.com
${PASSWORD}          TuContraseñaSegura


*** Test Cases ***
Login
    # Usa la keyword robusta para abrir el navegador
    Abrir Navegador en modo incognito
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  gestion  admin123  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de  ${tituloPagina}  No se pudo iniciar sesion

*** Keywords ***
Verificar presencia de... con...
    [Arguments]    ${campo_localizador}    ${frase_texto}

    #Verificar el texto esperado
    ${status_texto}=    Run Keyword And Return Status    Wait Until Page Contains    ${frase_texto}

    #Obtener el texto real del elemento
    ${texto_real}=    Run Keyword And Ignore Error    Get Text    ${campo_localizador}
    #Para que solo muestre la frase
    ${texto_real}=    Set Variable    ${texto_real}[1]

    #mensajes
    Run Keyword If    ${status_texto}
    ...    Log    ÉXITO: El mensaje "${frase_texto}" fue encontrado.
    ...    ELSE
    ...    Fail    FALLO: No se encontró la frase esperada "${frase_texto}", sino que apareció: "${texto_real}".
