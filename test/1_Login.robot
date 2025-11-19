***Settings***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

#modificar
Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Portal Leandro git/Test-Portal-main/Resources/EmbedScreenshotLibrary.py
Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

Test Setup     Abrir navegador
Test Teardown  Cerrar navegador

*** Variables ***
${CHROME_OPTIONS}    chrome_options=args:['--incognito']

***Test Cases***
#Login ciudadano --------------------------------------------------------------------------
Login Ciudadano - Correcto
    [Documentation]    Iniciar sesion con datos correctos
    [tags]    test_02
    Iniciar sesion  ${userCiudadano}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de  ${tituloPagina}  No se pudo iniciar sesion

Login Ciudadano - sin completar campos
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar el user
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar la pass
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - con cuit menor a 7 digitos
    Iniciar sesion  ${userFake7}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

#!
Login Ciudadano - con cuit mayor a 12 digitos
    Iniciar sesion  ${userFake12}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

Login Ciudadano - cuit con dato no numerico
    Iniciar sesion  cuitInvalido  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT solo debe contener números

#Login personal-------------------------------------------------------------------------------
Login Personal - Correcto
    [Documentation]    Iniciar sesion con datos correctos
    [tags]    test_02
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${userAdmin}  ${passAdmin}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de  ${tituloPagina}  No se pudo iniciar sesion

Login Personal - sin completar campos
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar el user
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar la pass
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Cerrar sesion

#Ver los msj que tiene el campo - PlaceHolder
#Ver si entro con un user del otro que pasa
#cerrar sesion
#acomodar la parte de variables

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

Configuracion
    Abrir navegador
    Set Selenium Speed    0.1s
