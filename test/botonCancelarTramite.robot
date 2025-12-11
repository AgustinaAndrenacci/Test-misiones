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

*** Variables ***
${botonSubirDocCom}    //button[normalize-space()='Subir']
${subirArchivoDocCom}    //input[@id='file-upload']
${botonSubirDocumentoDocCom}    //button[normalize-space()='Subir Documento']
${tramite}    TRAM-0412/2025
${campoDescripcionDocCom}    //textarea[@id='description']
${botonCancelarDocCom}    //button[normalize-space()='Cancelar']
${espacioDeArchivosDocCom}    //div[@class='flex flex-col flex-1']//main
${botonEliminarDocCom}    //button[@title='Eliminar']
${botonEliminarDocumentoDocCom}    //button[normalize-space()='Eliminar Documento']


*** Test Cases ***
Test X - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonNotaFormal}    botonNotaFormal
    Validar y completar campo    ${asuntoNotaFormal}  Asunto test2    asuntoNotaFormal
    Validar y completar campo    ${detalleNotaFormal}  Descripcion test2  detalleNotaFormal
    Validar y completar campo    ${contenidoNotaFormal}  Contenido test2  contenidoNotaFormal
    Verificar y presionar ítem en lista    ${select}    Poder/Representación
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}