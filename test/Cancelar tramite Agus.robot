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

Test Setup    Abrir Navegador en modo incognito
Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

#IMPORTANTE **************************************************************************************************
#Leandro: ${FILE}
#Agustina: ${FILEAgus}
#************************************************************************************************************

#Agregar acciones que no van
#Ver que no funciona seleccionar la flecha
***Test Cases***
#-Se realiza el siguiente flujo para los tramites:
    #Excencion impuesto provinical automotor
    #Exencion impuesto de sellos
    #Nota formal
    #Exencion impuesto sobre los ingresos brutos
#Test 1: crear tramite [ciudadano] - SI se puede cancelar el tramite
#Test 2: solicitar datos adicionales [operador mesa]  - SI se puede cancelar el tramite
#Test 3: enviar a Direccion [operador mesa]  - NO se puede cancelar el tramite
#Test 4: no corresponde [Direccion]  - NO se puede cancelar el tramite
#Test 5: no corresponde [operador mesa]  - NO se puede cancelar el tramite
#Test 6: para resolver [Direccion]  - NO se puede cancelar el tramite
#Test 7: aprobar [gestion]  - NO se puede cancelar el tramite
#Test 8: informar al contribuyente [operador mesa]  - NO se puede cancelar el tramite
#Test 9: rechazar [gestion]  - NO se puede cancelar el tramite
#Test 10: aprobar [Direccion]  - NO se puede cancelar el tramite
#Test 11: rechazar [Direccion]  - NO se puede cancelar el tramite

#************************************************************************************************************************************
#************************************************************************************************************************************
#*******************************TRAMITE: EXCENCION IMPUESTO PROVINCIAL AUTOMOTOR ***********************************************************************************************************
#************************************************************************************************************************************
#************************************************************************************************************************************


#------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------CREACION DE TRAMITE----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 1 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
Test 1 / A - Excencion impuesto provincial automotor: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / A - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / A - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - boton cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / A - Excencion impuesto provincial automotor: verificar que el personal no pueda realizar acciones - boton cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / A - Excencion impuesto provincial automotor: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / A - Excencion impuesto provincial automotor: verificar Historial - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 1 /B - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 1 / B - Excencion impuesto provincial automotor: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / B - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / B - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / B - Excencion impuesto provincial automotor: verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / B - Excencion impuesto provincial automotor: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / B - Excencion impuesto provincial automotor: verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------- SOLICITAR DATOS ADICIONALES ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 2 / A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / A - Excencion impuesto provincial automotor: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / A - Excencion impuesto provincial automotor: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / A - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Excencion impuesto provincial automotor: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Excencion impuesto provincial automotor: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 2 / B - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / B - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / B - Excencion impuesto provincial automotor: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / B - Excencion impuesto provincial automotor: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / B - Excencion impuesto provincial automotor: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Excencion impuesto provincial automotor: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Excencion impuesto provincial automotor: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- ENVIAR A Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 3 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 / A - Excencion impuesto provincial automotor: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- Direccion / NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 4 / A- Excencion impuesto provincial automotor: se selecciona la opcion "no corresponde" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 5 / A - Excencion impuesto provincial automotor: se selecciona la opcion "no corresponde" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- PARA RESOLVER ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 6 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 / A - Excencion impuesto provincial automotor: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 / A- Excencion impuesto provincial automotor: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / APROBAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 7 /A- Excencion impuesto provincial automotor: se selecciona la opcion "aprobado" [gestion]
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- OPERADOR MESA / INFORMAR AL CONTRIBUYENTE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 8 /A - Excencion impuesto provincial automotor: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / RECHAZAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 9 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 9 /A - Excencion impuesto provincial automotor: se selecciona la opcion "enviar a Direccion". [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Excencion impuesto provincial automotor: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 / A - Excencion impuesto provincial automotor: se selecciona la opcion "rechazar" [gestion]
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- APROBAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 10 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 10 / A - Excencion impuesto provincial automotor: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A- Excencion impuesto provincial automotor: se selecciona la opcion "aprobado" [Direccion]
    [Documentation]    Entra como Direccion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- RECHAZAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 11 /A - Excencion impuesto provincial automotor: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A - Excencion impuesto provincial automotor: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 11 / A - Excencion impuesto provincial automotor: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A- Excencion impuesto provincial automotor: se selecciona la opcion "rechazar" [Direccion]
    [Documentation]    Entra como Direccion rechazando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / A - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / A - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / B - Excencion impuesto provincial automotor: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / B - Excencion impuesto provincial automotor: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}


#************************************************************************************************************************************
#************************************************************************************************************************************
#*******************************TRAMITE: EXCENCION IMPUESTO DE SELLOS ***********************************************************************************************************
#************************************************************************************************************************************
#************************************************************************************************************************************

#------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------CREACION DE TRAMITE----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 1 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
Test 1 / A - Exencion impuesto de sellos: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / A - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / A - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - boton cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / A - Exencion impuesto de sellos: verificar que el personal no pueda realizar acciones - boton cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / A - Exencion impuesto de sellos: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / A - Exencion impuesto de sellos: verificar Historial - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 1 /B - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 1 / B - Exencion impuesto de sellos: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / B - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / B - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / B - Exencion impuesto de sellos: verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / B - Exencion impuesto de sellos: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / B - Exencion impuesto de sellos: verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------- SOLICITAR DATOS ADICIONALES ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 2 / A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / A - Exencion impuesto de sellos: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / A - Exencion impuesto de sellos: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / A - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto de sellos: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto de sellos: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 2 / B - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / B - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / B - Exencion impuesto de sellos: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / B - Exencion impuesto de sellos: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / B - Exencion impuesto de sellos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto de sellos: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto de sellos: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- ENVIAR A Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 3 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 / A - Exencion impuesto de sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- Direccion / NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 4 / A- Exencion impuesto de sellos: se selecciona la opcion "no corresponde" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 5 / A - Exencion impuesto de sellos: se selecciona la opcion "no corresponde" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- PARA RESOLVER ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 6 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 / A - Exencion impuesto de sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 / A- Exencion impuesto de sellos: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / APROBAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 7 /A- Exencion impuesto de sellos: se selecciona la opcion "aprobado" [gestion]
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- OPERADOR MESA / INFORMAR AL CONTRIBUYENTE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 8 /A - Exencion impuesto de sellos: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / RECHAZAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 9 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 9 /A - Exencion impuesto de sellos: se selecciona la opcion "enviar a Direccion". [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Exencion impuesto de sellos: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 / A - Exencion impuesto de sellos: se selecciona la opcion "rechazar" [gestion]
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- APROBAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 10 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 10 / A - Exencion impuesto de sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A- Exencion impuesto de sellos: se selecciona la opcion "aprobado" [Direccion]
    [Documentation]    Entra como Direccion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- RECHAZAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 11 /A - Exencion impuesto de sellos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto de sellos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExenciónImpuestoDeSellos}    ${asuntoExenciónImpuestoDeSellos}    ${detalleExenciónImpuestoDeSellos}    ${contenidoExenciónImpuestoDeSellos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A - Exencion impuesto de sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 11 / A - Exencion impuesto de sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A- Exencion impuesto de sellos: se selecciona la opcion "rechazar" [Direccion]
    [Documentation]    Entra como Direccion rechazando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / A - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / A - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / B - Exencion impuesto de sellos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / B - Exencion impuesto de sellos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}


#************************************************************************************************************************************
#************************************************************************************************************************************
#************************************************TRAMITE: NOTA FORMAL ***********************************************************************************************************
#************************************************************************************************************************************
#************************************************************************************************************************************

#------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------CREACION DE TRAMITE----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 1 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
Test 1 / A - Nota formal: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / A - Nota formal: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / A - Nota formal: verificar el estado del tramite (cancelado) - boton cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / A - Nota formal: verificar que el personal no pueda realizar acciones - boton cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / A - Nota formal: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / A - Nota formal: verificar Historial - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 1 /B - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 1 / B - Nota formal: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / B - Nota formal: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / B - Nota formal: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / B - Nota formal: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / B - Nota formal: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / B - Nota formal: verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / B - Nota formal: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / B - Nota formal: verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------- SOLICITAR DATOS ADICIONALES ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 2 / A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / A - Nota formal: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / A - Nota formal: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / A - Nota formal: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Nota formal: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Nota formal: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 2 / B - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / B - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / B - Nota formal: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / B - Nota formal: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / B - Nota formal: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / B - Nota formal: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / B - Nota formal: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Nota formal: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Nota formal: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- ENVIAR A Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 3 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 / A - Nota formal: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- Direccion / NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 4 / A- Nota formal: se selecciona la opcion "no corresponde" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 5 / A - Nota formal: se selecciona la opcion "no corresponde" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- PARA RESOLVER ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 6 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 / A - Nota formal: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 / A- Nota formal: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / APROBAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 7 /A- Nota formal: se selecciona la opcion "aprobado" [gestion]
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- OPERADOR MESA / INFORMAR AL CONTRIBUYENTE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 8 /A - Nota formal: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / RECHAZAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 9 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 9 /A - Nota formal: se selecciona la opcion "enviar a Direccion". [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Nota formal: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 / A - Nota formal: se selecciona la opcion "rechazar" [gestion]
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- APROBAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 10 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 10 / A - Nota formal: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A- Nota formal: se selecciona la opcion "aprobado" [Direccion]
    [Documentation]    Entra como Direccion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- RECHAZAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 11 /A - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonNotaFormal}    ${asuntoNotaFormal}    ${detalleNotaFormal}    ${contenidoNotaFormal}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A - Nota formal: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 11 / A - Nota formal: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A- Nota formal: se selecciona la opcion "rechazar" [Direccion]
    [Documentation]    Entra como Direccion rechazando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / A - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / A - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / B - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / B - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}



#************************************************************************************************************************************
#************************************************************************************************************************************
#*****************************************TRAMITE: EXENCION IMPUESTO SOBRE LOS INGRESOS BRUTOS ***********************************************************************************************************
#************************************************************************************************************************************
#************************************************************************************************************************************

#------------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------CREACION DE TRAMITE----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 1 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
Test 1 / A - Exencion impuesto sobre los ingresos brutos: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - boton cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar que el personal no pueda realizar acciones - boton cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / A - Exencion impuesto sobre los ingresos brutos: verificar Historial - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 1 /B - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 1 / B - Exencion impuesto sobre los ingresos brutos: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

#///////Ver que el personal no pueda realizar ninguna accion
Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion

Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 1 / B - Exencion impuesto sobre los ingresos brutos: verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------- SOLICITAR DATOS ADICIONALES ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 2 / A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / A - Exencion impuesto sobre los ingresos brutos: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / A - Exencion impuesto sobre los ingresos brutos: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 2 / B - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 / B - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    execute javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 2 / B - Exencion impuesto sobre los ingresos brutos: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [Direccion]
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar que el tramite no exista - icono tacho de cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 / B - Exencion impuesto sobre los ingresos brutos: verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- ENVIAR A Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 3 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 3 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 3 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- Direccion / NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 4 / A- Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "no corresponde" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 4 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 4 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- NO CORRESPONDE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 5 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "no corresponde" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 5 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 5 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- PARA RESOLVER ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 6 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 / A- Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 6 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 6 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / APROBAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 7 /A- Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "aprobado" [gestion]
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 7 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 7 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- OPERADOR MESA / INFORMAR AL CONTRIBUYENTE  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 8 /A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 8 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 8 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- GESTION / RECHAZAR  ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 9 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 9 /A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "enviar a Direccion". [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 /A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "para resolver" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
   # Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 9 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "rechazar" [gestion]
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 9 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 9 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- APROBAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 10 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 10 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 10 /A- Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "aprobado" [Direccion]
    [Documentation]    Entra como Direccion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 10 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 10 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------- RECHAZAR / Direccion ----------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
Test 11 /A - Exencion impuesto sobre los ingresos brutos: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Exencion impuesto sobre los ingresos brutos
    Asignar Tag Numerado
    Crear tramite para X tipo    ${botonExencionImpuestoSobreLosIngresosBrutos}    ${asuntoExencionImpuestoSobreLosIngresosBrutos}    ${detalleExencionImpuestoSobreLosIngresosBrutos}    ${contenidoImpuestoSobreLosIngresosBrutos}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A - Exencion impuesto sobre los ingresos brutos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 11 / A - Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarDireccion
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 11 /A- Exencion impuesto sobre los ingresos brutos: se selecciona la opcion "rechazar" [Direccion]
    [Documentation]    Entra como Direccion rechazando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / A - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Ver si los botones se bloquearon
Test 11 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Element Should Be Disabled    ${tablaConTramite}${botonTachoINICIO}

Test 11 / B - Exencion impuesto sobre los ingresos brutos: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

*** Keywords ***
Crear tramite para X tipo
    [Arguments]    ${tipoTramite}    ${campoAsunto}    ${campoDetalle}    ${campoContenido}
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${tipoTramite}    ${tipoTramite}
    Validar y completar campo    ${campoAsunto}  Asunto test2    asunto
    Validar y completar campo    ${campoDetalle}  Descripcion test2  detalle
    Validar y completar campo    ${campoContenido}  Contenido test2  contenido
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
