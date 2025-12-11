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

#-----------------------------------------------------------------------------------------------
#////////Jpeg
Test X - Nota formal: se agrega documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubirDocCom}    boton subir
    Choose file    ${subirArchivoDocCom}    ${FILEjpeg}
    Validar y completar campo    ${campoDescripcionDocCom}    archivo jpeg    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumentoDocCom}   boton subir documento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: verificacion de documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${jpeg}

#--------------------------------------------------------------------------------------------------------
#////////Pdf
Test X - Nota formal: se agrega documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubirDocCom}    boton subir
    Choose file    ${subirArchivoDocCom}    ${FILEpdf}
    Validar y completar campo    ${campoDescripcionDocCom}    archivo pdf    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumentoDocCom}   boton subir documento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#cambiar porque no funciona
Test X - Nota formal: verificacion de documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pdf}


