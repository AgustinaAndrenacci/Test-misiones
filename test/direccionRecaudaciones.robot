*** Settings ***

Documentation     Se realizan testeos creando tramites verificando si el flujo, los estados, los botones funciona de manera correcta.
...
...               Se realizaron las siguientes pruebas:
...
...               -Test 1: Se crea un tramite de la Direccion de recaudaciones y lo aprueba la misma Direccion de recaudaciones
...
...               -Test 2: Se crea un tramite de la Direccion de recaudaciones y lo rechaza la misma Direccion de recaudaciones
...
...               -Test 3: Se crea un tramite de la Direccion de recaudaciones y desde la misma Direccion selecciona la opcion "No Corresponde"
...
...               -Test 4: Se crea un tramite de la Direccion de recaudaciones y desde la misma Direccion selecciona la opcion "Solicitar Datos Adicionales"
...
...               -Test 5: Se crea un tramite de la Direccion de recaudaciones y lo aprueba el Departamento de impuestos
...
...               -Test 6: Se crea un tramite de la Direccion de recaudaciones y lo rechaza el Departamento de impuestos
...
...               -Test 7: Se crea un tramite de la Direccion de recaudaciones y el Departamento de impuestos solicita datos adicionales
...
...               -Test 8: Se crea un tramite de la Direccion de recaudaciones y lo aprueba el Departamento de Ingresos Brutos y Control de Obligaciones Fiscales
...
...               -Test 9: Se crea un tramite de la Direccion de recaudaciones y lo rechaza el Departamento de Ingresos Brutos y Control de Obligaciones Fiscales
...
...               -Test 10: Se crea un tramite de la Direccion de recaudaciones y el Departamento de Ingresos Brutos y Control de Obligaciones Fiscales solicita datos adicionales
...
...               -Test 11: Se crea un tramite de la Direccion de recaudaciones y lo aprueba el Departamento de Procesamiento y Control de Rendiciones de Agentes Recaudadores
...
...               -Test 12: Se crea un tramite de la Direccion de recaudaciones y lo rechaza el Departamento de Procesamiento y Control de Rendiciones de Agentes Recaudadores
...
...               -Test 13: Se crea un tramite de la Direccion de recaudaciones y el Departamento de Procesamiento y Control de Rendiciones de Agentes Recaudadores solicita datos adicionales
...
...               -Test 14: Se crea un tramite de la Direccion de recaudaciones y lo aprueba el Departamento de Supervisión y Auditoría de Delegaciones
...
...               -Test 15: Se crea un tramite de la Direccion de recaudaciones y lo rechaza el Departamento de Supervisión y Auditoría de Delegaciones
...
...               -Test 16: Se crea un tramite de la Direccion de recaudaciones y el Departamento de Supervisión y Auditoría de Delegaciones solicita datos adicionales

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

Test Teardown  Cerrar navegador

Suite Setup    Inicializar Contador


*** Variables ***
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
${docLean}    ADJUNTO.pdf
#${docLean}    ubicacion.png

*** Test Cases ***

Test 1 - Aprobado desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crea un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Aprobado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 1 - Aprobado desde Direccion de Recaudaciones verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 1 - Aprobado desde Direccion de Recaudaciones [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 1 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 1 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 1 - Verificar que el tramite no exista [operador mesa] Paso 8
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Verificar el estado del tramite (asignado) [DireccionRecaudaciones] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Direccion de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 1 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 10
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 1 - Aprobado desde Direccion de Recaudaciones verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Cerrar Navegador

Test 1 - Aprobado desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Aprobado desde Direccion de Recaudaciones verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 1 - Aprobado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 2 - Rechazado desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crea un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Rechazado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Rechazado desde Direccion de Recaudaciones verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Rechazado desde Direccion de Recaudaciones [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 2 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 2 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 2 - Verificar que el tramite no exista [operador mesa] Paso 8
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Verificar el estado del tramite (asignado) [DireccionRecaudaciones] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Direccion de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 2 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 10
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 2 - Rechazado desde Direccion de Recaudaciones verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Cerrar Navegador

Test 2 - Rechazado desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Rechazado desde Direccion de Recaudaciones verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 2 - Rechazado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 3 - No Corresponde desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crea un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 3 - No Corresponde desde Direccion de Recaudaciones verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 3 - No Corresponde desde Direccion de Recaudaciones [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button

Test 3 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 3 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 3 - Verificar que el tramite no exista [operador mesa] Paso 8
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Verificar el estado del tramite (asignado) [DireccionRecaudaciones] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Direccion de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 3 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 10
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 3 - No Corresponde desde Direccion de Recaudaciones verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 3 - No Corresponde desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonAprobar
    Validar y completar campo    ${campoComentario}    NoCorresponde    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Direccion de Recaudaciones verificar si los botones de acciones son correctos [operador mesa] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 3 - No Corresponde desde Direccion de Recaudaciones [operador mesa] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 15
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Direccion de Recaudaciones verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 16
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 3 - No Corresponde desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 17
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado


Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crea un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button

Test 4 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

Test 4 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 7
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Verificar que el tramite no exista [operador mesa] Paso 8
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Verificar el estado del tramite (asignado) [DireccionRecaudaciones] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Direccion de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 10
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    solicito datos adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones el ciudadano avanza en el tramite [ciudadano] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 15
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 16
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 4 - SolicitarDatosAdicionales desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 17
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado


Test 5 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo aprueba el DEPARTAMENTO DE IMPUESTOS
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 5 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 5 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 5 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 5 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 5 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 5 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado


Test 5 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 5 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 5 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 5 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 5 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Impuestos
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Impuestos
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Impuestos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 5 - Verificar el estado del tramite (asignado) [Impuestos] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 5 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 5 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 5 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 5 - Verificar si los botones de acciones son correctos [Impuestos] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento Impuestos y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 5 - Se selecciona la opcion "Aprobar e informar al contribuyente" [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento Impuestos y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 5 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 5 - Verificar que el tramite no exista [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 5 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado







Test 6 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo rechaza el DEPARTAMENTO DE IMPUESTOS
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 6 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 6 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 6 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 6 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 6 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 6 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 6 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 6 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 6 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 6 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Impuestos
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Impuestos
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Impuestos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 6 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Verificar el estado del tramite (asignado) [Impuestos] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 6 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 6 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 6 - Verificar si los botones de acciones son correctos [Impuestos] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento Impuestos y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 6 - Se selecciona la opcion "Rechazar e informar al contribuyente" [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento Impuestos y utiliza la opcion "botonRechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 6 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 6 - Verificar que el tramite no exista [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Impuestos] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 6 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado



Test 7 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y el DEPARTAMENTO DE IMPUESTOS solicita datos adicionales
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 7 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 7 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 7 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 7 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 7 - Verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 7 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 7 - Verificar que el tramite no exista [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 7 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 7 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 7 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 7 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 7 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Impuestos
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Impuestos
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Impuestos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 7 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 7 - Verificar el estado del tramite (asignado) [Impuestos] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento Impuestos, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 7 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 7 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 7 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 5 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 7 - Verificar si los botones de acciones son correctos [Impuestos] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento Impuestos y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


#Solicito datos **************************************************************************
Test 7 - Se selecciona la opcion "Solicitar datos adicionales" [Impuestos] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como departamento userImpuestos para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Verificacion del estado del tramite (pendiente contribuyente) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 7 - Verificar que el tramite no exista [Impuestos] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userImpuestos, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Pendiente Contribuyente) [operador mesa] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente Contribuyente



Test 7 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 6 7
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 7 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 8
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 7 - El usuario avanza con el tramite [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    Choose FILE    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Verificacion del estado del tramite (En curso) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 7 - Verificar que el tramite exista [Impuestos] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userImpuestos, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 7 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 6 9
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 7 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 10
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 7 - Verificar si los botones de acciones son correctos [Impuestos] Paso 55
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento Impuestos y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userImpuestos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 8 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo aprueba el DEPARTAMENTO DE INGRESOS BRUTOS Y CONTROL DE OBLIGACIONES FISCALES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 8 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 8 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 8 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 8 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 8 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 8 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 8 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 8 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado


Test 8 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 8 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 8 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 8 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 8 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Ingresos Brutos y Control de Obligaciones Fiscales
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    IngresosBrutosControlObligacionesFiscales
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a IngresosBrutosControlObligacionesFiscales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 8 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 8 - Verificar el estado del tramite (asignado) [IngresosBrutosControlObligacionesFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 8 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 8 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 8 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 8 - Verificar si los botones de acciones son correctos [IngresosBrutosControlObligacionesFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento IngresosBrutosControlObligacionesFiscales y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 8 - Se selecciona la opcion "Aprobar e informar al contribuyente" [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento IngresosBrutosControlObligacionesFiscales y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 8 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 8 - Verificar que el tramite no exista [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 8 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 8 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 8 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado







Test 9 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo rechaza el DEPARTAMENTO DE INGRESOS BRUTOS Y CONTROL DE OBLIGACIONES FISCALES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 9 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 9 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 9 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 9 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 9 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 9 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 9 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 9 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 9 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 9 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 9 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 9 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 9 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Ingresos Brutos y Control de Obligaciones Fiscales
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    IngresosBrutosControlObligacionesFiscales
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a IngresosBrutosControlObligacionesFiscales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 9 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 9 - Verificar el estado del tramite (asignado) [IngresosBrutosControlObligacionesFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 9 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 9 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 9 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 9 - Verificar si los botones de acciones son correctos [IngresosBrutosControlObligacionesFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento IngresosBrutosControlObligacionesFiscales y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 9 - Se selecciona la opcion "Rechazar e informar al contribuyente" [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento IngresosBrutosControlObligacionesFiscales y utiliza la opcion "botonRechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 9 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 9 - Verificar que el tramite no exista [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 9 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 9 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [IngresosBrutosControlObligacionesFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 9 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado



Test 10 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y el DEPARTAMENTO DE INGRESOS BRUTOS Y CONTROL DE OBLIGACIONES FISCALES solicita datos adicionales
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 10 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 10 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 10 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 10 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 10 - Verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 10 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 10 - Verificar que el tramite no exista [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 10 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 10 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 10 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 10 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 10 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 10 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Ingresos Brutos y Control de Obligaciones Fiscales
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    IngresosBrutosControlObligacionesFiscales
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a IngresosBrutosControlObligacionesFiscales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 10 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 10 - Verificar el estado del tramite (asignado) [IngresosBrutosControlObligacionesFiscales] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento IngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 10 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 10 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 10 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 5 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 10 - Verificar si los botones de acciones son correctos [IngresosBrutosControlObligacionesFiscales] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento IngresosBrutosControlObligacionesFiscales y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


#Solicito datos **************************************************************************
Test 10 - Se selecciona la opcion "Solicitar datos adicionales" [IngresosBrutosControlObligacionesFiscales] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como departamento userIngresosBrutosControlObligacionesFiscales para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Verificacion del estado del tramite (pendiente contribuyente) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 10 - Verificar que el tramite no exista [IngresosBrutosControlObligacionesFiscales] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userIngresosBrutosControlObligacionesFiscales, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 10 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Pendiente Contribuyente) [operador mesa] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente Contribuyente



Test 10 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 6 7
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 10 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 8
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 10 - El usuario avanza con el tramite [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    Choose FILE    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Verificacion del estado del tramite (En curso) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 10 - Verificar que el tramite exista [IngresosBrutosControlObligacionesFiscales] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userIngresosBrutosControlObligacionesFiscales, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 10 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 6 9
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 10 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 10
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 10 - Verificar si los botones de acciones son correctos [IngresosBrutosControlObligacionesFiscales] Paso 55
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento IngresosBrutosControlObligacionesFiscales y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userIngresosBrutosControlObligacionesFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


Test 11 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo aprueba el DEPARTAMENTO DE PROCESAMIENTO Y CONTROL DE RENDICIONES DE AGENTES RECAUDADORES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 11 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 11 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 11 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 11 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 11 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 11 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 11 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 11 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado


Test 11 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 11 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 11 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 11 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 11 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Procesamiento y Control de Rendiciones de Agentes Recaudadores
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    ProcesamientoControlRendicionesAgentesRecaudadores
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a ProcesamientoControlRendicionesAgentesRecaudadores    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 11 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 11 - Verificar el estado del tramite (asignado) [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 11 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 11 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 11 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 11 - Verificar si los botones de acciones son correctos [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 11 - Se selecciona la opcion "Aprobar e informar al contribuyente" [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 11 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 11 - Verificar que el tramite no exista [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 11 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 11 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 11 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado







Test 12 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo rechaza el DEPARTAMENTO DE PROCESAMIENTO Y CONTROL DE RENDICIONES DE AGENTES RECAUDADORES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 12 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 12 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 12 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 12 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 12 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 12 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 12 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 12 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 12 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 12 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 12 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 12 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 12 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Procesamiento y Control de Rendiciones de Agentes Recaudadores
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    ProcesamientoControlRendicionesAgentesRecaudadores
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a ProcesamientoControlRendicionesAgentesRecaudadores    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 12 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 12 - Verificar el estado del tramite (asignado) [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 12 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 12 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 12 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 12 - Verificar si los botones de acciones son correctos [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 12 - Se selecciona la opcion "Rechazar e informar al contribuyente" [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y utiliza la opcion "botonRechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 12 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 12 - Verificar que el tramite no exista [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 12 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 12 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 12 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado



Test 13 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y el DEPARTAMENTO DE PROCESAMIENTO Y CONTROL DE RENDICIONES DE AGENTES RECAUDADORES solicita datos adicionales
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 13 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 13 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 13 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 13 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 13 - Verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 13 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 13 - Verificar que el tramite no exista [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 13 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 13 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 13 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 13 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 13 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


Test 13 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Procesamiento y Control de Rendiciones de Agentes Recaudadores
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    ProcesamientoControlRendicionesAgentesRecaudadores
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a ProcesamientoControlRendicionesAgentesRecaudadores    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 13 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 13 - Verificar el estado del tramite (asignado) [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento ProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 13 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 13 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 13 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 5 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 13 - Verificar si los botones de acciones son correctos [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


#Solicito datos **************************************************************************
Test 13 - Se selecciona la opcion "Solicitar datos adicionales" [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como departamento userProcesamientoControlRendicionesAgentesRecaudadores para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Verificacion del estado del tramite (pendiente contribuyente) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 13 - Verificar que el tramite no exista [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userProcesamientoControlRendicionesAgentesRecaudadores, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 13 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Pendiente Contribuyente) [operador mesa] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente Contribuyente



Test 13 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 6 7
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 13 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 8
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 13 - El usuario avanza con el tramite [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    Choose FILE    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Verificacion del estado del tramite (En curso) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 13 - Verificar que el tramite exista [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userProcesamientoControlRendicionesAgentesRecaudadores, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}   ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 13 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 6 9
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 13 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 10
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 13 - Verificar si los botones de acciones son correctos [ProcesamientoControlRendicionesAgentesRecaudadores] Paso 55
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento ProcesamientoControlRendicionesAgentesRecaudadores y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userProcesamientoControlRendicionesAgentesRecaudadores}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 14 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo aprueba el DEPARTAMENTO DE SUPERVISION Y AUDITORIA DE DELEGACIONES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 14 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 14 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 14 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 14 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 14 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 14 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 14 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 14 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado


Test 14 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 14 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 14 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 14 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 14 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Supervisión y Auditoría de Delegaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    SupervisiónAuditoríaDelegaciones
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a SupervisiónAuditoríaDelegaciones    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 14 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 14 - Verificar el estado del tramite (asignado) [SupervisiónAuditoríaDelegaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 14 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 14 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 14 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 14 - Verificar si los botones de acciones son correctos [SupervisiónAuditoríaDelegaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento SupervisiónAuditoríaDelegaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 14 - Se selecciona la opcion "Aprobar e informar al contribuyente" [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento SupervisiónAuditoríaDelegaciones y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 14 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 14 - Verificar que el tramite no exista [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 14 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 14 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 14 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado







Test 15 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y lo rechaza el DEPARTAMENTO DE SUPERVISION Y AUDITORIA DE DELEGACIONES
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 15 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 15 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 15 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 15 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 15 - Verificar si los botones de acciones son correctos [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 15 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 15 - Verificar que el tramite no exista [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 15 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 15 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 15 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 15 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 15 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 15 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Supervisión y Auditoría de Delegaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    SupervisiónAuditoríaDelegaciones
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a SupervisiónAuditoríaDelegaciones    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 15 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 15 - Verificar el estado del tramite (asignado) [SupervisiónAuditoríaDelegaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 15 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 15 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 15 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 15 - Verificar si los botones de acciones son correctos [SupervisiónAuditoríaDelegaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento SupervisiónAuditoríaDelegaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

#APRUEBO----------------------------------------
Test 15 - Se selecciona la opcion "Rechazar e informar al contribuyente" [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento SupervisiónAuditoríaDelegaciones y utiliza la opcion "botonRechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Verificar el Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

Test 15 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 15 - Verificar que el tramite no exista [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 15 - Verificar que el tramite no exista [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 15 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [SupervisiónAuditoríaDelegaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 15 - Verificar el estado y la existencia del tramite en "Tramites Finalizados" [Dirección de Recaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta , ademas, se verifica que el tramite se encuentre en la seccion Tramites Finalizados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado


Test 16 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Indicacion del numero de proceso creado Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    [Documentation]    Numero del proceso creado: ${tramite} - Se crea un tramite de la DIRECCION DE RECAUDACIONES y el DEPARTAMENTO DE SUPERVISION Y AUDITORIA DE DELEGACIONES solicita datos adicionales
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 16 - Verificacion del estado del tramite (pendiente) [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 16 - Verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 16 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 1
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 16 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 1 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 16 - Verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 16 - Se selecciona la opcion "Enviar a direccion" [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Recaudaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Recaudaciones
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 16 - Verificar que el tramite no exista [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 16 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 16 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 16 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 3
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 16 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 3 4
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 16 - Verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Dirección de Recaudaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonDerivar}  boton derivar
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente

Test 16 - Se selecciona la opcion "Derivar" [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Dirección de Recaudaciones y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Supervisión y Auditoría de Delegaciones
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    SupervisiónAuditoríaDelegaciones
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a SupervisiónAuditoríaDelegaciones    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Verificacion del estado del tramite (en curso) [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 16 - Verificar el estado del tramite (asignado) [Dirección de Recaudaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde la Dirección de Recaudaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 16 - Verificar el estado del tramite (asignado) [SupervisiónAuditoríaDelegaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 16 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que el tramite se encuentre en la seccion Consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 16 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 5
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 16 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 5 6
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 16 - Verificar si los botones de acciones son correctos [SupervisiónAuditoríaDelegaciones] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento SupervisiónAuditoríaDelegaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente


#Solicito datos **************************************************************************
Test 16 - Se selecciona la opcion "Solicitar datos adicionales" [SupervisiónAuditoríaDelegaciones] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como departamento userSupervisiónAuditoríaDelegaciones para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Verificacion del estado del tramite (pendiente contribuyente) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 16 - Verificar que el tramite no exista [SupervisiónAuditoríaDelegaciones] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento userSupervisiónAuditoríaDelegaciones, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 16 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Pendiente Contribuyente) [operador mesa] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente Contribuyente



Test 16 - Verificar si el boton del tacho esta desbloqueado - boton cancelar tramite [ciudadano] Paso 6 7
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Enabled    //tbody/tr[td[1]="${tramite}"]

Test 16 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 8
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Contains Element    ${botonCancelartramite}

Test 16 - El usuario avanza con el tramite [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    Choose FILE    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Verificacion del estado del tramite (En curso) [ciudadano] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 16 - Verificar que el tramite exista [SupervisiónAuditoríaDelegaciones] Paso 6
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde departamento SupervisiónAuditoríaDelegaciones, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado



Test 16 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 6 9
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 16 - Verificar si el boton cancelar tramite existe - boton cancelar tramite [ciudadano] Paso 6 10
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un Test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    #Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    #Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

Test 16 - Verificar si los botones de acciones son correctos [SupervisiónAuditoríaDelegaciones] Paso 55
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Departamento SupervisiónAuditoríaDelegaciones y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userSupervisiónAuditoríaDelegaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
