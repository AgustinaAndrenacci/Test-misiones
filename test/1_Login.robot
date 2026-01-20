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


***Test Cases***
#Login ciudadano --------------------------------------------------------------------------
Login Ciudadano - Correcto
    [Documentation]    Se inicia sesion con un usuario ciudadano
    [tags]    test_01
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de  ${tituloPagina1}  No se pudo iniciar sesion


Login Ciudadano - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    [tags]    test_02
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    [tags]    test_03
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    [tags]    test_04
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - con cuit menor a 7 digitos
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un cuit menor a 7 digitos
    [tags]    test_05
    Iniciar sesion  ${userFake7}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

Login Ciudadano - con cuit mayor a 12 digitos
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un cuit mayor a 7 digitos
    [tags]    test_06
    Iniciar sesion  ${userFake12}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

Login Ciudadano - cuit con dato no numerico
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un dato string en el campo cuit
    [tags]    test_07
    Iniciar sesion  cuitInvalido  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT solo debe contener números

#Login personal-------------------------------------------------------------------------------
Login Personal - Correcto
    [Documentation]    Se inicia sesion con un usuario del personal
    [tags]    test_08
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${userAdmin}  ${passAdmin}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de  ${tituloPagina2}  No se pudo iniciar sesion

Login Personal - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    [tags]    test_09
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    [tags]    test_10
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    [tags]    test_11
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

#Cerrar sesion -------------------------------------------------------------------------
Cerrar sesion
    [Documentation]    Se loguea con un usuario y se comprueba si se cierra sesion
    [tags]    test_12
    #Iniciar sesion
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar presencia de  ${tituloPagina1}  No se pudo iniciar sesion

    #Cerrar sesion
    Validar y hacer clic en el boton  ${circuloUsuario}  historial
    Validar y hacer clic en el boton  ${cerrarSesion}  historial
    Verificar presencia de  ${loginFrase}  No se pudo iniciar sesion

#Valido los placeholder ---------------------------------------------------------------------
PlaceHolder cuit
    [Documentation]    Se verifica si el campo cuit tiene el placeholder correcto
    [tags]    test_13
    Element Attribute Value Should Be    ${campoCuit}    placeholder    20201112220

PlaceHolder clave fiscal
    [Documentation]    Se verifica si el campo clave fiscal tiene el placeholder correcto
    [tags]    test_14
    Element Attribute Value Should Be    ${campoClaveFiscal}    placeholder    Ingrese su clave fiscal

PlaceHolder mail
    [Documentation]    Se verifica si el campo mail tiene el placeholder correcto
    [tags]    test_15
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Element Attribute Value Should Be    ${campoMail}    placeholder    admin o admin@municipio.gov.ar

PlaceHolder contraseña
    [Documentation]    Se verifica si el campo contraseña tiene el placeholder correcto
    [tags]    test_16
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestaña personal
    Element Attribute Value Should Be    ${campoPass}    placeholder    Ingrese su contraseña
