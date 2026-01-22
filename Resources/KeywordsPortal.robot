*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

*** Keywords ***
Verificar los botones de acciones [operador mesa] - instancia 1
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Verificar los botones de acciones [direccion] - instancia 1
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resolver
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

Verificar los botones de acciones [gestion] - instancia 1
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

Verificar los botones de acciones [operador mesa] - instancia 2
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

#------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------
#FALTA!
#EJ:
#Se selecciona X accion    ${botonSolicitarDatosAdicionales}    Solicitar Datos Adicionales    ${FILEpdfAgus}    ${pdfAgus}
Se selecciona X accion
    [Arguments]    ${btn}    ${nombreBoton}    ${rutaArchivo}    ${nombreArchivo}
    Validar y hacer clic en el boton    ${btn}    ${nombreBoton}
    Validar y completar campo    ${campoComentario}    ${nombreBoton}    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${rutaArchivo}
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Validar y hacer clic en el boton    ${btn}    ${nombreBoton}
    Element Attribute Value Should Be    ${campoComentario}    value    ${EMPTY}
    Verificar NO presencia de... con...    //div[@class='space-y-3']//div[@class='space-y-2']    ${nombreArchivo}
    Validar y completar campo    ${campoComentario}    ${nombreBoton}    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${rutaArchivo}
    Sleep  7s
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.

Se selecciona X accion con estado final
    [Arguments]    ${btn}    ${nombreBoton}
    Validar y hacer clic en el boton    ${btn}    ${nombreBoton}
    Element Should Be Visible    ${campoComentario}
    Element Should Be Disabled    ${campoComentario}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.

#------------------------------------------------------------------------------------------------------------

Inicio sesion y verificacion de texto inicial - ciudadano
    [arguments]    ${user}    ${pasw}    ${elemento}
    Iniciar sesion  ${user}  ${pasw}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Sleep  3s
    #Verificar Y Esperar Visibilidad De Elemento por localizador    ${elemento}

Inicio sesion y verificacion de texto inicial - operador
    [arguments]    ${user}    ${pasw}    ${elemento}
    Iniciar sesion  ${user}  ${pasw}  ${campoMail}  ${campoPass}  ${botonIngresar}
    Sleep  3s
    #Verificar Y Esperar Visibilidad De Elemento    ${elemento}

Crear tramite para X tipo
    [Arguments]    ${tipoTramite}    ${campoAsunto}    ${campoDetalle}    ${campoContenido}    ${file}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${tipoTramite}    ${tipoTramite}
    Validar y completar campo    ${campoAsunto}  Asunto test2    asunto
    Validar y completar campo    ${campoDetalle}  Descripcion test2  detalle
    Validar y completar campo    ${campoContenido}  Contenido test2  contenido
#    Verificar y presionar ítem en lista index    ${select}    1
#    Choose file    ${InputTypeFile}    ${file}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

Crea un nuevo tramite [ciudadano]
    [Arguments]    ${datos}
    # Uso de datos dinámicos del diccionario
    Validar y hacer clic en el boton    ${datos}[boton]     botonTramite
    Validar y completar campo    ${datos}[asunto]    Asunto    asunto
    Validar y completar campo    ${datos}[detalle]   Descripcion  detalle
    Validar y completar campo    ${datos}[cont]      Contenido  contenido

    Subir Documento Correctamente    ${FILE3}    ${datos}[lista]    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s

    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

Agregar documentacion complementaria
    [Arguments]    ${archivo}    ${tipo}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${archivo}
    Validar y completar campo    ${campoDescripcion}    archivo ${tipo}    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.

No Agregar documentacion complementaria
    [Arguments]    ${archivo}    ${tipo}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${archivo}
    Validar y completar campo    ${campoDescripcion}    archivo ${tipo}    descripcion
    Verificar Y Esperar Visibilidad De Elemento    Tipo de archivo no permitido

Crea un nuevo tramite borrador [ciudadano]
    [Arguments]    ${datos}
    # Uso de datos dinámicos del diccionario
    Validar y hacer clic en el boton    ${datos}[boton]     botonTramite
    Validar y completar campo    ${datos}[asunto]    Asunto    asunto
    Validar y completar campo    ${datos}[detalle]   Descripcion  detalle
    Validar y completar campo    ${datos}[cont]      Contenido  contenido

    Subir Documento Correctamente    ${FILE3}    ${datos}[lista]    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s

    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    #Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado



















#******************************************************************************************************************
#******************************************* KEYWORDS DEL PORTAL ****************************************************
#******************************************************************************************************************

Validar Consistencia Desde DOM
    [Arguments]    ${totalComprobantes}    ${comprobantesARevisar}    ${comprobantesRevisados}    ${comprobantesRechazados}    ${comprobantesObservados}    ${comprobantesReingresados}
    ${total}=              Obtener Valor Numérico Por ID    ${totalComprobantes}
    ${a_revisar}=          Obtener Valor Numérico Por ID    ${comprobantesARevisar}
    ${revisados}=          Obtener Valor Numérico Por ID    ${comprobantesRevisados}
    ${rechazados}=         Obtener Valor Numérico Por ID    ${comprobantesRechazados}
    ${observados}=         Obtener Valor Numérico Por ID    ${comprobantesObservados}
    ${reingresados}=       Obtener Valor Numérico Por ID    ${comprobantesReingresados}

    ${suma}=               Evaluate    ${a_revisar} + ${revisados} + ${rechazados} + ${observados} + ${reingresados}
    ${diferencia}=         Evaluate    ${total} - ${suma}

    Log To Console    \nTotal declarado: ${total} \nSuma de estados: ${suma} \nDiferencia: ${diferencia}
    Log    Total declarado: ${total}
#    Log To Console
    Log   Suma de estados: ${suma}
#    Log To Console    Diferencia: ${diferencia}
    Log    Diferencia: ${diferencia}

    Run Keyword If    ${diferencia} == 0
    ...    Log To Console    La suma coincide con el total
    ...    ELSE
    ...    Log To Console    Inconsistencia detectada: diferencia de ${diferencia}
    Should Be True    ${diferencia} == 0    msg=La suma de estados no coincide con el total de comprobantes. Total=${total} | Suma=${suma} | Faltan=${diferencia} comprobantes.

Obtener Valor Numérico Por ID
    [Arguments]    ${id}
    ${texto}=    Get Text    ${id}
    ${valor}=    Evaluate    int('${texto}'.replace(',', '').strip())
    RETURN    ${valor}

Contar Filas De La Tabla
    [Arguments]    ${locator}
    # Filtra solo filas con al menos una celda <td> que tenga contenido visible
    ${filas}=    Get WebElements    xpath:${locator}//tr[td[string-length(normalize-space(.)) > 0]]
    ${cantidad}=    Get Length    ${filas}
    RETURN    ${cantidad}

Verificar Valor De Carta
    [Arguments]    ${xpathCarta}
    #Obtiene el valor numerico de la carta y lo deja en la variable ${valor} Despues presiona la carta
    ${valor}=              Obtener Valor Numérico Por ID    ${xpathCarta}
    Click Element    ${xpathCarta}

    #Agranda la tabla por 100, cuenta cuantas filas tiene la tabla y lo deja en la variable ${cantidad}
    Verificar y presionar ítem en lista  ${selectorListaComprobantes}  100
    ${cantidad}=    Contar Filas De La Tabla    ${TABLE_WRAPPER_XPATH_COMPROBANTES}

    #Comprueba la igualdad entre ${valor} y ${cantindad}
    IF    ${valor} == ${cantidad}
        Log To Console    El valor de la carta coincide
        Log    El valor de la carta coincide
    ELSE
        Captura Screenshot In Log
        Fail    El valor de la carta no coincide con la cantidad esperada. Valor que muestra la Carta: ${valor} | Cantidad de comprobantes encontrados: ${cantidad}
    END

Obtener Estados De La Tabla
    [Arguments]    ${locatorTabla}
    ${celdasEstado}=    Get WebElements    xpath=${locatorTabla}//tbody/tr/td[5]
    ${estados}=    Create List
    FOR    ${celda}    IN    @{celdasEstado}
        ${texto}=    Get Text    ${celda}
#        ${estadoNormalizado}=    Evaluate    '${texto}'.strip().lower()
        Append To List    ${estados}    ${texto}
    END
    Log To Console    ${estados}
    RETURN    ${estados}

Validar Estado Individual
    [Arguments]    ${estado}    @{permitidos}
    ${es_valido}=    Run Keyword And Return Status    Should Contain    ${permitidos}    ${estado}
    RETURN    ${es_valido}

Validar Estados Permitidos
    [Arguments]    ${estados}    @{permitidos}
    ${errores}=    Create List
    FOR    ${estado}    IN    @{estados}
        ${es_valido}=    Validar Estado Individual    ${estado}    @{permitidos}
        Run Keyword If    not ${es_valido}    Append To List    ${errores}    ${estado}
    END
    Run Keyword If    ${errores}    Fail    \nLos siguientes resultados no se encuentran entre los estados permitidos en la validacion. \nEstados invalidos encontrados:${errores} \nEstados permitidos: ${permitidos}


Validar Toast O Alerta
    [Arguments]    ${tipo_esperado}    ${mensaje_esperado}    ${modo_validacion}=contiene    ${timeout}=3s    ${normalizar_mensaje}=False

    ${toast_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    css:.jq-toast-single    ${timeout}
    IF    not ${toast_visible}
        Log    \nEl toast no aparecio en el tiempo esperado (${timeout}).    WARN
        Captura Screenshot In Log
        Sleep    1s
        ${resultado}=    Run Keyword And Ignore Error    Handle Alert    action=DISMISS
        Log    Resultado de Handle Alert: ${resultado}
        # Si el mensaje de error contiene "no alert", entonces no había alerta.
        ${mensaje_error}=    Set Variable    ${resultado[1]}
        ${alerta_descartada}=    Run Keyword And Return Status    Should Not Contain    ${mensaje_error}    no alert
        IF    ${alerta_descartada}
            Log    Se detecto una alerta inesperada.
            Buscar Y Eliminar Comprobante
            Fail    No se detecto ningún toast en pantalla.\nSin embargo, aparecio una alerta continuando con la creacion del comprobante.\nEsto indica un flujo inesperado.
        ELSE
            Log    No se detectó alerta, solo falló el toast.    WARN
        END

    ELSE
        ${heading_visible}=    Run Keyword And Return Status    Element Should Be Visible    css:.jq-toast-heading
        IF    ${heading_visible}
            ${tipo_raw}=    Get Text    css:.jq-toast-heading
        ELSE
            ${tipo_raw}=    Set Variable    ''
        END

        ${mensaje_completo}=    Get Text    css:.jq-toast-single
        ${mensaje_real}=    Replace String    ${mensaje_completo}    ${tipo_raw}    ''
        ${mensaje_real}=    Strip String    ${mensaje_real}
        ${tipo_normalizado}=    Normalizar texto    ${tipo_raw}
        ${tipo_esperado_normalizado}=    Normalizar texto    ${tipo_esperado}

        IF    '${normalizar_mensaje}' == 'True'
            ${mensaje_real_comparar}=    Normalizar texto    ${mensaje_real}
            ${mensaje_esperado_comparar}=    Normalizar texto    ${mensaje_esperado}
        ELSE
            ${mensaje_real_comparar}=    Set Variable    ${mensaje_real}
            ${mensaje_esperado_comparar}=    Set Variable    ${mensaje_esperado}
        END

        Log    Tipo detectado: ${tipo_normalizado} | Tipo esperado: ${tipo_esperado_normalizado}
        Log    Mensaje detectado: ${mensaje_real_comparar} | Mensaje esperado: ${mensaje_esperado_comparar}

        ${tipo_valido}=    Run Keyword And Return Status    Should Contain    ${tipo_normalizado}    ${tipo_esperado_normalizado}

        IF    not ${tipo_valido}
            Log    Tipo de toast inválido. Esperado que contenga: [${tipo_esperado}] | Recibido: [${tipo_raw}]    WARN
            Captura Screenshot In Log
            Fail    El tipo de toast no coincide con lo esperado.
        END

        IF    '${modo_validacion}' == 'exacto'
            ${mensaje_valido}=    Run Keyword And Return Status    Should Be Equal As Strings    ${mensaje_real_comparar}    ${mensaje_esperado_comparar}
        ELSE IF    '${modo_validacion}' == 'contiene'
            ${mensaje_valido}=    Run Keyword And Return Status    Should Contain    ${mensaje_real_comparar}    ${mensaje_esperado_comparar}
        ELSE IF    '${modo_validacion}' == 'regex'
            ${mensaje_valido}=    Run Keyword And Return Status    Should Match Regexp    ${mensaje_real_comparar}    ${mensaje_esperado_comparar}
        ELSE
            Fail    Modo de validación '${modo_validacion}' no soportado.
        END

        IF    not ${mensaje_valido}
            Log    \nEl mensaje del toast no coincide. \nEsperado: [${mensaje_esperado}] \n Recibido:[${mensaje_real}]    WARN
            Captura Screenshot In Log
        ELSE
            Log    Toast validado correctamente: [${tipo_raw}] - [${mensaje_real}]
        END
    END

Comprobar Cambio areaDeLiquidacion
    [Arguments]    ${locator}    ${texto}
    ${estado_seleccionado}=    Get Selected List Label    ${locator}
    IF    '${estado_seleccionado}' == '${texto}'
        Log    El cambio fue exitoso!
    ELSE
        Captura Screenshot In Log
        Fail    El input Area De Liquidacion cuando modificas un comprobante, sin importar el area real del comprobante, siempre muestra el area ${estado_seleccionado}
    END

Validar Cambio De Campo
    [Arguments]    ${locator}    ${esperado}
    ${actual}=     Get Value    ${locator}
    Run Keyword If    '${actual}' == '${esperado}'    Log    El cambio fue exitoso!
    ...    ELSE    Log    Contenido inesperado: '${actual}' (esperado: '${esperado}')    WARN
    ...    Captura Screenshot In Log

Validar Filtro
    [Arguments]    ${cuit_esperado}
    Wait Until Page Contains    ${cuit_esperado}    timeout=5s
    ${cuit_en_tabla}=    Get Text    xpath=//table//tr[1]/td[1]
    Should Be Equal As Strings    ${cuit_en_tabla}    ${cuit_esperado}
    Log    El Comprobante aparece correctamente en la primera fila tras aplicar el filtro.

Presionar tecla en campo
    [Arguments]    ${selector}    ${tecla}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        Click Element    ${selector}
        Press Keys      ${selector}    ${tecla}
        Log    Se presionó la tecla ${tecla} sobre ${selector}
    ELSE
        Captura Screenshot In Log    ${selector}
        Fail    No se pudo presionar la tecla ${tecla} en el campo: ${selector}
    END
    Sleep    1s

Obtener Estados De La Tabla Usuarios
    [Arguments]    ${locatorTabla}
    ${celdasEstado}=    Get WebElements    xpath=${locatorTabla}//tbody/tr/td[3]
    ${estados}=    Create List
    FOR    ${celda}    IN    @{celdasEstado}
        ${texto}=    Get Text    ${celda}
#        ${estadoNormalizado}=    Evaluate    '${texto}'.strip().lower()
        Append To List    ${estados}    ${texto}
    END
    Log To Console    ${estados}
    RETURN    ${estados}
