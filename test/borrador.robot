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

Test Setup    Abrir Navegador en modo incognito
Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

#IMPORTANTE **************************************************************************************************
#Leandro: ${FILE}
#Agustina: ${FILE2}
#************************************************************************************************************

#Agregar acciones que no van
#Ver que no funciona seleccionar la flecha

***Test Cases***
Excencion Impuesto Sobre los Ingresos Brutos: Verificacion de datos
    [Documentation]    Desde el ciudadano, se verifica que los datos de los campos sean correctos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    //a[normalize-space()='Continuar Borrador']    abrirPrimerTramite

    #chequeo que los campos esten corretos
    Verificar Contenido De Campos    ${idAsuntoNotaFormal}  Asunto  Asunto test02
    Verificar Contenido De Campos    ${idDetalleNotaFormal}  Descripcion  Descripcion test02
    Verificar Contenido De Campos    ${idContenidoNotaFormal}  Contenido  Contenido test02

Excencion Impuesto Sobre los Ingresos Brutos: modificacion de datos
    [Documentation]    Desde el ciudadano, se modifican los datos del tramite
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    //a[normalize-space()='Continuar Borrador']    abrirPrimerTramite

    #borro y actualizo los datos
    Validar y completar campo    ${asuntoNotaFormal}  Asunto    asunto
    Validar y completar campo    ${detalleNotaFormal}  Descripcion  detalle
    Validar y completar campo    ${contenidoNotaFormal}  Contenido  contenido
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonActualizarBorrador}    boton actualizar borrador
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Excencion Impuesto Sobre los Ingresos Brutos: verificacion de los datos del tramite
    [Documentation]    Desde el ciudadano, se verifica si los datos son correctos del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    //a[normalize-space()='Continuar Borrador']    abrirPrimerTramite

    #chequeo que los campos esten corretos
    Verificar Contenido De Campos    ${idAsuntoNotaFormal}  Asunto  Asunto
    Verificar Contenido De Campos    ${idDetalleNotaFormal}  Descripcion  Descripcion
    Verificar Contenido De Campos    ${idContenidoNotaFormal}  Contenido  Contenido


Excencion Impuesto Sobre los Ingresos Brutos: pasar de borrador a guardado
    [Documentation]    Desde el ciudadano, se guarda el tramite asi deja de ser borrador
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    //a[normalize-space()='Continuar Borrador']    abrirPrimerTramite

    Validar y hacer clic en el boton    ${botonContinuarBorrador}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s