***Settings***
Library  SeleniumLibrary
Library    String
Library  BuiltIn



*** Keywords ***
#Navegador-----------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Abrir Navegador
    Open Browser    ${page}    ${browser}
    Maximize Browser Window
    Sleep    2s

Cerrar Navegador
    Close browser
    Sleep  2s

Abrir Navegador en modo incognito
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
    Sleep  2s

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

#Verificar Automatico------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
    Sleep  2s

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
    Sleep  2s

Verificar y presionar ítem en lista index
    [Arguments]    ${selector}    ${item}
    ${visible} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${selector}    timeout=5s
    IF    ${visible}
        Select From List By Index    ${selector}    ${item}
    ELSE
        Captura Screenshot In Log    ${selector}
        Fail    No se pudo seleccionar el ítem: "${item}"
    END
    Sleep  2s


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
    Sleep  2s

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
    Sleep  2s

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
    Sleep  2s

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
    Sleep  2s

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




