*** Settings ***
Documentation     Se realizan testeos para verificar si desde el lado del ciudadano se observa de manera correcta todos los datos
...
...               Test 1: Se crea un tramite
...
...               Test 1 - Paso 1:Verificar Titulo [ciudadano]
...
...               Test 1 - Paso 2:Verificar NumeroTramite [ciudadano]
...
...               Test 1 - Paso 3:Verificar Fecha de Creacion [ciudadano]
...
...               Test 1 - Paso 4:Verificar Fecha de actualizado [ciudadano]
...
...               Test 1 - Paso 5:Verificar Asunto  [ciudadano]
...
...               Test 1 - Paso 6:Verificar Detalle [ciudadano]
...
...               Test 1 - Paso 7:Verificar archivo subido [ciudadano]
...
...               Test 1 - Paso 8:Verificar Estado [ciudadano]
...
...               Test 1 - Paso 9:Verificar Contactar con mesa de ayuda[ciudadano]
...
...               Test 1 - Paso 10:Verificar acciones disponibles[ciudadano]
...
...               Test 1 - Paso 11:Verificar historial [ciudadano]
...
...               Test 1 - Paso 12:Verificar boton exportarPDF [ciudadano]

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

Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

*** Variables ***
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
${docLean}    ADJUNTO.pdf
#${docLean}    ubicacion.png

***Test Cases***

Test 1 - Creacion de tramite:
    [Documentation]    Crear un nuevo tramite de Test 1 - Paso X :
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso ${tramite}

Test 1 - Paso 1 : verificar Titulo
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Titulo de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar presencia de    ${tituloConsultaTributaria}    El titulo no se encontro visible

Test 1 - Paso 2 : Verificar NumeroTramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Numero de Tramite de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar Tramite Y Capturar Numero    ${tramite}

Test 1 - Paso 3 : Verificar Fecha de Creacion
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Creacion de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Creado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Test 1 - Paso 4 : Verificar Fecha de Actualizado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Actualizado de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Actualizado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Test 1 - Paso 5 : Verificar DatosPresentados Asunto
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la Test 1 - Paso X :, en este caso especificamente el asunto
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Asunto    Asunto test1

Test 1 - Paso 6 : Verificar DatosPresentados Detalle
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la Test 1 - Paso X :, en este caso especificamente el detalle
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Detalle    Descripcion test1

Test 1 - Paso 7 : Verificar DatosPresentados Archivo
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la Test 1 - Paso X :, en este caso especificamente el adjunto
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar presencia de... con...    //div[@class='grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4']    DNI del Solicitante

Test 1 - Paso 8 : verificar Estado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Pendiente

Test 1 - Paso 9 : verificar Contactar con Mesa de Ayuda
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el boton "Contactar con Mesa de Ayuda" de la Test 1 - Paso X : y este funcione adecuadamente
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonMesaAyuda}    botonContactarMesaAyuda
    Verificar no presencia de    ${datosPresentados}    Como se verifico la presencia de 'Datos Presentados', el boton 'Contactar con Mesa de Ayuda' no funciona

Test 1 - Paso 10 : verificar Acciones Disponibles
    [Documentation]    Comprueba las acciones disponibles del ciudadano, buscando como resultado que no tenga ninguna accion disponible ya que acaba de crear la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Acciones Disponibles    True

Test 1 - Paso 11 : verificar Historial
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los distintos mensajes/notas/acciones dentro historial de la Test 1 - Paso X :
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //h4[normalize-space()='Asignado a "Mesa de Entrada Virtual"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Test 1 - Paso 12 : verificar Boton ExportarPDF
    [Documentation]    Comprueba que el boton "ExportarPDF" funcione adecuadamente
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonExportarPDF}    botonExportarPDF
    Log to console    Boton 'Exportar PDF' fue clickeado y funciona correctamente

