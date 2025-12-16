*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/EmbedScreenshotLibrary.py
Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/InternetOculto.py

Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

Test Setup     Abrir Navegador en modo incognito
Test Teardown  Cerrar navegador

#Suite Setup    Inicializar Contador

***Test Cases***

Crear Consulta Tributaria
    [Documentation]    Crear una nueva consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que origina el acto
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Consulta Tributaria verificar Titulo
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Titulo de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar presencia de    ${tituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Verificar NumeroTramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Numero de Tramite de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Verificar Tramite Y Capturar Numero    ${tramite}

Consulta Tributaria Verificar Fecha de Creacion
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Creacion de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Creado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar Fecha de Actualizado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Fecha de Actualizado de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Actualizado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar DatosPresentados Asunto
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el asunto
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Asunto    Asunto test1

Consulta Tributaria Verificar DatosPresentados Detalle
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el detalle
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Detalle    Descripcion test1

Consulta Tributaria verificar Estado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria verificar Contactar con Mesa de Ayuda
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el boton "Contactar con Mesa de Ayuda" de la consulta tributaria y este funcione adecuadamente
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonMesaAyuda}    botonContactarMesaAyuda
    Verificar no presencia de    ${datosPresentados}    Como se verifico la presencia de 'Datos Presentados', el boton 'Contactar con Mesa de Ayuda' no funciona

Consulta Tributaria verificar Acciones Disponibles
    [Documentation]    Comprueba las acciones disponibles del ciudadano, buscando como resultado que no tenga ninguna accion disponible ya que acaba de crear la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Acciones Disponibles    True

Consulta Tributaria verificar Historial
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los distintos mensajes/notas/acciones dentro historial de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //h4[normalize-space()='Asignado a "Mesa de Entrada Virtual"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria verificar Boton ExportarPDF
    [Documentation]    Comprueba que el boton "ExportarPDF" funcione adecuadamente
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonExportarPDF}    botonExportarPDF
    Log to console    Boton 'Exportar PDF' fue clickeado y funciona correctamente

Consulta Tributaria verificar Boton CancelarTramite
    [Documentation]    Comprueba que el boton "CancelarTramite" funcione adecuadamente
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonCancelarTramite}    botonCancelarTramite
    Validar y hacer clic en el boton    ${botonVolver}    botonVolver
    Validar y hacer clic en el boton    ${botonCancelarTramite}    botonCancelarTramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    botonSiCancelar
    Wait Until Page Contains    La solicitud ha sido cancelada. Serás redirigido al inicio en unos segundos.    timeout=10s

Consulta Tributaria verificar Estado Cancelado
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
