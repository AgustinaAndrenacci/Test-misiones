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

***Test Cases***

Crear Consulta Tributaria
    [Documentation]    Crear una nueva consulta tributaria
    [tags]    test_01
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

Consulta Tributaria verificar Titulo
    [Documentation]
    [tags]    test_02
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Verificar presencia de    //h1[normalize-space()='Consulta Tributaria']    El titulo no se encontro visible

Consulta Tributaria Verificar NumeroTramite
    [Documentation]
    [tags]    test_03
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Verificar Tramite Y Capturar Numero    ${NumeroTramite}

Consulta Tributaria Verificar Fecha de Creacion
    [Documentation]
    [tags]    test_04
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Creado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar Fecha de Actualizado
    [Documentation]
    [tags]    test_05
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    ${FECHA_EXTRAIDA_WEB}=    Extraer Fecha Actualizado
    Comparar Fechas    ${FECHA_EXTRAIDA_WEB}

Consulta Tributaria Verificar DatosPresentados Asunto
    [Documentation]
    [tags]    test_06
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar Asunto    Asunto test1

Consulta Tributaria Verificar DatosPresentados Detalle
    [Documentation]
    [tags]    test_07
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar Detalle    Descripcion test1

Consulta Tributaria verificar Estado
    [Documentation]
    [tags]    test_08
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria verificar Contactar con Mesa de Ayuda
    [Documentation]
    [tags]    test_09
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar y hacer clic en el boton    //button[normalize-space()='Contactar con Mesa de Ayuda']    botonContactarMesaAyuda
    Verificar no presencia de    //h3[normalize-space()='Datos Presentados']    Como se verifico la presencia de 'Datos Presentados', el boton 'Contactar con Mesa de Ayuda' no funciona

Consulta Tributaria verificar Acciones Disponibles
    [Documentation]
    [tags]    test_10
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar Acciones Disponibles    True

Consulta Tributaria verificar Historial
    [Documentation]
    [tags]    test_11
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar y hacer clic en el boton    //h3[normalize-space()='Historial y Comunicaciones']    botonHistorial
    Verificar presencia de    //h4[normalize-space()='Asignado a "Mesa de Entrada Virtual"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria verificar Boton ExportarPDF
    [Documentation]
    [tags]    test_12
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonExportarPDF}    botonExportarPDF
    Log to console    Boton 'Exportar PDF' fue clickeado y funciona correctamente


Consulta Tributaria verificar Boton CancelarTramite
    [Documentation]
    [tags]    test_13
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonVerDetalle}    botonVerDetalle
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar Trámite']    botonCancelarTramite
    Validar y hacer clic en el boton    //button[normalize-space()='Volver']    botonVolver
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar Trámite']    botonCancelarTramite
    Validar y hacer clic en el boton    //button[normalize-space()='Sí, cancelar']    botonSiCancelar
    Wait Until Page Contains    La solicitud ha sido cancelada. Serás redirigido al inicio en unos segundos.    timeout=10s



***Keywords***

Verificar no presencia de
    [Arguments]    ${elemento}    ${mensajeExtra}
    Wait Until Element Is Visible    ${elemento}    timeout=7s
    ${existe} =    Run Keyword And Return Status    Page Should Contain Element    ${elemento}
    IF    ${existe}
        Captura Screenshot In Log
        Fail    ${mensajeExtra}
    END
    Sleep  2s

Validar Estado Del Tramite
    [Arguments]    ${estado_esperado}
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//span[normalize-space(text())='${estado_esperado}']    timeout=10s
    IF    ${visible}
        ${estado_actual}=    Get Text    xpath=//span[normalize-space(text())='${estado_esperado}']
        Log    Estado validado correctamente: ${estado_actual}
    ELSE
        Fail    No se encontro visible el estado esperado.
    END

Validar Detalle
    [Arguments]    ${detalle_esperado}
    ${detalle_actual}=    Get Text    xpath=//span[normalize-space(.)='Detalle']/following-sibling::span
    Log    Detalle capturado: ${detalle_actual}
    Run Keyword If    '${detalle_actual}' != '${detalle_esperado}'    Fail    El detalle no coincide con el esperado. Se esperaba: '${detalle_esperado}', sin embargo aparecio: '${detalle_actual}'
    Log    El detalle coincide con el valor esperado

Validar Asunto
    [Arguments]    ${asunto_esperado}
    Wait Until Element Is Visible    xpath=//div[@class="flex flex-col"]    timeout=5s
    Log    El bloque de asunto está visible
    ${asunto_actual}=    Get Text    xpath=(//div[@class="flex flex-col"]/span)[2]
    Log    Asunto capturado: ${asunto_actual}
    Run Keyword If    '${asunto_actual}' != '${asunto_esperado}'    Fail    El asunto no coincide con el esperado. Se esperaba: '${asunto_esperado}', sin embargo aparecio: '${asunto_actual}'
    Log    El asunto coincide con el valor esperado

Verificar Tramite Y Capturar Numero
    [Arguments]    ${codigo_esperado}
    Wait Until Element Is Visible    xpath=//p[@class="text-muted-foreground mt-1"]    timeout=5s
    Log    El <p> con clase 'text-muted-foreground mt-1' está visible
    ${codigo_actual}=    Get Text    xpath=//p[@class="text-muted-foreground mt-1"]/span[@class="font-mono"]
    Log    Codigo de tramite capturado: ${codigo_actual}
    Run Keyword If    '${codigo_actual}' != '${codigo_esperado}'    Fail    El asunto no coincide con el esperado. Se esperaba: '${codigo_esperado}', sin embargo aparecio: '${codigo_actual}'
    Log    El asunto coincide con el valor esperado




Extraer Fecha Creado
    ${FECHA_CREADO_RAW}=    Get Text    xpath=//span[contains(text(), 'Creado')]
    ${FECHA_CREADO_LIMPIA}=    Replace String    ${FECHA_CREADO_RAW}    Creado:    ${EMPTY}
    RETURN    ${FECHA_CREADO_LIMPIA}

Extraer Fecha Actualizado
    ${FECHA_CREADO_RAW}=    Get Text    xpath=//span[contains(text(), 'Actualizado')]
    ${FECHA_CREADO_LIMPIA}=    Replace String    ${FECHA_CREADO_RAW}    Actualizado:     ${EMPTY}
    RETURN    ${FECHA_CREADO_LIMPIA}





Comparar Fechas
    [Arguments]    ${FECHA_EXTRAIDA_WEB}
    # 1. Obtener la fecha actual en formato ISO
    ${FECHA_ACTUAL_ISO}=    Get Current Date    result_format=%Y-%m-%d
    Log To Console    Fecha Actual (ISO): ${FECHA_ACTUAL_ISO}

    # 2. Convertir la fecha extraída de la web a ISO
    ${FECHA_EXTRAIDA_ISO}=    Convertir Fecha Web A ISO    ${FECHA_EXTRAIDA_WEB}
    Log To Console    Fecha Extraída (ISO): ${FECHA_EXTRAIDA_ISO}

    # 3. Comparar las fechas
    Should Be Equal    ${FECHA_ACTUAL_ISO}    ${FECHA_EXTRAIDA_ISO}
    Log To Console    ¡Las fechas son iguales!

Convertir Fecha Web A ISO
    [Arguments]    ${fecha_web}
    # Diccionario de meses abreviados en español
    ${meses}=    Create Dictionary    ene=01    feb=02    mar=03    abr=04    may=05    jun=06    jul=07    ago=08    sep=09    oct=10    nov=11    dic=12

    # Separar la cadena "26 de nov de 2025"
    ${partes}=    Split String    ${fecha_web}    de
    ${dia}=    Strip String    ${partes[0]}
    ${mes_abrev}=    Strip String    ${partes[1]}
    ${anio}=    Strip String    ${partes[2]}

    ${mes}=    Get From Dictionary    ${meses}    ${mes_abrev}
    ${fecha_iso}=    Set Variable    ${anio}-${mes}-${dia.zfill(2)}
    RETURN    ${fecha_iso}

Validar Acciones Disponibles
    [Arguments]    ${fallar_si_hay_acciones}=False
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//h3[normalize-space()='Acciones Disponibles']    timeout=10s
    IF    ${visible}
        Log    Verificado: 'Acciones Disponibles' está visible
        ${texto_acciones}=    Get Text    xpath=//p[contains(text(), 'acciones disponibles')]
        Log    Texto encontrado: ${texto_acciones}

        ${hay_acciones}=    Run Keyword And Return Status    Should Not Contain    ${texto_acciones}    No hay acciones disponibles

        IF    ${hay_acciones}
            Log    Hay acciones disponibles
            IF    ${fallar_si_hay_acciones}
                Fail    Se detectaron acciones disponibles, y no deberia haber acciones disponibles
            END
        ELSE
            Log    No hay acciones disponibles
            IF    not ${fallar_si_hay_acciones}
                Fail    No hay acciones disponibles, y deberia haber acciones disponibles
            END
        END
    ELSE
        Fail    El apartado de 'Acciones Disponibles' no se encuentra visible
    END

Validar Estado Del Tramite
    [Arguments]    ${estado_esperado}
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//span[normalize-space(text())='${estado_esperado}']    timeout=10s
    IF    ${visible}
        ${estado_actual}=    Get Text    xpath=//span[normalize-space(text())='${estado_esperado}']
        Log    Estado validado correctamente: ${estado_actual}
    ELSE
        Fail    No se encontro visible el estado esperado.
    END