***Settings***
Library  SeleniumLibrary
Library    String
Library  BuiltIn

*** Keywords ***

#KEYWORDS QUE NO SE USAN---------------------------------------------------------------------------------------------------------------------------------------------
#----------------------------CHEQUEAR SI SE BORRAN O NO--------------------------------------------------------------------------------------------------------------

Validar Estado Primer Tramite
    [Arguments]    ${locatorTabla}    @{permitidos}
    ${primerEstadoCelda}=    Get WebElement    xpath=${locatorTabla}//tbody/tr[1]/td[3]
    ${estado}=    Get Text    ${primerEstadoCelda}
    Log to console    Estado del primer trámite: ${estado}
    ${es_valido}=    Run Keyword And Return Status    Should Contain    ${permitidos}    ${estado}
    Run Keyword If    not ${es_valido}    Fail    Aparecio el estado: '${estado}', cuando se esperaba que el tramite este en el estado: ${permitidos}

Validar Estado Primer Tramite personal
    [Arguments]    ${locatorTabla}    @{permitidos}
    ${primerEstadoCelda}=    Get WebElement    xpath=${locatorTabla}//tbody/tr[1]/td[4]
    ${estado}=    Get Text    ${primerEstadoCelda}
    Log to console    Estado del primer trámite: ${estado}
    ${es_valido}=    Run Keyword And Return Status    Should Contain    ${permitidos}    ${estado}
    Run Keyword If    not ${es_valido}    Fail    Aparecio el estado: '${estado}', cuando se esperaba que el tramite este en el estado: ${permitidos}

Validar Estado Primer inexistente
    [Arguments]    ${locatorTabla}    @{estadoViene}
    ${primerEstadoCelda}=    Get WebElement    xpath=${locatorTabla}//tbody/tr[1]/td[4]
    ${estado}=    Get Text    ${primerEstadoCelda}
    Log to console    Estado del primer trámite: ${estado}
    ${es_valido}=    Run Keyword And Return Status    Should Contain    ${estadoViene}    ${estado}
    Run Keyword If    ${es_valido}    Fail    Aparecio el estado: '${estado}', cuando no se deberia observar

#TAGS AUTOMATICOS----------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Inicializar Contador
    Set Suite Variable    ${COUNTER}    0

Asignar Tag Numerado
    ${COUNTER}=    Evaluate    ${COUNTER} + 1
    ${TAG_NUM}=    Evaluate    "{:03}".format(${COUNTER})
    Set Suite Variable    ${COUNTER}
    Set Tags    test_${TAG_NUM}

#Navegador-----------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Abrir Navegador
    Open Browser    ${page}    ${browser}
    Maximize Browser Window
    Sleep    1s

Cerrar Navegador
    Close browser
    Sleep    1s

Abrir Navegador en modo incognito
    [Arguments]    ${page}
    [Documentation]    Abre el navegador usando la función de Python para configurar opciones.

    # 1. Llama a la función de Python para obtener el objeto Options
    ${chrome_options_object}=    get chrome options

    #options: configuracion para abrir el navegador
    Open Browser    ${page}    ${browser}    options=${chrome_options_object}

    Maximize Browser Window

#Login---------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Iniciar sesion
    [Arguments]    ${u}    ${p}    ${uCampo}     ${pCampo}    ${boton}
    Validar y completar campo    ${uCampo}    ${u}    campo usuario
    Validar y completar campo    ${pCampo}    ${p}    campo contraseña
    Validar y hacer clic en el boton    ${boton}    iniciar sesion
    Sleep  1s


Cerrar Sesion
    ${icono_existe} =    Run Keyword And Return Status    Page Should Contain Element    xpath=/html/body/nav/div[2]/ul/li/a/i

    IF    ${icono_existe}
        Click Element    xpath=/html/body/nav/div[2]/ul/li/a/i
        ${cerrar_existe}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=/html/body/nav/div[2]/ul/li/div/a[2]    timeout=3s
        Sleep  2s
        IF    ${cerrar_existe}
            Click Element    xpath=/html/body/nav/div[2]/ul/li/div/a[2]
        ELSE
            Captura Screenshot In Log
            Fail    Error: no se encuentra la opcion para cerrar sesion
        END
    ELSE
        Captura Screenshot In Log
        Fail    Error: no se encuentra el icono del usuario
    END
    Sleep  1s

Iniciar Cuenta Google
    Click Element    xpath:/html/body/div/div[5]/div/div/div/div[2]/span[1]
    Close Browser

#Completar/Seleccionar Campo-----------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Completar campo
    [Arguments]    ${campo}    ${dato}
    Input text  ${campo}   ${dato}
    Sleep  2s

Selecciono dato de la lista
    [Arguments]    ${lista}    ${dato}
    Select From List By Value    ${lista}    ${dato}
    Sleep  2s

Contar Filas Reales En Tabla
    [Arguments]    ${locator}    ${cantidadEsperada}

    # Filtra solo filas con al menos una celda <td> que tenga contenido visible
    ${filas}=    Get WebElements    xpath:${locator}//tr[td[string-length(normalize-space(.)) > 0]]

    ${cantidad}=    Get Length    ${filas}

    Log To Console    Se detectaron ${cantidad} filas con contenido real.

    IF    ${cantidad} != ${cantidadEsperada}
        Log Many    Las filas detectadas fueron:
        FOR    ${fila}    IN    @{filas}
            ${texto}=    Get Text    ${fila}
            Log To Console    Fila: ${texto}
        END
        Captura Screenshot In Log
        Fail    Se esperaban ${cantidadEsperada} filas con datos pero se encontraron ${cantidad}
    ELSE
        Log    Se encontraron ${cantidad} filas con datos como se esperaba.
    END

#Abrir tramite por numero ----------------------------------------------------------------------------------------------
Obtener Numero De Tramite
    [Arguments]    ${selector}=//div[@class='text-sm opacity-90']
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        ${texto}=    Get Text    ${selector}
        ${partes}=    Split String    ${texto}    ${SPACE}
        ${tramite}=    Set Variable    ${partes[2]}
        Log To Console    TEXTO OBTENIDO: ${tramite}
        RETURN    ${tramite}
    ELSE
        Log To Console    Elemento no visible, no se obtuvo número de trámite
        RETURN    None
    END

Abrir Tramite Por Numero
    [Arguments]    ${numero_tramite}
    ${xpath}=    Set Variable    //a[normalize-space()='${numero_tramite}']
    Wait Until Element Is Visible    ${xpath}    10s
    Click Element    ${xpath}

#verificacion de datos en el campo --------------------------------------------------------------
Verificar Y Esperar Visibilidad De Elemento por localizador
#Se le pasa un xpath y ve si esta visible
    [Arguments]    ${elemento}    ${timeout}=10s
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${elemento}    timeout=${timeout}

    Run Keyword If    ${status}
    ...    Log To Console    El elemento "${elemento}" es visible.
    ...    ELSE
    ...    Fail    El elemento "${elemento}" NO se visualiza después de ${timeout}.
    ...    Captura Screenshot In Log


Verificar Y Esperar Visibilidad De Elemento
#Se le pasa una frase, palabra y ve si esta visible
    [Arguments]    ${elemento}    ${timeout}=10s
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    ${elemento}    timeout=${timeout}

    Run Keyword If    ${status}
    ...    Log To Console    El elemento "${elemento}" es visible.
    ...    ELSE
    ...    Fail    El elemento "${elemento}" NO se visualiza después de ${timeout}.
    ...    Captura Screenshot In Log

Verificar Contenido De Campos
    [Arguments]    ${campo}    ${nombreCampo}    ${dato_esperado}    ${timeout}=10s

    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${campo}    timeout=${timeout}
    IF    ${visible}
        ${dato_actual}=    Get Value    ${campo}
        ${dato_actual_limpio}=    Strip String    ${dato_actual}
        ${dato_esperado_limpio}=    Strip String    ${dato_esperado}

        ${es_valido}=    Run Keyword And Return Status    Should Be Equal    ${dato_actual_limpio}    ${dato_esperado_limpio}
        IF    not ${es_valido}
            Captura Screenshot In Log
            Fail    El campo "${nombreCampo}" deberia tener el dato "${dato_esperado}" pero el dato actual es "${dato_actual}"
        END
    ELSE
        Captura Screenshot In Log
        Fail    El campo "${campo}" no se hizo visible en ${timeout}
    END

#Limpiar contador del tramite ---------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------
Limpieza de variable
    [arguments]    ${var}
    ${var}=    0
    Log to console    Variable limpia con valor: ${var}
    RETURN    ${var}

Verificacion de si se creo el tramite
    [arguments]    ${var}
    If    ${var}=0   Fail    El tramite no se creó.

Presionar x boton en la fila del tramite
    [Arguments]    ${locatorTabla}    ${boton}    ${numTramite}
    ${xpathFila}=    Set Variable    ${locatorTabla}//tbody/tr[td[1]="${numTramite}"]
    ${xpathCompletoBoton}=    Set Variable    ${xpathFila}${boton}
    Click Element    xpath=${xpathCompletoBoton}

#Verificar Automatico------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Validar Estado con numero de tramite
    [Arguments]    ${locatorTabla}    ${numColumnaEstado}    ${numTramite}    @{permitidos}

    #Armar xpath de la fila
    ${xpathEstadoCelda}=    Set Variable    ${locatorTabla}//tbody/tr[td[1]="${numTramite}"]/td[${numColumnaEstado}]
<<<<<<< HEAD
    #Obtener estado
    Wait Until Element Is Visible    ${xpathEstadoCelda}    timeout=10s
    ${primerEstadoCelda}=    Get WebElement    ${xpathEstadoCelda}
=======
    #Espero
    Verificar Y Esperar Visibilidad De Elemento    Acciones
    Sleep  2s
    #Verificar Y Esperar Visibilidad De Elemento por localizador    ${locatorTabla}
    #Obtener estado
    ${primerEstadoCelda}=    Get WebElement    xpath=${xpathEstadoCelda}
>>>>>>> 21e475a997edea5357497d6083f1a5dfee2768f4
    ${estado}=    Get Text    ${primerEstadoCelda}
    #Chequeo si los estados son iguales
    ${es_valido}=    Run Keyword And Return Status    Should Contain    ${permitidos}    ${estado}
    #Fallar si el estado no es válido
    Run Keyword If    not ${es_valido}
    ...    Captura Screenshot In Log
    ...    Fail    El trámite ${numTramite} tiene el estado: '${estado}', cuando se esperaba: ${permitidos}

<<<<<<< HEAD

=======
>>>>>>> 21e475a997edea5357497d6083f1a5dfee2768f4
Validar Tramite Inexistente
    [Arguments]    ${locatorTabla}    ${numTramite}
    ${xpathFilaTramite}=    Set Variable    ${locatorTabla}//tbody/tr[td[1]="${numTramite}"]
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${xpathFilaTramite}    timeout=3s
    IF    ${visible}
        Captura Screenshot In Log
        Fail    El trámite ${numTramite} fue encontrado en la tabla cuando se esperaba que fuera inexistente.
    ELSE
        Log To Console    El trámite ${numTramite} no existe en la tabla (validación correcta).
    END

Verificar Boton Sin Fallar
    [Arguments]    ${locator}    ${nombreBoton}

    #agregue: para desplazarme hasta el boton
    ${status}    ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator}

    Run Keyword If    '${status}' == 'FAIL'    Log    El botón con locator ${nombreBoton} NO está visible    WARN
    Run Keyword If    '${status}' == 'PASS'    Log To Console    El botón con locator ${nombreBoton} está visible.

Verificar si el boton no existe Sin Fallar
    [Arguments]    ${locator}    ${nombreBoton}

    #agregue: para desplazarme hasta el boton
    ${status}    ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator}

    Run Keyword If    '${status}' == 'FAIL'    Log    El botón con locator ${nombreBoton} no esta visible y es correcto
    Run Keyword If    '${status}' == 'PASS'    Log    El botón con locator ${nombreBoton} está visible y no deberia    WARN

Verificar Toast
    [Arguments]    ${tipo_esperado}    ${mensaje_esperado}    ${modo_validacion}=exacto    ${timeout}=3s
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    css:.jq-toast-single     ${timeout}
    IF    ${visible}
        ${heading_visible}=    Run Keyword And Return Status    Element Should Be Visible    css:.jq-toast-heading
        IF    ${heading_visible}
            ${tipo_real}=    Get Text    css:.jq-toast-heading
        ELSE
            ${tipo_real}=    Set Variable    ''
        END
        ${mensaje_completo}=    Get Text    css:.jq-toast-single
        ${mensaje_real}=    Remove String    ${mensaje_completo}    ${tipo_real}
        ${mensaje_real}=    Strip String    ${mensaje_real}
        Log    Tipo esperado: ${tipo_esperado} | Tipo real: ${tipo_real}
        Log    Mensaje esperado: ${mensaje_esperado} | Mensaje real: ${mensaje_real}
        ${tipo_ok}=    Run Keyword And Return Status    Should Be Equal As Strings    ${tipo_real}    ${tipo_esperado}
        IF    '${modo_validacion}' == 'exacto'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Be Equal As Strings    ${mensaje_real}    ${mensaje_esperado}
        ELSE IF    '${modo_validacion}' == 'contiene'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Contain    ${mensaje_real}    ${mensaje_esperado}
        ELSE IF    '${modo_validacion}' == 'regex'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Match Regexp    ${mensaje_real}    ${mensaje_esperado}
        ELSE
            Fail    Modo de validación '${modo_validacion}' no soportado.
        END
        IF    not ${tipo_ok} or not ${mensaje_ok}
            Log    Toast no coincide. Esperado: [${mensaje_esperado}] | Recibido: [${mensaje_real}]    WARN
        ELSE
            Log    Toast validado correctamente: [${tipo_real}] - [${mensaje_real}]
        END
        Captura Screenshot In Log
    ELSE
        Log    El toast no apareció en el tiempo esperado (${timeout}).    WARN
        Captura Screenshot In Log
    END
${tipo_real_normalizado}=    Normalizar texto    ${tipo_real}
${tipo_esperado_normalizado}=    Normalizar texto    ${tipo_esperado}
${tipo_valido}=    Run Keyword And Return Status    Should Contain    ${tipo_real_normalizado}    ${tipo_esperado_normalizado}
    IF    ${tipo_valido}
        Log    Toast validado correctamente: [${tipo_real}] - [${mensaje_real}]
    ELSE
        Captura Screenshot In Log
        Fail    El tipo de Toast no coincide. Esperado que contenga: [${tipo_esperado}] | Recibido: [${tipo_real}]    WARN
    END
    Sleep  1s

Verificar presencia de
    [Arguments]    ${elemento}    ${mensajeExtra}
    Wait Until Element Is Visible    ${elemento}    timeout=7s
    ${existe} =    Run Keyword And Return Status    Page Should Contain Element    ${elemento}
    IF    not ${existe}
        Captura Screenshot In Log
        Fail    ${mensajeExtra}
    END

Verificar no presencia de
    [Arguments]    ${elemento}    ${mensajeExtra}
    Wait Until Element Is Visible    ${elemento}    timeout=7s
    ${existe} =    Run Keyword And Return Status    Page Should Contain Element    ${elemento}
    IF    ${existe}
        Captura Screenshot In Log
        Fail    ${mensajeExtra}
    END

Verificar presencia parcial
    [Arguments]    ${textoEsperado}    ${mensajeExtra}
    Wait Until Page Contains    ${textoEsperado}    timeout=7s
    ${existe}=    Run Keyword And Return Status    Page Should Contain    ${textoEsperado}
    IF    not ${existe}
        Captura Screenshot In Log
        Fail    ${mensajeExtra}
    END

Verificar Boton Con Texto
    [Arguments]    ${texto}
    ${xpath}=    Set Variable    xpath=//a[contains(@class, 'page-link') and normalize-space(.)='${texto}']
    Wait Until Page Contains Element    ${xpath}    timeout=10s
    Scroll Element Into View    ${xpath}
    Wait Until Element Is Visible    ${xpath}    timeout=5s
    Element Should Be Visible    ${xpath}

Scroll Element Into View
    [Arguments]    ${xpath}
    ${element}=    Get WebElement    ${xpath}
    Execute JavaScript    arguments[0].scrollIntoView(true);    ${element}

Verificar alerta
    [Arguments]    ${esperado}    ${accion}
    ${alerta}=    Handle Alert    action=${accion}
    IF    '${alerta}' != '${esperado}'
        Captura Screenshot In Log
        Log    Se esperaba el mensaje: "${esperado}" pero aparecio: "${alerta}"    WARN
    END
    Sleep  2s

Captura Screenshot In Log
    [Arguments]    ${mensaje}=Captura
    ${VISUALIZAR_IMAGEN}=    Embed Clean Resized Base64    ${mensaje}
    Log    ${VISUALIZAR_IMAGEN}    html=True

Verificar y presionar ítem en lista
    [Arguments]    ${selector}    ${item}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        Select From List By Label    ${selector}    ${item}
    ELSE
        Captura Screenshot In Log    ${selector}
        Fail    No se pudo seleccionar el ítem: "${item}"
    END

Verificar y presionar ítem en lista index
    [Arguments]    ${selector}    ${item}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        Select From List By Index    ${selector}    ${item}
    ELSE
        Captura Screenshot In Log    ${selector}
        Fail    No se pudo seleccionar el ítem: "${item}"
    END



#Validar Automatico--------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Validar y completar campo
    [Arguments]    ${selector}    ${valor}    ${mensaje}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        Input Text    ${selector}    ${valor}
    ELSE
        Captura Screenshot In Log    ${mensaje}
        Fail    No se pudo completar el campo: ${mensaje}
    END

Validar y hacer clic en el boton
    [Arguments]    ${selector}    ${mensaje}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        ${habilitado} =    Run Keyword And Return Status    Element Should Be Enabled    ${selector}
        IF    ${habilitado}
            Click Element    ${selector}
        ELSE
            Captura Screenshot In Log    ${mensaje}
            Fail    No se puede hacer clic en el boton: ${mensaje}
        END
    ELSE
        Captura Screenshot In Log    ${mensaje}
        Fail    Boton no encontrado: ${mensaje}
    END

Validar y hacer clic en el boton2
    [Arguments]    ${selector}    ${mensaje}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        ${habilitado} =    Run Keyword And Return Status    Element Should Be Enabled    ${selector}
        IF    ${habilitado}
            Click Element    ${selector}
            Sleep  1s
            Click Element    ${selector}
        ELSE
            Captura Screenshot In Log    ${mensaje}
            Fail    No se puede hacer clic en el boton: ${mensaje}
        END
    ELSE
        Captura Screenshot In Log    ${mensaje}
        Fail    Boton no encontrado: ${mensaje}
    END

Validar y hacer clic en la seccion
    [Arguments]    ${selector}    ${mensaje}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        ${habilitado} =    Run Keyword And Return Status    Element Should Be Enabled    ${selector}
        IF    ${habilitado}
            Click Element    ${selector}
        ELSE
            Captura Screenshot In Log    ${mensaje}
            Fail    No se puede hacer clic en la seccion: ${mensaje}
        END
    ELSE
        Captura Screenshot In Log    ${mensaje}
        Fail    Seccion no encontrada: ${mensaje}
    END


#MENSAJES ERROR------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Mensaje error
    Captura Screenshot In Log
    Fail    Error: se detecto Acceso bloqueado

#KEYWORDS SIN TESTEAR------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

Seleccionar Item en Select2
    [Arguments]    ${selector}    ${item}
    # Abrir el dropdown
    Click Element    ${selector}
    Sleep    2s

    # Esperar que aparezca el contenedor de opciones
    Wait Until Element Is Visible    css:.select2-results__options    timeout=5s

    # Buscar el ítem por texto visible
    ${xpath_item}=    Set Variable    //li[contains(@class,"select2-results__option") and normalize-space(.)="${item}"]
    Wait Until Element Is Visible    xpath=${xpath_item}    timeout=5s
    Click Element    xpath=${xpath_item}
    Sleep    2s

Verificar Cambio de Estadísticas por Fecha
    [Arguments]    ${desde}    ${hasta}
    ${stats_antes}=    Obtener Estadísticas
    Cambiar Fechas    ${desde}    ${hasta}
    Click Button    ${filtar}
    Sleep  1s
    Wait Until Element Is Visible     id=total    timeout=10s
    ${stats_despues}=    Obtener Estadísticas
    Validar Cambio de Estadísticas    ${stats_antes}    ${stats_despues}

Obtener Estadísticas
    ${total}=         Get Text    id=total
    ${revisar}=       Get Text    id=revisar
    ${revisadas}=     Get Text    id=revisadas
    ${rechazadas}=    Get Text    id=rechazadas
    ${observados}=    Get Text    id=observados
    ${reingresados}=  Get Text    id=reingresados
    ${stats}=    Create Dictionary
    ...    total=${total}
    ...    revisar=${revisar}
    ...    revisadas=${revisadas}
    ...    rechazadas=${rechazadas}
    ...    observados=${observados}
    ...    reingresados=${reingresados}
    RETURN    ${stats}

Cambiar Fechas
    [Arguments]    ${desde}    ${hasta}
    Clear Element Text    ${fechaDesde}
    Input Text    ${fechaDesde}    ${desde}
    Sleep  1s
    Clear Element Text    ${fechaHasta}
    Input Text    ${fechaHasta}    ${hasta}
    Sleep  1s

Validar Cambio de Estadísticas
    [Arguments]    ${antes}    ${despues}
    ${son_iguales}=    Evaluate    ${antes} == ${despues}
    IF    ${son_iguales}
        Captura Screenshot In Log
        Fail    Las estadisticas no cambiaron
    ELSE
        Log To Console    Las estadisticas cambiaron correctamente
    END

Seleccionar archivo
    [Arguments]    ${tipoArchivo}    ${rutaArchivo}
    ${selector}    Set Variable    xpath=//input[@type='file' and contains(@name, '${tipoArchivo}')]
    Wait Until Element Is Visible    ${selector}    10s
    Choose File    ${selector}    ${rutaArchivo}


Seleccionar archivo de factura
    [Arguments]    ${selectorInputFile}    ${rutaArchivo}
    Wait Until Element Is Visible    ${selectorInputFile}    10s
    Choose File    ${selectorInputFile}    ${rutaArchivo}

Verificar Toast con fail
    [Arguments]    ${mensaje_esperado}    ${modo_validacion}=exacto    ${timeout}=3s
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    css:.jq-toast-single    ${timeout}
    IF    ${visible}
        ${heading_visible}=    Run Keyword And Return Status    Element Should Be Visible    css:.jq-toast-heading
        IF    ${heading_visible}
            ${tipo_raw}=    Get Text    css:.jq-toast-heading
        ELSE
            ${tipo_raw}=    Set Variable    ''
        END

        ${mensaje_completo}=    Get Text    css:.jq-toast-single
        ${mensaje_real}=    Remove String    ${mensaje_completo}    ${tipo_raw}
        ${mensaje_real}=    Strip String    ${mensaje_real}
        ${tipo_normalizado}=    Normalizar texto    ${tipo_raw}
        ${mensaje_normalizado}=    Normalizar texto    ${mensaje_real}
        ${esperado_normalizado}=    Normalizar texto    ${mensaje_esperado}

        Log    Tipo detectado: ${tipo_normalizado}
        Log    Mensaje detectado: ${mensaje_normalizado}
        IF    '${modo_validacion}' == 'exacto'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Be Equal As Strings    ${mensaje_normalizado}    ${esperado_normalizado}
        ELSE IF    '${modo_validacion}' == 'contiene'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Contain    ${mensaje_normalizado}    ${esperado_normalizado}
        ELSE IF    '${modo_validacion}' == 'regex'
            ${mensaje_ok}=    Run Keyword And Return Status    Should Match Regexp    ${mensaje_normalizado}    ${esperado_normalizado}
        ELSE
            Fail    Modo de validación '${modo_validacion}' no soportado.
        END
        Captura Screenshot In Log
        IF    'error' in '${tipo_normalizado}'
            Log    Se detectó un toast de error: ${mensaje_real}    WARN
            Captura Screenshot In Log
            Fail    Error detectado en toast: ${mensaje_real}
        ELSE IF    'éxito' in '${tipo_normalizado}' or 'exito' in '${tipo_normalizado}' or 'success' in '${tipo_normalizado}'
            Log To Console    Se detectó un toast de éxito: ${mensaje_real}
            Buscar y Eliminar Usuario
            Log To Console    ${mensaje_real}
        ELSE
            Log    Tipo de toast no reconocido: ${tipo_raw}    WARN
        END
    ELSE
        Log    El toast no apareció en el tiempo esperado (${timeout}).    WARN
        Captura Screenshot In Log
    END

Normalizar texto
    [Arguments]    ${texto}
    ${texto}=    Replace String    ${texto}    \n    ${SPACE}
    ${texto}=    Replace String    ${texto}    \r    ${EMPTY}
    ${texto}=    Strip String    ${texto}
    ${texto}=    Convert To Lowercase    ${texto}
    ${texto}=    Remove String    ${texto}    !
    ${texto}=    Remove String    ${texto}    .
    ${texto}=    Remove String    ${texto}    :
    RETURN    ${texto}

Scroll navegador
[Arguments]    ${x}  ${y}
    Execute JavaScript    Window.scrollTo(${x}, ${y})

Click Por Coordenadas
    click element at coordinates    xpath:xpath    coordenadaX    coordenadaY

Validar Toast Completo
    [Arguments]    ${tipo_esperado}    ${mensaje_esperado}    ${modo_validacion}=contiene    ${timeout}=3s    ${normalizar_mensaje}=False
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    css:.jq-toast-single    ${timeout}
    IF    not ${visible}
        Log    El toast no apareció en el tiempo esperado (${timeout}).    WARN
        Captura Screenshot In Log
        Fail    No se detectó ningún toast en pantalla.
    END

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
        Log    El mensaje del toast no coincide. Esperado: [${mensaje_esperado}] | Recibido: [${mensaje_real}]    WARN
        Captura Screenshot In Log
    ELSE
        Log    Toast validado correctamente: [${tipo_raw}] - [${mensaje_real}]
    END

Validar Toast Completo Con MensajeLog
    [Arguments]    ${tipo_esperado}    ${mensaje_esperado}    ${mensajeLog}    ${modo_validacion}=contiene    ${timeout}=3s    ${normalizar_mensaje}=False
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    css:.jq-toast-single    ${timeout}
    IF    not ${visible}
        Log    El toast no apareció en el tiempo esperado (${timeout}).    WARN
        Captura Screenshot In Log
        Fail    No se detectó ningún toast en pantalla.
    END

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
        Log    ${mensajeLog}    WARN
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
        Log    El mensaje del toast no coincide. Esperado: [${mensaje_esperado}] | Recibido: [${mensaje_real}]    WARN
        Captura Screenshot In Log
    ELSE
        Log    Toast validado correctamente: [${tipo_raw}] - [${mensaje_real}]
    END


#-------------------------------------------------------------------VALIDAR TABLA CON FECHA-------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------VALIDAR TABLA CON FECHA-------------------------------------------------------------------------------------------------
#-------------------------------------------------------------------VALIDAR TABLA CON FECHA-------------------------------------------------------------------------------------------------
Validar Orden Fechas En Tabla
    [Arguments]    ${XPATH_COLUMNA_DATOS}    ${XPATH_BOTON_SIGUIENTE}    ${XPATH_PAGINA_ACTUAL}    ${nombre_columna}    ${direccion}=ASC

    @{valores_globales}=    Create List

    ${pagina_anterior}=    Get Text    ${XPATH_PAGINA_ACTUAL}

    ${pagina_anterior}=    Strip String    ${pagina_anterior}
    ${pagina_anterior}=    Replace String    ${pagina_anterior}    \n    ''
    ${pagina_anterior}=    Replace String    ${pagina_anterior}    \r    ''
    ${pagina_anterior}=    Replace String    ${pagina_anterior}    ' '    ''

    WHILE    True
        @{celdas}=    Get WebElements    ${XPATH_COLUMNA_DATOS}
        FOR    ${celda}    IN    @{celdas}
            ${texto}=    Get Text    ${celda}
            ${texto}=    Strip String    ${texto}
            Run Keyword If    '${texto}' != ''    Append To List    ${valores_globales}    ${texto}
        END

        Click Element    ${XPATH_BOTON_SIGUIENTE}
        Sleep    1s

        ${pagina_actual}=    Get Text    ${XPATH_PAGINA_ACTUAL}

        ${pagina_actual}=    Strip String    ${pagina_actual}
        ${pagina_actual}=    Replace String    ${pagina_actual}    \n    ''
        ${pagina_actual}=    Replace String    ${pagina_actual}    \r    ''
        ${pagina_actual}=    Replace String    ${pagina_actual}    ' '    ''

        Log To Console    Página anterior: '${pagina_anterior}' | Página actual: '${pagina_actual}'

        Run Keyword If    '${pagina_actual}' == '${pagina_anterior}'    Exit For Loop
        ${pagina_anterior}=    Set Variable    ${pagina_actual}
    END

    Log To Console    \nValores extraídos de TODAS las páginas: ${valores_globales}
    Verificar Orden Fechas Flexible    ${valores_globales}    ${nombre_columna}    ${direccion}

Validar Orden Fechas En Tabla Con Boton Next
    [Arguments]    ${NumeroDeColumna}    ${XPATH_BOTON_SIGUIENTE}    ${nombre_columna}    ${direccion}=ASC

    @{valores_globales}=    Create List

    WHILE    True
        @{celdas}=    Get WebElements    //table//tbody/tr/td[${NumeroDeColumna}]
        FOR    ${celda}    IN    @{celdas}
            ${texto}=    Get Text    ${celda}
            ${texto}=    Strip String    ${texto}
            Run Keyword If    '${texto}' != ''    Append To List    ${valores_globales}    ${texto}
        END

        ${clase_next}=    Get Element Attribute    ${XPATH_BOTON_SIGUIENTE}    class
#       Quitarle el comentario a la siguiente linea si queres ver el estado del boton next
#        Log To Console    Clase del botón Next: '${clase_next}'
        Run Keyword If    'disabled' in '${clase_next}'    Exit For Loop

        Click Element    ${XPATH_BOTON_SIGUIENTE}
        Sleep    1s
    END

    Log To Console    \nValores extraídos de TODAS las páginas: ${valores_globales}
    Verificar Orden Fechas Flexible    ${valores_globales}    ${nombre_columna}    ${direccion}

Verificar Orden Fechas Flexible
    [Arguments]    ${lista_original}    ${nombre_columna}    ${direccion}=ASC

    ${lista_normalizada}=    Normalizar Fechas Flexible    ${lista_original}
    ${lista_ordenada}=       Copy List    ${lista_normalizada}
    Sort List                ${lista_ordenada}
    Run Keyword If    '${direccion.upper()}' == 'DESC'    Reverse List    ${lista_ordenada}

    ${esta_ordenada}=    Run Keyword And Return Status
    ...    Lists Should Be Equal    ${lista_normalizada}    ${lista_ordenada}

    IF    ${esta_ordenada} == ${TRUE}
        Log To Console    La columna '${nombre_columna}' está correctamente ordenada de forma ${direccion}
        Log    La columna '${nombre_columna}' está correctamente ordenada de forma ${direccion}
    ELSE
        Log    La columna '${nombre_columna}' no está ordenada de forma ${direccion}
        Log    Orden Actual (normalizado): ${lista_normalizada}
        Log    Orden Esperado: ${lista_ordenada}
        Captura Screenshot In Log
        Fail    La columna '${nombre_columna}' no está en el orden esperado de forma ${direccion}.
    END

Normalizar Fechas Flexible
    [Arguments]    ${lista_fechas}
    @{fechas_normalizadas}=    Create List

    FOR    ${fecha}    IN    @{lista_fechas}
        ${fecha}=    Strip String    ${fecha}
        ${tiene_hora}=    Run Keyword And Return Status    Should Contain    ${fecha}    ' '
        ${solo_fecha}=    Set Variable    ${fecha}
        ${hora}=         Set Variable    00:00:00
        IF    ${tiene_hora}
            ${partes}=    Split String    ${fecha}    ' '
            ${solo_fecha}=    Set Variable    ${partes[0]}
            ${hora}=         Set Variable    ${partes[1]}
        END
        ${tokens}=    Split String    ${solo_fecha}    -
        ${primer_token}=    Set Variable    ${tokens[0]}
        ${es_dia_primero}=    Run Keyword And Return Status    Length Should Be    ${primer_token}    2
        IF    ${es_dia_primero}
            ${dia}=    Set Variable    ${tokens[0]}
            ${mes}=    Set Variable    ${tokens[1]}
            ${anio}=   Set Variable    ${tokens[2]}
        ELSE
            ${anio}=   Set Variable    ${tokens[0]}
            ${mes}=    Set Variable    ${tokens[1]}
            ${dia}=    Set Variable    ${tokens[2]}
        END
        ${fecha_iso}=    Set Variable    ${anio}-${mes}-${dia} ${hora}
        Append To List    ${fechas_normalizadas}    ${fecha_iso}
    END
    RETURN    @{fechas_normalizadas}

#-------------------------------------------------------------------VALIDAR TABLA ALFABETICAMENTE-------------------------------------------------------------------------------------------
#-------------------------------------------------------------------VALIDAR TABLA ALFABETICAMENTE-------------------------------------------------------------------------------------------
#-------------------------------------------------------------------VALIDAR TABLA ALFABETICAMENTE-------------------------------------------------------------------------------------------

Validar Orden Alfabetico En Tabla Con Boton Next
    [Arguments]    ${NumeroDeColumna}    ${XPATH_BOTON_SIGUIENTE}    ${nombre_columna}    ${direccion}=ASC

    @{valores_globales}=    Create List
    ${contador_pagina}=    Set Variable    1

    WHILE    True
        @{celdas}=    Get WebElements    //table//tbody/tr/td[${NumeroDeColumna}]
        ${cantidad}=    Get Length    ${celdas}

        @{textos}=    Create List
        FOR    ${celda}    IN    @{celdas}
            ${texto}=    Get Text    ${celda}
            ${texto}=    Strip String    ${texto}
            ${es_valido}=    Run Keyword And Return Status    Should Not Be Empty    ${texto}
            IF    ${es_valido}
                Append To List    ${valores_globales}    ${texto}
            END
        END

        ${valores_globales}=    Create List    @{valores_globales}    @{textos}

        ${clase_next}=    Get Element Attribute    ${XPATH_BOTON_SIGUIENTE}    class
        Run Keyword If    'disabled' in '${clase_next}'    Exit For Loop

        Click Element    ${XPATH_BOTON_SIGUIENTE}
        Sleep    1s
        ${contador_pagina}=    Evaluate    ${contador_pagina} + 1
    END

    Log To Console    \nValores extraídos de TODAS las páginas: ${valores_globales}
    Verificar Orden Alfabetico Normalizado    ${valores_globales}    ${nombre_columna}    ${direccion}

Validar Orden Alfabetico En Tabla
    [Arguments]    ${XPATH_COLUMNA_DATOS}    ${XPATH_BOTON_SIGUIENTE}    ${XPATH_PAGINA_ACTUAL}    ${nombre_columna}    ${direccion}=ASC

    @{valores_globales}=    Create List
    ${pagina_anterior}=    Get Text    ${XPATH_PAGINA_ACTUAL}

    WHILE    True
        @{celdas}=    Get WebElements    ${XPATH_COLUMNA_DATOS}
        FOR    ${celda}    IN    @{celdas}
            ${texto}=    Get Text    ${celda}
            ${texto}=    Strip String    ${texto}
            Run Keyword If    '${texto}' != ''    Append To List    ${valores_globales}    ${texto}
        END
        Click Element    ${XPATH_BOTON_SIGUIENTE}
        Sleep    1s
        ${pagina_actual}=    Get Text    ${XPATH_PAGINA_ACTUAL}
        Run Keyword If    '${pagina_actual}' == '${pagina_anterior}'    Exit For Loop
        ${pagina_anterior}=    Set Variable    ${pagina_actual}
    END

    Log To Console    \nValores extraídos de TODAS las páginas: ${valores_globales}
    Verificar Orden Alfabetico Normalizado    ${valores_globales}    ${nombre_columna}    ${direccion}

Verificar Orden Alfabetico Normalizado
    [Arguments]    ${lista_original}    ${nombre_columna}    ${direccion}=ASC

    ${lista_normalizada}=    Normalizar Texto Para Ordenamiento    ${lista_original}
    ${lista_ordenada}=       Copy List    ${lista_normalizada}
    Sort List                ${lista_ordenada}
    Run Keyword If    '${direccion.upper()}' == 'DESC'    Reverse List    ${lista_ordenada}

    ${esta_ordenada}=    Run Keyword And Return Status
    ...    Lists Should Be Equal    ${lista_normalizada}    ${lista_ordenada}

    IF    ${esta_ordenada} == ${TRUE}
        Log To Console    La columna '${nombre_columna}' está correctamente ordenada de forma ${direccion}.
        Log    La columna '${nombre_columna}' está correctamente ordenada de forma ${direccion}.
    ELSE
        Log    La columna '${nombre_columna}' no está ordenada de forma ${direccion}.
        Log    Orden Actual (normalizado): ${lista_normalizada}
        Log    Orden Esperado: ${lista_ordenada}
        Captura Screenshot In Log
        Fail    La columna '${nombre_columna}' no está en el orden esperado de forma ${direccion}.
    END

Normalizar Texto Para Ordenamiento
    [Arguments]    ${lista}
    @{normalizada}=    Create List
    FOR    ${item}    IN    @{lista}
        ${item}=    Strip String    ${item}
#comentar la siguiente linea dependiendo la tabla
        ${item}=    Convert To Lowercase    ${item}
        ${item}=    Evaluate    ''.join(c for c in unicodedata.normalize('NFD', '''${item}''') if unicodedata.category(c) != 'Mn')    modules=unicodedata
        Append To List    ${normalizada}    ${item}
    END
    RETURN    @{normalizada}

Verificar presencia de... con...
    [Arguments]    ${campo_localizador}    ${frase_texto}

    #Verificar el texto esperado
    ${status_texto}=    Run Keyword And Return Status    Wait Until Page Contains    ${frase_texto}

    #Obtener el texto real del elemento
    ${texto_real}=    Run Keyword And Ignore Error    Get Text    ${campo_localizador}
    #Para que solo muestre la frase
    ${texto_real}=    Set Variable    ${texto_real}[1]

    #mensajes
    Run Keyword If    ${status_texto}
    ...    Log    ÉXITO: El mensaje "${frase_texto}" fue encontrado.
    ...    ELSE
    ...    Run Keywords
    ...    KeywordsMio.Captura Screenshot In Log
    ...    AND
    ...    Fail    FALLO: No se encontró la frase esperada "${frase_texto}", sino que apareció: "${texto_real}".

Verificar NO presencia de... con...
    [Arguments]    ${campo_localizador}    ${frase_texto}

    #Verificar el texto esperado
    ${status_texto}=    Run Keyword And Return Status    Wait Until Page Contains    ${frase_texto}    timeout=10s

    #Obtener el texto real del elemento
    ${texto_real}=    Run Keyword And Ignore Error    Get Text    ${campo_localizador}
    #Para que solo muestre la frase
    ${texto_real}=    Set Variable    ${texto_real}[1]

    #mensajes
    Run Keyword If    not ${status_texto}
    ...    Log    ÉXITO: El mensaje "${frase_texto}" fue encontrado.
    ...    ELSE
    ...    Run Keywords
    ...    KeywordsMio.Captura Screenshot In Log
    ...    AND
    ...    Fail    FALLO: Se encontró "${frase_texto}", cuando no deberia estar.

#    NUEVAS KEYWORDS   CIUDADANO/PERSONAL

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

Verificar Numero de Seguimiento
    [Arguments]    ${codigo_esperado}
    Wait Until Element Is Visible    //label[normalize-space()='Número de Seguimiento']    timeout=5s
    Log    El <p> con clase 'text-muted-foreground mt-1' está visible
    ${codigo_actual}=    Get Text    (//p[@class='font-mono'])[1]
    Log    Codigo de tramite capturado: ${codigo_actual}
    Run Keyword If    '${codigo_actual}' != '${codigo_esperado}'    Fail    El Numero de Seguimiento no coincide con el esperado. Se esperaba: '${codigo_esperado}', sin embargo aparecio: '${codigo_actual}'
    Log    El asunto coincide con el valor esperado

Comparar Fecha Creacion
    [Arguments]    ${FECHA_RAW}
    ${partes}=    Split String    ${FECHA_RAW}    ,
    ${FECHA_SOLO}=    Strip String    ${partes[0]}
    Log To Console    Fecha sin hora: ${FECHA_SOLO}

    ${FECHA_ISO}=    Convertir Fecha Slash A ISO    ${FECHA_SOLO}
    ${FECHA_ACTUAL}=    Get Current Date    result_format=%Y-%m-%d

    Log To Console    Fecha actual: ${FECHA_ACTUAL}
    Log To Console    Fecha extraída (ISO): ${FECHA_ISO}

    Should Be Equal    ${FECHA_ISO}    ${FECHA_ACTUAL}
    Log To Console    La fecha de creación coincide con la fecha actual

Convertir Fecha Slash A ISO
    [Arguments]    ${fecha_slash}
    ${partes}=    Split String    ${fecha_slash}    /
    ${dia}=    Strip String    ${partes[0]}
    ${mes}=    Strip String    ${partes[1]}
    ${anio}=    Strip String    ${partes[2]}
    ${fecha_iso}=    Set Variable    ${anio}-${mes}-${dia.zfill(2)}
    RETURN    ${fecha_iso}

Validar Datos Identidad
    [Arguments]    ${nombreEsperado}    ${emailEsperado}    ${dniEsperado}

    ${nombreHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//h4[contains(@class, 'font-semibold')]
    Log To Console    \nNombre extraido: ${nombreHTML}
    Should Contain    ${nombreHTML}    ${nombreEsperado}

    ${emailHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//p[contains(text(), '@')]
    Log To Console    Email extraido: ${emailHTML}
    Should Be Equal    ${emailHTML}    ${emailEsperado}

    ${dniHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//p[contains(text(), 'DNI')]
    Log To Console    DNI extraido: ${dniHTML}
    Should Contain    ${dniHTML}    ${dniEsperado}

Validar Area Asignada
    [Arguments]    ${areaEsperada}
    ${areaHTML}=    Get Text    xpath=//label[normalize-space(.)='Área Asignada']/following-sibling::div//span
    Log To Console    Area extraida: ${areaHTML}

    IF    "${areaHTML}" == "${areaEsperada}"
        Log To Console    Area asignada coincide con la esperada
    ELSE
        Fail    Area asignada no coincide: se esperaba '${areaEsperada}' pero se encontró '${areaHTML}'
    END