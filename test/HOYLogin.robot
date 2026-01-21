*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

#Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/EmbedScreenshotLibrary.py
#Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/InternetOculto.py

Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Misiones/Resources/EmbedScreenshotLibrary.py
Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Misiones/Resources/InternetOculto.py

Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

Test Teardown  Cerrar navegador



***Test Cases***
#Login ciudadano --------------------------------------------------------------------------
Login Ciudadano - Correcto
    [Documentation]    Se inicia sesion con un usuario ciudadano
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de  ${tituloPagina1}  No se pudo iniciar sesion

Login Ciudadano - Incorrecto
    [Documentation]    Se inicia sesion con un usuario ciudadano incorrecto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    ${texto_sucio}=    Get Text    xpath=//div[@role='alert']
    # Esto convierte los \n en espacios simples
    ${texto_limpio}=    Evaluate    " ".join($texto_sucio.split())
    Log    Texto capturado: ${texto_limpio}
    Should Be Equal    ${texto_limpio}    CUIT o Clave Fiscal incorrectos Recuerde que para ingresar debe poseer una Clave Fiscal válida en ATM

Login Ciudadano - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Ciudadano - con cuit menor a 7 digitos
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un cuit menor a 7 digitos
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake7}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

Login Ciudadano - cuit con dato no numerico
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un dato string en el campo cuit
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  cuitInvalido  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT solo debe contener números

#Login personal-------------------------------------------------------------------------------
Login Personal - Correcto
    [Documentation]    Se inicia sesion con un usuario del personal
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de  ${tituloPagina3}  No se pudo iniciar sesion

Login Personal - Incorrecto
    [Documentation]    Se inicia sesion con un usuario del personal incorrecto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userFake}  ${passFake}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Usuario o contraseña incorrectos.

Login Personal - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Login Personal - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

#Cerrar sesion -------------------------------------------------------------------------
Cerrar sesion desde ciudadano
    [Documentation]    Se loguea con un usuario y se comprueba si se cierra sesion
    Asignar Tag Numerado
    #Iniciar sesion
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}

    #Cerrar sesion
    Validar y hacer clic en el boton  ${circuloUsuario}  circuloUsuario
    Validar y hacer clic en el boton  ${cerrarSesion}  boton cerrar sesion
    Verificar presencia de  //h3[normalize-space()='Acceso Ciudadanos']  No se pudo iniciar sesion

Cerrar sesion desde personal
    [Documentation]    Se loguea con un usuario y se comprueba si se cierra sesion
    Asignar Tag Numerado
    #Iniciar sesion
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas

    #Cerrar sesion
    Validar y hacer clic en el boton  ${circuloUsuario}  circuloUsuario
    Validar y hacer clic en el boton  ${cerrarSesion}  boton cerrar sesion
    Verificar presencia de  //h3[normalize-space()='Acceso Personal']  No se pudo iniciar sesion

#Valido los placeholder ---------------------------------------------------------------------
PlaceHolder cuit - ciudadano
    [Documentation]    Se verifica si el campo cuit tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Element Attribute Value Should Be    ${campoCuit}    placeholder    20201112220

PlaceHolder clave fiscal - ciudadano
    [Documentation]    Se verifica si el campo clave fiscal tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Element Attribute Value Should Be    ${campoClaveFiscal}    placeholder    Ingrese su clave fiscal

PlaceHolder mail - personal
    [Documentation]    Se verifica si el campo mail tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Abrir Navegador en modo incognito    ${pagePersonal}
    Element Attribute Value Should Be    ${campoMail}    placeholder    admin o admin@municipio.gov.ar

PlaceHolder contraseña - personal
    [Documentation]    Se verifica si el campo contraseña tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Abrir Navegador en modo incognito    ${pagePersonal}
    Element Attribute Value Should Be    ${campoPass}    placeholder    Ingrese su contraseña
