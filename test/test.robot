#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test X - Nota formal: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    #Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Validar y hacer clic en el boton    ${botonCancelartramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test X - Nota formal: verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento    ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite1}"]${botonTachoINICIO}

Test X - Nota formal: verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Verificar Y Esperar Visibilidad De Elemento    ${botonCancelartramite}

#///////Ver el estado
Test X - Nota formal: verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento    ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite1}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test X - Nota formal: verificar el estado del tramite (cancelado) - boton cancelar tramite [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite1}    Cancelado

Test X - Nota formal: verificar que el tramite no exista - boton cancelar tramite [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

Test X - Nota formal: verificar que el tramite no exista - boton cancelar tramite [secretaria]
    [Documentation]    Desde secretaria, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

Test X - Nota formal: verificar que el tramite no exista - boton cancelar tramite [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

#///////Ver que el personal no pueda realizar ninguna accion
Test X - Nota formal: verificar que el personal no pueda realizar acciones - boton cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite1}

    Verificar Y Esperar Visibilidad De Elemento    xpath=//p[contains(text(),'No hay acciones disponibles')]

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test X - Nota formal: verificar Historial - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento    ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite1 se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test X - Nota formal: verificar Historial - boton cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite1}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite1 se asigne a la "Mesa de Entrada Virtual"
