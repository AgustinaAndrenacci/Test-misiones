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

Suite Setup    Inicializar Contador

***Test Cases***

#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------

Test 1 - Consulta Tributaria: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 1 - Consulta Tributaria Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test1  contenidoConsultaTributaria
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria Cancelar Tramite [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 1 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 1 - Consulta Tributaria verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Tributaria: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Tributaria: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------


Test 2 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 2 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 2 - Consulta Vinculante Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y completar campo    ${asuntoConsultaVinculante}  Asunto test1    asuntoConsultaVinculante
    Validar y completar campo    ${detalleConsultaVinculante}  Descripcion test1  detalleConsultaVinculante
    Validar y completar campo    ${contenidoConsultaVinculante}  Contenido test1  contenidoConsultaVinculante
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Vinculante Cancelar Tramite [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Vinculante verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 2 - Consulta Vinculante verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 2 - Consulta Vinculante verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta Vinculante
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------
#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------
#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------


Test 3 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 3 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 3 - ExencionImpuestoInmobiliarioBasico Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoIB
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Validar y completar campo    ${contenidoExencionImpuestoIB}  Contenido test1  contenidoExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que acredite la titularidad del inmueble
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - ExencionImpuestoInmobiliarioBasico Cancelar Tramite [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - ExencionImpuestoInmobiliarioBasico verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 3 - ExencionImpuestoInmobiliarioBasico verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 3 - ExencionImpuestoInmobiliarioBasico verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------


#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA TRIBUTARIA--------------------------------------------------------------------------------

Test 4 - Consulta Tributaria: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 4 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 4 - Consulta Tributaria Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test1  contenidoConsultaTributaria
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Tributaria: cancelar tramite desde el tacho [ciudadano] Paso 2
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.

Test 4 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 4 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 4 - Consulta Tributaria verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Tributaria: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Tributaria: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Tributaria: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------
#-----------------------------------------------------CONSULTA VINCULANTE--------------------------------------------------------------------------------


Test 5 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 5 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 5 - Consulta Vinculante Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y completar campo    ${asuntoConsultaVinculante}  Asunto test1    asuntoConsultaVinculante
    Validar y completar campo    ${detalleConsultaVinculante}  Descripcion test1  detalleConsultaVinculante
    Validar y completar campo    ${contenidoConsultaVinculante}  Contenido test1  contenidoConsultaVinculante
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante: cancelar tramite desde el tacho [ciudadano] Paso 2
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite2}
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.

Test 5 - Consulta Vinculante verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 5 - Consulta Vinculante verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 5 - Consulta Vinculante verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la consulta Vinculante
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------
#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------
#-----------------------------------------------------EXENCION IMPUESTO INMOVILIARIO BASICO--------------------------------------------------------------


Test 6 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 6 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... cancelar tramite [ciudadano]
    ...    ... chequear estado cancelado [ciudadano]
    ...    ... verificar que no aparezca el tramite [operador mesa]
    ...    ... verificar que no aparezca el tramite [secretaria]
    ...    ... verificar que no aparezca el tramite [gestion]
    Log To Console    Comentario del proceso

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoIB
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Validar y completar campo    ${contenidoExencionImpuestoIB}  Contenido test1  contenidoExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que acredite la titularidad del inmueble
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - ExencionImpuestoInmobiliarioBasico: cancelar tramite desde el tacho [ciudadano] Paso 2
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite2}
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.

Test 6 - ExencionImpuestoInmobiliarioBasico verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 6 - ExencionImpuestoInmobiliarioBasico verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 6 - ExencionImpuestoInmobiliarioBasico verificar Estado Cancelado [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Verifica que el ciudadano pueda ver correctamente el Estado de la ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Estado Del Tramite    Cancelado
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - ExencionImpuestoInmobiliarioBasico: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}