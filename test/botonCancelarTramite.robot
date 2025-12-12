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

*** Variables ***
${tramite1}    TRAM-0421/2025
${tramite2}    TRAM-0422/2025
${tachoComprobanteINCIO}    //button[@aria-controls='radix-_r_k_']
${botonSiCancelarINCIO}    //button[normalize-space()='Sí, cancelar']
${botonVolverINCIO}    //button[normalize-space()='Volver']
${botonCancelartramite}    //button[normalize-space()='Cancelar Trámite']
${botonTachoINICIO}    //button[last()]
${botonVerDetalleINICIO}    //a[normalize-space(text())='Ver Detalle']

*** Test Cases ***
#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test X - Nota formal: cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    #Si fallo lo anterior
    #Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Validar y hacer clic en el boton    ${botonCancelartramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Wait Until Page Contains    La solicitud ha sido cancelada    timeout=10s

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test X - Nota formal: verificar si el boton del tacho esta bloqueado [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite1}"]${botonTachoINICIO}

Test X - Nota formal: verificar si el boton cancelar tramite no existe [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

#///////Ver el estado
Test X - Nota formal: verificar el estado del tramite (pendiente) [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite1}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test X - Nota formal: verificar el estado del tramite (pendiente) [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite1}    Cancelado

Test X - Nota formal: verificar que el tramite no exista [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

Test X - Nota formal: verificar que el tramite no exista [secretaria]
    [Documentation]    Desde secretaria, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

Test X - Nota formal: verificar que el tramite no exista [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite1}

#///////Ver que el personal no pueda realizar ninguna accion
Test X - Nota formal: verificar que el personal no pueda realizar acciones [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite1}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'No hay acciones disponibles')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test X - Nota formal: verificar Historial [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite1}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite1 se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test X - Nota formal: verificar Historial [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite1}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite1 se asigne a la "Mesa de Entrada Virtual"

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test X - Nota formal: cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    #Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite2}
    Validar y hacer clic en el boton    ${botonSiCancelarINCIO}    boton si,cancelar
    Wait Until Page Contains    La solicitud ha sido cancelada.    timeout=10s

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test X - Nota formal: verificar si el boton del tacho esta bloqueado [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite2}"]${botonTachoINICIO}

Test X - Nota formal: verificar si el boton cancelar tramite no existe [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite2}
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}

#///////Ver el estado
Test X - Nota formal: verificar el estado del tramite (pendiente) [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite2}    Cancelado

#En este caso, solo deberia estar en operador mesa
Test X - Nota formal: verificar el estado del tramite (pendiente) [operador]
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite2}    Cancelado

Test X - Nota formal: verificar que el tramite no exista [responsable area]
    [Documentation]    Desde el resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userRespArea}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite2}

Test X - Nota formal: verificar que el tramite no exista [secretaria]
    [Documentation]    Desde secretaria, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite2}

Test X - Nota formal: verificar que el tramite no exista [gestion]
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar tramite Inexistente    ${tablaOperador}    ${tramite2}

#///////Ver que el personal no pueda realizar ninguna accion
Test X - Nota formal: verificar que el personal no pueda realizar acciones [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite2}

    Wait Until Element Is Visible    xpath=//p[contains(text(),'No hay acciones disponibles')]    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

Test X - Nota formal: verificar Historial [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite2}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test X - Nota formal: verificar Historial [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Wait Until Page Contains    Reportes y Estadísticas    timeout=10s
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir tramite Por Numero    ${tramite2}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite cancelado exitosamente"']    En el Historial no se encontro visible que el tramite1 se asigne a la "Mesa de Entrada Virtual"
