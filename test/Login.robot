*** Settings ***
Documentation     Se realizan testeos creando tramites verificando si el flujo, los estados, los botones funciona de manera correcta.
...
...               Se realizaron las siguientes pruebas:
...
...               -Test 1: Se prueba el Login Correcto en la parte del ciudadano
...
...               -Test 2: Se prueba el Login Incorrecto en la parte del ciudadano
...
...               -Test 3: Se prueba el Login sin completar campos en la parte del ciudadano
...
...               -Test 4: Se prueba el Login sin completar la pass en la parte del ciudadano
...
...               -Test 5: Se prueba el Login sin completar la pass en la parte del ciudadano
...
...               -Test 6: Se prueba el Login con un Cuit menor a 7digitos en la parte del ciudadano
...
...               -Test 7:Se prueba el Login con un Cuit no numerico en la parte del ciudadano
...
...               -Test 8: Se prueba el Login Correcto en la parte del personal
...
...               -Test 9: Se prueba el Login Incorrecto en la parte del personal
...
...               -Test 10: Se prueba el Login sin completar campos en la parte del personal
...
...               -Test 11: Se prueba el Login sin completar la pass en la parte del personal
...
...               -Test 12: Se prueba el Login sin completar la pass en la parte del personal
...
...               -Test 13: Se prueba cerrar sesion desde ciudadano
...
...               -Test 14: Se prueba cerrar sesion desde personal
...
...               -Test 15: Desde el ciudadano se cheuqea que el PlaceHolder cuit sea correcto
...
...               -Test 16: Desde el ciudadano se cheuqea que el PlaceHolder clave fiscal sea correcto
...
...               -Test 17: Desde el personal se cheuqea que el PlaceHolder mail sea correcto
...
...               -Test 18: Desde el personal se cheuqea que el PlaceHolder contraseña sea correcto


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
Test 1 - Login Ciudadano - Correcto
    [Documentation]    Se inicia sesion con un usuario ciudadano
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de  ${tituloPagina1}  No se pudo iniciar sesion

Test 2 - Login Ciudadano - Incorrecto
    [Documentation]    Se inicia sesion con un usuario ciudadano incorrecto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    ${texto_sucio}=    Get Text    xpath=//div[@role='alert']
    # Esto convierte los \n en espacios simples
    ${texto_limpio}=    Evaluate    " ".join($texto_sucio.split())
    Log    Texto capturado: ${texto_limpio}
    Should Be Equal    ${texto_limpio}    CUIT o Clave Fiscal incorrectos Recuerde que para ingresar debe poseer una Clave Fiscal válida en ATM

Test 3 - Login Ciudadano - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Test 4 - Login Ciudadano - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Test 5 - Login Ciudadano - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Test 6 - Login Ciudadano - con cuit menor a 7 digitos
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un cuit menor a 7 digitos
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  ${userFake7}  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT debe tener entre 8 y 11 dígitos

Test 7 - Login Ciudadano - cuit con dato no numerico
    [Documentation]    Se comprueba si no se loguea cuando se ingresa un dato string en el campo cuit
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Iniciar sesion  cuitInvalido  ${passFake}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  El CUIT solo debe contener números

#Login personal-------------------------------------------------------------------------------
Test 8 - Login Personal - Correcto
    [Documentation]    Se inicia sesion con un usuario del personal
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de  ${tituloPagina3}  No se pudo iniciar sesion

Test 9 - Login Personal - Incorrecto
    [Documentation]    Se inicia sesion con un usuario del personal incorrecto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userFake}  ${passFake}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Usuario o contraseña incorrectos.

Test 10 - Login Personal - sin completar campos
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario y la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${EMPTY}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Test 11 - Login Personal - sin completar el user
    [Documentation]    Se comprueba si no se loguea cuando no se completa el usuario
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${EMPTY}  ${passFake}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

Test 12 - Login Personal - sin completar la pass
    [Documentation]    Se comprueba si no se loguea cuando no se completa la contraseña
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Iniciar sesion  ${userFake}  ${EMPTY}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Verificar presencia de... con...  ${leyendaIniciarSesion}  Por favor complete todos los campos

#Cerrar sesion -------------------------------------------------------------------------
Test 13 - Cerrar sesion desde ciudadano
    [Documentation]    Se loguea con un usuario y se comprueba si se cierra sesion
    Asignar Tag Numerado
    #Iniciar sesion
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}

    #Cerrar sesion
    Validar y hacer clic en el boton  ${circuloUsuario}  circuloUsuario
    Validar y hacer clic en el boton  ${cerrarSesion}  boton cerrar sesion
    Verificar presencia de  //h3[normalize-space()='Acceso Ciudadanos']  No se pudo iniciar sesion

Test 14 - Cerrar sesion desde personal
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
Test 15 - PlaceHolder cuit - ciudadano
    [Documentation]    Se verifica si el campo cuit tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Element Attribute Value Should Be    ${campoCuit}    placeholder    20201112220

Test 16 - PlaceHolder clave fiscal - ciudadano
    [Documentation]    Se verifica si el campo clave fiscal tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Element Attribute Value Should Be    ${campoClaveFiscal}    placeholder    Ingrese su clave fiscal

Test 17 - PlaceHolder mail - personal
    [Documentation]    Se verifica si el campo mail tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Abrir Navegador en modo incognito    ${pagePersonal}
    Element Attribute Value Should Be    ${campoMail}    placeholder    admin o admin@municipio.gov.ar

Test 18 - PlaceHolder contraseña - personal
    [Documentation]    Se verifica si el campo contraseña tiene el placeholder correcto
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pagePersonal}
    Abrir Navegador en modo incognito    ${pagePersonal}
    Element Attribute Value Should Be    ${campoPass}    placeholder    Ingrese su contraseña