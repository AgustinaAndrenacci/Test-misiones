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

Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

***Test Cases***

Crear Consulta Tributaria
    [Documentation]    Crear un nuevo tramite de consulta tributaria
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test1  contenidoConsultaTributaria
    #Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    #Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso ${tramite}

Consulta Tributaria verificar Titulo
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Titulo de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar presencia de    ${tituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Verificar NumeroTramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Numero de Tramite de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar Tramite Y Capturar Numero    ${tramite}

Consulta Tributaria Verificar Fecha de Creacion
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Creacion de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Creado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar Fecha de Actualizado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Actualizado de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Actualizado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar DatosPresentados Asunto
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el asunto
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Asunto    Asunto test1

Consulta Tributaria Verificar DatosPresentados Detalle
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el detalle
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Detalle    Descripcion test1

#Consulta Tributaria Verificar DatosPresentados Archivo
#    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el adjunto
#    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
#    Asignar Tag Numerado
#    Abrir Navegador en modo incognito    ${pageCiudadano}
#    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
#    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
#    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
#    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pngAgus}

Consulta Tributaria verificar Estado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria verificar Contactar con Mesa de Ayuda
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el boton "Contactar con Mesa de Ayuda" de la consulta tributaria y este funcione adecuadamente
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonMesaAyuda}    botonContactarMesaAyuda
    Verificar no presencia de    ${datosPresentados}    Como se verifico la presencia de 'Datos Presentados', el boton 'Contactar con Mesa de Ayuda' no funciona

Consulta Tributaria verificar Acciones Disponibles
    [Documentation]    Comprueba las acciones disponibles del ciudadano, buscando como resultado que no tenga ninguna accion disponible ya que acaba de crear la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Acciones Disponibles    True

Consulta Tributaria verificar Historial
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los distintos mensajes/notas/acciones dentro historial de la consulta tributaria
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //h4[normalize-space()='Asignado a "Mesa de Entrada Virtual"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria verificar Boton ExportarPDF
    [Documentation]    Comprueba que el boton "ExportarPDF" funcione adecuadamente
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonExportarPDF}    botonExportarPDF
    Log to console    Boton 'Exportar PDF' fue clickeado y funciona correctamente

