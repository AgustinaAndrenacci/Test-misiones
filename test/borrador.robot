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
Excencion Impuesto Sobre los Ingresos Brutos: crear tramite como borrador [ciudadano]
    [Documentation]    El ciudadano crea un tramite de Excencion Impuesto Sobre los Ingresos Brutos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${botonExencionImpuestoSobreLosIngresosBrutos}
    Validar y completar campo    ${asuntoExencionImpuestoSobreLosIngresosBrutos}  Asunto test0    asuntoExencionImpuestoSobreLosIngresosBrutos
    Validar y completar campo    ${detalleExencionImpuestoSobreLosIngresosBrutos}  Descripcion test0  detalleExencionImpuestoSobreLosIngresosBrutos
    Validar y completar campo    ${contenidoImpuestoSobreLosIngresosBrutos}  Contenido test0  contenidoExencionImpuestoSobreLosIngresosBrutos

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Excencion Impuesto Sobre los Ingresos Brutos: pasar de borrador a guardado
    [Documentation]    Desde el ciudadano, se entra al tramite y se guarda para que deje de estar en borrador
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${tramiteBorrador}    abrirPrimerTramite

    #chequeo que los campos esten corretos
    Verificar Contenido De Campos    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    Asunto test0
    Verificar Contenido De Campos    ${detalleExencionImpuestoSobreLosIngresosBrutos}    Descripcion test0
    Verificar Contenido De Campos    ${contenidoImpuestoSobreLosIngresosBrutos}    Contenido test0

    #borro y actualizo los datos
    Validar y completar campo    ${asuntoExencionImpuestoSobreLosIngresosBrutos}  Asunto    asuntoExencionImpuestoSobreLosIngresosBrutos
    Validar y completar campo    ${detalleExencionImpuestoSobreLosIngresosBrutos}  Descripcion  detalleExencionImpuestoSobreLosIngresosBrutos
    Validar y completar campo    ${contenidoImpuestoSobreLosIngresosBrutos}  Contenido  contenidoExencionImpuestoSobreLosIngresosBrutos
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonActualizarBorrador}    boton actualizar borrador

    #guardo
    Validar y hacer clic en el boton    ${botonContinuarBorrador}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s