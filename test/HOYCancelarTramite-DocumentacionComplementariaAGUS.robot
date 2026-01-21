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

Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

#IMPORTANTE **************************************************************************************************
#Leandro: ${FILE}
#Agustina: ${FILEAgus}

***Test Cases***
Test 1 - Crea un nuevo tramite [ciudadano]
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite de consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    #Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    #Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Indicacion del numero de proceso creado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

#------------------------------------ SUBIR DOCUMENTACION COMPLEMENTARIA ---------------------------------------------------------

#-------------------------------   SUBIR DOCUMENTACION CON CAMPOS INCOMPLETOS   -----------------------------------
Test 2 - Agregar documentacion complementaria - intentar subir documentacion sin completar los campos [operador mesa]
    [Documentation]    Entra como operador y se verifica que no se pueda crear la documentacion al intentar subir solo archivo o comentaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Element Should Be Disabled    ${botonSubirDocumento}
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar

    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar

#----------------------   NO SE SUBE LA DOCUMENTACION PORQUE SE PRESIONA EL BOTON CANCELAR   -----------------------
Test 2 - Agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [operador mesa]
    [Documentation]    Entra como operador y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${botonCancelar}   boton subir documento
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Element Attribute Value Should Be    ${campoDescripcion}    value    ${EMPTY}
    Verificar NO presencia de... con...    //div[@class='p-3 border rounded-lg bg-muted/50']    ${docAgus}

#------------------------- SE SUBE Y ELIMINA (ADEMÁS DEL CANCELAR) UNA DOC. COMPLEMENTARIA ---------------------
#--------------------------  SE PRUEBA LA SUBIDA DE DIFERENTES TIPOS DE ARCHIVOS ---------------------------------
#////////Doc
#Subir y borrar un archivo
Test 2 - Se agrega documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Agregar documentacion complementaria    ${FILEdocAgus}  doc
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Se elimina la documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar, luego se elimina
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${EliminarDocumento}   boton eliminar documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha eliminado correctamente.
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

#--------------------------------------------------------------------------------------------------------
#////////Excel
Test 2 - Se agrega documentacion complementaria - archivo incorrecto: excel [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria de un archivo que no seria valido
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    No Agregar documentacion complementaria    ${FILEexcAgus}  excel
    #Condicion para los proximos test
    #[Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Verificacion de documentacion complementaria - archivo: excel [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${excAgus}

#------------------------------------------------------------------------------------------------------
#////////Png
Test 2 - Se agrega documentacion complementaria - archivo: png [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Agregar documentacion complementaria    ${FILEpngAgus}  png
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Verificacion de documentacion complementaria - archivo: png [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pngAgus}

#-----------------------------------------------------------------------------------------------
#////////Jpeg
Test 2 - Se agrega documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Agregar documentacion complementaria    ${FILEjpegAgus}  jpeg
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Verificacion de documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${jpegAgus}

#--------------------------------------------------------------------------------------------------------
#////////Pdf
Test 2 - Se agrega documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Agregar documentacion complementaria    ${FILEpdfAgus}  pdf
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#cambiar porque no funciona
Test 2 - Verificacion de documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pdfAgus}

#-------------------------------------------------- BOTON CANCELAR TRAMITE ------------------------------------------
Test 3 - Cancelar tramite desde adentro del tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el boton "cancelar tramite"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonCancelarTramite}    boton cancelar tramite
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 3 - Verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 3 - Verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 3 - Verificar el estado del tramite (cancelado) - boton cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 3 - Verificar que el tramite no exista [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

#///////Ver que el personal no pueda realizar ninguna accion
Test 3 - Verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 3 - Verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 3 - Verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Test 4 - Crear otro tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Excencion impuesto provincial automotor
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Crear tramite para X tipo    ${botonExencionImpuestoProvincialAutomotor}    ${asuntoExencionImpuestoProvincialAutomotor}    ${detalleExencionImpuestoProvincialAutomotor}    ${contenidoExencionImpuestoProvincialAutomotor}    ${pdfAgus}
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-----------------------------------------------ICONO TACHO DE CANCELAR TRAMITE ------------------------------------------
#///////Cancelar tramite
Test 5 - Cancelar tramite desde el tacho [ciudadano]
    [Documentation]    Desde el ciudadano, se cancela el tramite presionando el icono del tacho del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMisTramitesRecientes}    ${botonTachoINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonSiCancelar}    boton si,cancelar
    Verificar Y Esperar Visibilidad De Elemento    La solicitud ha sido cancelada.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#///////Ver si los botones se bloquearon
Test 5 - Verificar si el boton del tacho esta bloqueado - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]${botonTachoINICIO}

Test 5 - Verificar si el boton cancelar tramite no existe - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Wait Until Page Does Not Contain Element    ${botonCancelarTramite}

#///////Ver el estado
Test 5 - Verificar el estado del tramite (cancelado) - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMistramitesRecientes}    3    ${tramite}    Cancelado

Test 3 - Verificar que el tramite no exista [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Verificar el estado y la existencia del tramite en "Consulta de tramites" (Asignado) [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta, ademas, se verifica que aparezca en la seccion de consulta de tramites
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonConsultaDeTramites
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cancelado

#///////Ver que el personal no pueda realizar ninguna accion
Test 5 - Verificar que el personal no pueda realizar acciones - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Se ingresa como operador mesa y se verifica que no aparezcan los botones de acciones para realizar sobre el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${textoNoHayAccionesDisponibles}

    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAsignar}  botonAsignar
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${botonDerivar}  boton derivar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  botonRechazarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  botonAprobarInformarAlContribuyente
    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde

Test 5 - Verificar Historial - icono tacho de cancelar tramite [ciudadano]
    [Documentation]    Desde el ciudadano, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
     Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${historialCiudadano}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

#porque desde aca se ve
Test 5 - Verificar Historial - icono tacho de cancelar tramite [operador mesa]
    [Documentation]    Desde el operador mesa, se verifica que en el historial figure que se cancelo el tramite
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    ${textoTramiteCanceladoExitosamente}    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
