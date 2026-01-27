*** Settings ***
Documentation     Se realizan testeos creando tramites verificando si el flujo, los estados, los botones funciona de manera correcta.
...
...               Se realizaron las siguientes pruebas:
...
...               -Test 1: Se crea un tramite del Despacho Subdireccion General y lo aprueba el mismo Despacho Subdireccion General
...
...               -Test 2: Se crea un tramite del Despacho Subdireccion General y lo rechaza el mismo Despacho Subdireccion General
...
...               -Test 3: Se crea un tramite del Despacho Subdireccion General y desde el mismo Despacho Subdireccion General selecciona la opcion "No Corresponde"
...
...               -Test 4: Se crea un tramite del Despacho Subdireccion General y desde el mismo Despacho Subdireccion General la opcion "Solicitar Datos Adicionales"
...

Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/EmbedScreenshotLibrary.py
Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/InternetOculto.py

Resource        C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/KeywordsPortal.robot
Resource        C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/KeywordsMio.robot
Resource        C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/VariablesPortal.robot

#Test Setup     Abrir Navegador en modo incognito
Test Teardown  Cerrar Navegador

Suite Setup    Inicializar Contador

*** Variables ***
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
${docLean}    ADJUNTO.pdf
#${docLean}    ubicacion.png


***Test Cases***
#Test 6: Aprobado desde Despacho Subdirección General
#Test 7: Rechazado desde Despacho Subdirección General
#3:no corresponde desde dire
#4:solicita datos desde dire



Test 1 - Aprobado desde Despacho Subdirección General [ciudadano] Paso 1
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

Test 1 - Aprobado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 1 - Aprobado desde Despacho Subdirección General verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 1 - Aprobado desde Despacho Subdirección General [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Subdirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Subdirección General
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

Test 1 - Verificar el estado del tramite (asignado) [DespachoSubdireccionGeneral] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el Despacho Subdireccion General, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 1 - Aprobado desde Despacho Subdirección General verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Cerrar Navegador

Test 1 - Aprobado desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Aprobado desde Despacho Subdirección General verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 1 - Aprobado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 2 - Rechazado desde Despacho Subdirección General [ciudadano] Paso 1
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

Test 2 - Rechazado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Rechazado desde Despacho Subdirección General verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Rechazado desde Despacho Subdirección General [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Subdirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Subdirección General
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

Test 2 - Verificar el estado del tramite (asignado) [DespachoSubdireccionGeneral] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el Despacho Subdireccion General, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 2 - Rechazado desde Despacho Subdirección General verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  botonDerivar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar Boton Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Cerrar Navegador

Test 2 - Rechazado desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Rechazado desde Despacho Subdirección General verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 2 - Rechazado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador



Test 3 - No Corresponde desde Despacho Subdirección General [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crea un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 3 - verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 3 - No Corresponde desde Despacho Subdirección General [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Subdirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Subdirección General
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
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

Test 3 - Verificar el estado del tramite (asignado) [DespachoSubdireccionGeneral] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el Despacho Subdireccion General, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 3 - No Corresponde desde Despacho Subdirección General verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 3 - No Corresponde desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonAprobar
    Validar y completar campo    ${campoComentario}    NoCorresponde    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Despacho Subdirección General verificar si los botones de acciones son correctos [operador mesa] Paso 13
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

Test 3 - No Corresponde desde Despacho Subdirección General [operador mesa] Paso 14
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Subdirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Subdirección General
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 15
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - No Corresponde desde Despacho Subdirección General verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 16
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 3 - No Corresponde desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 17
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado



Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General [ciudadano] Paso 1
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

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General verificar el estado del tramite (pendiente) [operador mesa] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Subdirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Subdirección General
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
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

Test 4 - Verificar el estado del tramite (asignado) [DespachoSubdireccionGeneral] Paso 9
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el Despacho Subdireccion General, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 11
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 12
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    solicito datos adicionales    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 13
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General el ciudadano avanza en el tramite [ciudadano] Paso 14
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 15
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 16
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado

Test 4 - SolicitarDatosAdicionales desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 17
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado

