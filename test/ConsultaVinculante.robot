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

Test 1 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite como borrador [ciudadano]
    ...    ... chequear estado del tramite(borrador) [ciudadano]
    ...    ... chequear que no aparezca el tramite(borrador) [operador mesa]
    ...    ... pasar de borrador a guardado [ciudadano]
    ...    ... chequear estado del tramite(pendiente) [ciudadano]
    ...    ... chequear estado del tramite(pendiente) [operador mesa]
    Log To Console    Comentario del proceso

Test 1 - Consulta Vinculante Como Borrador [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante como borrador
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
    Verificar y presionar ítem en lista    ${select}    Documentación Específica
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que origina el acto
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 1 - Consulta Vinculante GuardarBorrador Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite(borrador) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica que el tramite(borrador) no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Vinculante: pasar de borrador a guardado [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el ciudadano, se entra al tramite y se guarda para que deje de estar en borrador
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    abrirTramiteGenerado
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Vinculante: verificar el estado del tramite (pendiente) [ciudadano] Paso 2
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite(borrador) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica que el tramite(borrador) no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 2 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... verificar estado del tramite [operador mesa]
    ...    ... verificar si los botones de acciones son correctos [operador mesa]
    ...    ... solicitar datos adicionales [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... verifica si se pueden cargar datos adicionales [ciudadano]
    Log To Console    Comentario del proceso

Test 2 - Consulta Vinculante Solicitar Datos Adicionales [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante sin agregar abjuntos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Sleep  1s
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 2 - Consulta Vinculante Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 2 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Consulta Vinculante: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 2 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 2 - Consulta Vinculante agregar nota [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s


Test 2 - Consulta Vinculante Solicitar Datos Adicionales [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Vinculante Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 2 - Consulta Vinculante: el ciudadano avanza en el tramite [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    #ATENCION! - Modificar debido a que aún no se sabe el método en que el usuario podrá cargar datos adicionales
    Fail    Fallo: el ciudadano no puede cargar datos adicionales

Test 3 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 3 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... verificar estado del tramite [operador mesa]
    ...    ... verificar si los botones de acciones son correctos [operador mesa]
    ...    ... documentacion no corresponde [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 3 - Consulta Vinculante Documentacion NoCorresponde [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante sin agregar abjuntos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 3 - Consulta Vinculante Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 3 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Consulta Vinculante: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 3 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 3 - Consulta Vinculante agregar nota [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 3 - Consulta Vinculante Documentacion NoCorresponde [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Consulta Vinculante Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló el boton NoCorresponde desde el operador mesa
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 4 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 4 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... no corresponde [secretaria]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... para resolver [secretaria]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... aprobado [gestion]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... informar contribuyente [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta Vinculante completando todos los campos
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

Test 4 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 4 - Consulta Vinculante agregar nota [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (Asignado) [secretaria] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [secretaria] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resover

Test 4 - Consulta Vinculante agregar nota [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como secretaria para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Secretaria para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (Devuelto) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Devuelto

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 4 - Consulta Vinculante Agregar Nota [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa, tramite devuelto    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como operador mesa entrada, continua con el proceso del tramite enviandolo a secretaria nuevamente
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria, todo ok    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (asignado) [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resover

Test 4 - Consulta Vinculante Agregar Nota [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como secretaria para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Secretaria para continuar con el proceso, ahora si utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (En revisión) [gestion] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [gestion] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 4 - Consulta Vinculante Agregar Nota [gestion] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como gestion para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [gestion] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Consulta Vinculante: verificar el estado del tramite (Aprobado) [operador mesa] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Aprobado

Test 4 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada [operador mesa] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Vinculante Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 5 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 5 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... para resolver [secretaria]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... rechazado [gestion]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... informar contribuyente [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 5 - Consulta Vinculante Rechazado desde Gestion [ciudadano] Paso 1
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
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 5 - Consulta Vinculante Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar el estado del tramite (pendiente) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 5 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 5 - Consulta Vinculante Agregar Nota [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Consulta Vinculante Rechazado desde Gestion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar el estado del tramite (Asignado) [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 5 - Consulta Vinculante: verificar si los botones de acciones son correctos [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resover

Test 5 - Consulta Vinculante Agregar Nota [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como secretaria para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Consulta Vinculante Rechazado desde Gestion [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar el estado del tramite (En revisión) [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 5 - Consulta Vinculante: verificar si los botones de acciones son correctos [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 5 - Consulta Vinculante Agregar Nota [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]     Entra como gestion para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Consulta Vinculante Rechazado desde Gestion [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Consulta Vinculante: verificar el estado del tramite (Rechazado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Rechazado

Test 5 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

Test 5 - Consulta Vinculante Rechazado desde Gestion [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Vinculante Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 6 - Consulta Vinculante: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 6 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... para resolver [secretaria]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... aprobado [gestion]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... informar contribuyente [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 6 - Consulta Vinculante Correcta [ciudadano] Paso 1
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
#Ver despues como poder aniadir el ultimo select
#    Verificar y presionar ítem en lista index    xpath=//select    0
#    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

Test 6 - Consulta Vinculante Correcta Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar el estado del tramite (pendiente) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 6 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test 6 - Consulta Vinculante Agregar Nota [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - Consulta Vinculante Correcta [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Consulta Vinculante Correcta Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar el estado del tramite (Asignado) [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Consulta Vinculante: verificar si los botones de acciones son correctos [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resover

Test 6 - Consulta Vinculante Agregar Nota [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como secretaria para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - Consulta Vinculante Correcta [secretaria] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Consulta Vinculante Correcta Chequear Estado Desde Usuario [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar el estado del tramite (En revisión) [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 6 - Consulta Vinculante: verificar si los botones de acciones son correctos [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 6 - Consulta Vinculante Agregar Nota [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como gestion para comprobar que se pueda agregar una nota
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - Consulta Vinculante Correcta [gestion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Gestion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Consulta Vinculante Correcta Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [secretaria] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la secretaria, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar que no aparezca el tramite [gestion] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde la gestion, se verifica que el tramite no se visualice
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Consulta Vinculante: verificar el estado del tramite (Aprobado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Aprobado

Test 6 - Consulta Vinculante: verificar si los botones de acciones son correctos [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

Test 6 - Consulta Vinculante Correcta [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Aprobado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Consulta Vinculante Correcta Chequear Estado Desde Usuario [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado
