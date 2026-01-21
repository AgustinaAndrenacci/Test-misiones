*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs


Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/TagsLibrary.py
Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/EmbedScreenshotLibrary.py
Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/InternetOculto.py

Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

Test Teardown    Cerrar Navegador

*** Variables ***
${textoEjecutarAccion}    //p[contains(text(), 'Vas a ejecutar la acción')]

${botonConsultaTramites}    //span[normalize-space()='Consulta de Trámites']
${botonTramitesFinalizados}    //span[normalize-space()='Trámites Finalizados']


#*************************ATENCION*********************************************************************
#Agus
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
${docLean}    ADJUNTO.pdf
#Lean
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
#${docLean}    ubicacion.png


#-------------------Nombres de los tramites     - ATENCION, FALTA EL {
#&TRAMITE_ConsultaTributaria}
#&TRAMITE_ConsultaVinculante}
#&TRAMITE_ExencionImpuestoInmobiliarioBasico}
#&TRAMITE_ExenciónImpuestoDeSellos}
#&TRAMITE_ExencionImpuestoProvincialAutomotor}
#&TRAMITE_ExencionImpuestoSobreLosIB}
#&TRAMITE_NotaFormal}

***Test Cases***

#-------INDICACION DE TESTS-------

#Test 1: Crear Tramite como Borrador
#Test 2: Solicitar datos adicionales
#Test 3: No Corresponde
#Test 4: Aprobado desde Despacho Direccion General
#Test 5: Rechazado desde Despacho Direccion General
#Test 6: Aprobado desde Despacho Subdirección General
#Test 7: Rechazado desde Despacho Subdirección General
#Test 8: Aprobado desde Direccion Administracion
#Test 9: Rechazado desde Direccion Administracion
#Test 10: Aprobado desde Direccion Auditoria y Planificacion
#Test 11: Rechazado desde Direccion Auditoria y Planificacion
#Test 12: Aprobado desde Direccion de Coordinacion de Politicas Fiscales
#Test 13: Rechazado desde Direccion de Coordinacion de Politicas Fiscales
#Test 14: Aprobado desde Direccion de Fiscalizacion
#Test 15: Rechazado desde Direccion de Fiscalizacion
#Test 16: Aprobado desde Direccion de Informatica
#Test 17: Rechazado desde Direccion de Informatica
#Test 18: Aprobado desde Direccion de Recaudaciones
#Test 19: Rechazado desde Direccion de Recaudaciones
#Test 20: Aprobado desde Direccion Juridica y Tecnica
#Test 21: Rechazado desde Direccion Juridica y Tecnica



#EJEMPLO
#Test 22 - Crea un nuevo tramite [ciudadano] Paso 1
#    Abrir Navegador en modo incognito    ${pageCiudadano}
#    [Documentation]    Crear un nuevo tramite
#    Asignar Tag Numerado
#    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
#    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

#    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

#    ${tramite}=    Obtener Numero De Tramite
#    Set Suite Variable    ${tramite}
#    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria Como Borrador [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
#    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite Borrador
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria GuardarBorrador Chequear Estado Desde Usuario [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador
    Cerrar Navegador

Test 1 - Consulta Tributaria: verificar que no aparezca el tramite(borrador) [operador mesa] Paso 1
    Abrir Navegador en modo incognito    ${pagePersonal}
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    [Documentation]    Desde el operador mesa, se verifica que el tramite(borrador) no se visualice
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}
    Cerrar Navegador

Test 1 - Consulta Tributaria Borrador Chequear Campos [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Verifica que el ciudadano pueda ver los campos anteriormente completados
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}  abrirTramiteGenerado
    Sleep  2s
    Verificar Contenido De Campos    ${asuntoConsultaTributaria}  Asunto  Asunto test 1
    Verificar Contenido De Campos    ${detalleConsultaTributaria}  Descripcion  Descripcion test 1
    Verificar Contenido De Campos    ${contenidoConsultaTributaria}  Contenido  Contenido test 1
    Verificar presencia de    ${DNIdelSolicitante}    El DNIdelSolicitante no se encontro visible
    Cerrar Navegador

Test 1 - Consulta Tributaria Borrador Actualizar Campos [ciudadano] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Comprueba que se puedan cambiar los campos en el borrador y actualiza el borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}  abrirTramiteGenerado
    Sleep  2s
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 2    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 2  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 2  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    Copia del instrumento que origina el acto    ${docLean}
    Validar y hacer clic en el boton    ${botonActualizarBorrador}  botonActualizarBorrador
    Cerrar Navegador

Test 1 - Consulta Tributaria Borrador Chequear Campos [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Verifica que el ciudadano pueda ver las actualizaciones del borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}  abrirTramiteGenerado
    Sleep  2s
    Verificar Contenido De Campos    ${asuntoConsultaTributaria}  Asunto  Asunto test 2
    Verificar Contenido De Campos    ${detalleConsultaTributaria}  Descripcion  Descripcion test 2
    Verificar Contenido De Campos    ${contenidoConsultaTributaria}  Contenido  Contenido test 2
    Verificar presencia de    ${DNIdelSolicitante}    El DNIdelSolicitante no se encontro visible
    Verificar presencia de    ${copiaDelInstrumentoQueOriginaElActo}    La Copia Del Instrumento Que Origina El Acto no se encontro visible
    Cerrar Navegador

Test 1 - Consulta Tributaria: pasar de borrador a guardado [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el ciudadano, se entra al tramite y se guarda para que deje de estar en borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    abrirTramiteGenerado
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Consulta Tributaria: verificar el estado del tramite (pendiente) [ciudadano] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 1 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 5
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Consulta Tributaria Solicitar Datos Adicionales [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria sin agregar abjuntos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Sleep  1s
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Tributaria Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Consulta Tributaria: verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  boton rechazar

    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Cerrar Navegador

Test 2 - Consulta Tributaria Solicitar Datos Adicionales [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Tributaria Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente
    Cerrar Navegador

Test 2 - Consulta Tributaria: el ciudadano avanza en el tramite [ciudadano] Paso 3
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
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Consulta Tributaria Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 2 - Consulta Tributaria: verificar si los botones de acciones son correctos [operador mesa] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  boton rechazar

    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Cerrar Navegador

Test 3 - Consulta Tributaria Documentacion NoCorresponde [ciudadano] Paso 1
    [Documentation]    Crear una nueva consulta tributaria sin agregar abjuntos
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Consulta Tributaria Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 3 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 3 - Consulta Tributaria: verificar si los botones de acciones son correctos [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=//p[contains(text(),'Seleccione una acción para continuar con el proces')]

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobarInformarAlContribuyente}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazarInformarAlContribuyente}  boton rechazar

    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarDireccion}  boton enviar a Direccion
    Cerrar Navegador

Test 3 - Consulta Tributaria Documentacion NoCorresponde [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Consulta Tributaria Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló el boton NoCorresponde desde el operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 4 - Consulta Tributaria Aprobado desde Despacho Direccion General [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Tributaria Aprobado desde Despacho Direccion General Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 4 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 4 - Consulta Tributaria Aprobado desde Despacho Direccion General [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Dirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Dirección General
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 4 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 4 - Consulta Tributaria: verificar si los botones de acciones son correctos [DespachoDireccionGeneral] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 4 - Consulta Tributaria Aprobado desde Despacho Direccion General [DespachoDireccionGeneral] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 4 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DespachoDireccionGeneral] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 4 - Consulta Tributaria Aprobado desde Despacho Direccion General Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 5 - Consulta Tributaria Rechazado desde Despacho Direccion General [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Tributaria Rechazado desde Despacho Direccion General Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 5 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 5 - Consulta Tributaria Rechazado desde Despacho Direccion General [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Despacho de Dirección General
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Despacho de Dirección General
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 5 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 5 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 5 - Consulta Tributaria: verificar si los botones de acciones son correctos [DespachoDireccionGeneral] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
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

Test 5 - Consulta Tributaria Rechazado desde Despacho Direccion General [DespachoDireccionGeneral] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 5 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DespachoDireccionGeneral] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoDireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 5 - Consulta Tributaria Rechazado desde Despacho Direccion General Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador

Test 6 - Consulta Tributaria Aprobado desde Despacho Subdirección General [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 6 - Consulta Tributaria Aprobado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 6 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 6 - Consulta Tributaria Aprobado desde Despacho Subdirección General [operador mesa] Paso 2
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

Test 6 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 6 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 6 - Consulta Tributaria: verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 3
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

Test 6 - Consulta Tributaria Aprobado desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 3
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

Test 6 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 6 - Consulta Tributaria Aprobado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 7 - Consulta Tributaria Rechazado desde Despacho Subdirección General [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 7 - Consulta Tributaria Rechazado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 7 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 7 - Consulta Tributaria Rechazado desde Despacho Subdirección General [operador mesa] Paso 2
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

Test 7 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 7 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 7 - Consulta Tributaria: verificar si los botones de acciones son correctos [DespachoSubdireccionGeneral] Paso 3
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

Test 7 - Consulta Tributaria Rechazado desde Despacho Subdirección General [DespachoSubdireccionGeneral] Paso 3
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

Test 7 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DespachoSubdireccionGeneral] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDespachoSubdireccionGeneral}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 7 - Consulta Tributaria Rechazado desde Despacho Subdirección General Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador

Test 8 - Consulta Tributaria Aprobado desde Direccion Administracion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Consulta Tributaria Aprobado desde Direccion Administracion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 8 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 8 - Consulta Tributaria Aprobado desde Direccion Administracion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Administración
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Administración
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 8 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 8 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionAdministracion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
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

Test 8 - Consulta Tributaria Aprobado desde Direccion Administracion [DireccionAdministracion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 8 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionAdministracion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 8 - Consulta Tributaria Aprobado desde Direccion Administracion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 9 - Consulta Tributaria Rechazado desde Direccion Administracion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Consulta Tributaria Rechazado desde Direccion Administracion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 9 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 9 - Consulta Tributaria Rechazado desde Direccion Administracion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Administración
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Administración
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 9 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 9 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionAdministracion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
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


Test 9 - Consulta Tributaria Rechazado desde Direccion Administracion [DireccionAdministracion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 9 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionAdministracion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAdministracion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 9 - Consulta Tributaria Rechazado desde Direccion Administracion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 10 - Consulta Tributaria Aprobado desde Direccion Auditoria y Planificacion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Consulta Tributaria Aprobado desde Direccion Auditoria y Planificacion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 10 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 10 - Consulta Tributaria Aprobado desde Direccion Auditoria y Planificacion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Auditoría y Planificación
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Auditoría y Planificación
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 10 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 10 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionAuditoriaPlanificacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
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


Test 10 - Consulta Tributaria Aprobado desde Direccion Auditoria y Planificacion [DireccionAuditoriaPlanificacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 10 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionAuditoriaPlanificacion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 10 - Consulta Tributaria Aprobado desde Direccion Auditoria y Planificacion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 11 - Consulta Tributaria Rechazado desde Direccion Auditoria y Planificacion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Consulta Tributaria Rechazado desde Direccion Auditoria y Planificacion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 11 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 11 - Consulta Tributaria Rechazado desde Direccion Auditoria y Planificacion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Auditoría y Planificación
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Auditoría y Planificación
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 11 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 11 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionAuditoriaPlanificacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
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


Test 11 - Consulta Tributaria Rechazado desde Direccion Auditoria y Planificacion [DireccionAuditoriaPlanificacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 11 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionAuditoriaPlanificacion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionAuditoriaPlanificacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 11 - Consulta Tributaria Rechazado desde Direccion Auditoria y Planificacion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 12 - Consulta Tributaria Aprobado desde Direccion de Coordinacion de Politicas Fiscales [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Consulta Tributaria Aprobado desde Direccion de Coordinacion de Politicas Fiscales Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 12 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 12 - Consulta Tributaria Aprobado desde Direccion de Coordinacion de Politicas Fiscales [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Coordinación de Políticas Fiscales
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Coordinación de Políticas Fiscales
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 12 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 12 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionCoordinacionPoliticasFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
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


Test 12 - Consulta Tributaria Aprobado desde Direccion de Coordinacion de Politicas Fiscales [DireccionCoordinacionPoliticasFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 12 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionCoordinacionPoliticasFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 12 - Consulta Tributaria Aprobado desde Direccion de Coordinacion de Politicas Fiscales Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 13 - Consulta Tributaria Rechazado desde Direccion de Coordinacion de Politicas Fiscales [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Consulta Tributaria Rechazado desde Direccion de Coordinacion de Politicas Fiscales Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 13 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 13 - Consulta Tributaria Rechazado desde Direccion de Coordinacion de Politicas Fiscales [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Coordinación de Políticas Fiscales
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Coordinación de Políticas Fiscales
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 13 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 13 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionCoordinacionPoliticasFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
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

Test 13 - Consulta Tributaria Rechazado desde Direccion de Coordinacion de Politicas Fiscales [DireccionCoordinacionPoliticasFiscales] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 13 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionCoordinacionPoliticasFiscales] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionCoordinacionPoliticasFiscales}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 13 - Consulta Tributaria Rechazado desde Direccion de Coordinacion de Politicas Fiscales Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 14 - Consulta Tributaria Aprobado desde Direccion de Fiscalizacion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Consulta Tributaria Aprobado desde Direccion de Fiscalizacion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 14 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 14 - Consulta Tributaria Aprobado desde Direccion de Fiscalizacion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Fiscalización
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Fiscalización
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 14 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 14 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionFiscalizacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
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

Test 14 - Consulta Tributaria Aprobado desde Direccion de Fiscalizacion [DireccionFiscalizacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 14 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionFiscalizacion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 14 - Consulta Tributaria Aprobado desde Direccion de Fiscalizacion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 15 - Consulta Tributaria Rechazado desde Direccion de Fiscalizacion [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Consulta Tributaria Rechazado desde Direccion de Fiscalizacion Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 15 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 15 - Consulta Tributaria Rechazado desde Direccion de Fiscalizacion [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Fiscalización
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Fiscalización
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 15 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 15 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionFiscalizacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
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

Test 15 - Consulta Tributaria Rechazado desde Direccion de Fiscalizacion [DireccionFiscalizacion] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 15 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionFiscalizacion] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionFiscalizacion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 15 - Consulta Tributaria Rechazado desde Direccion de Fiscalizacion Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 16 - Consulta Tributaria Aprobado desde Direccion de Informatica [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Consulta Tributaria Aprobado desde Direccion de Informatica Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 16 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 16 - Consulta Tributaria Aprobado desde Direccion de Informatica [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Informática
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Informática
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 16 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 16 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionInformatica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
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

Test 16 - Consulta Tributaria Aprobado desde Direccion de Informatica [DireccionInformatica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 16 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionInformatica] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 16 - Consulta Tributaria Aprobado desde Direccion de Informatica Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 17 - Consulta Tributaria Rechazado desde Direccion de Informatica [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 17 - Consulta Tributaria Rechazado desde Direccion de Informatica Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 17 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 17 - Consulta Tributaria Rechazado desde Direccion de Informatica [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Informática
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Informática
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 17 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 17 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 17 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionInformatica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
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


Test 17 - Consulta Tributaria Rechazado desde Direccion de Informatica [DireccionInformatica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 17 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionInformatica] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 17 - Consulta Tributaria Rechazado desde Direccion de Informatica Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 18 - Consulta Tributaria Aprobado desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 18 - Consulta Tributaria Aprobado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 18 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 18 - Consulta Tributaria Aprobado desde Direccion de Recaudaciones [operador mesa] Paso 2
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

Test 18 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 18 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 18 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
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

Test 18 - Consulta Tributaria Aprobado desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 3
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

Test 18 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 18 - Consulta Tributaria Aprobado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 19 - Consulta Tributaria Rechazado desde Direccion de Recaudaciones [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 19 - Consulta Tributaria Rechazado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 19 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 19 - Consulta Tributaria Rechazado desde Direccion de Recaudaciones [operador mesa] Paso 2
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

Test 19 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 19 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 19 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionRecaudaciones] Paso 3
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

Test 19 - Consulta Tributaria Rechazado desde Direccion de Recaudaciones [DireccionRecaudaciones] Paso 3
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

Test 19 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionRecaudaciones] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionRecaudaciones}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 19 - Consulta Tributaria Rechazado desde Direccion de Recaudaciones Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 20 - Consulta Tributaria Aprobado desde Direccion Juridica y Tecnica [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 20 - Consulta Tributaria Aprobado desde Direccion Juridica y Tecnica Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 20 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 20 - Consulta Tributaria Aprobado desde Direccion Juridica y Tecnica [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección Jurídica y Técnica
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección Jurídica y Técnica
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 20 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 20 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 20 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionJuridicaTecnica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
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

Test 20 - Consulta Tributaria Aprobado desde Direccion Juridica y Tecnica [DireccionJuridicaTecnica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 20 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionJuridicaTecnica] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 20 - Consulta Tributaria Aprobado desde Direccion Juridica y Tecnica Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador


Test 21 - Consulta Tributaria Rechazado desde Direccion Juridica y Tecnica [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear una nueva consulta tributaria como borrador
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test 1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test 1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test 1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 21 - Consulta Tributaria Rechazado desde Direccion Juridica y Tecnica Chequear Estado Desde Usuario [ciudadano] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente
    Cerrar Navegador

Test 21 - Consulta Tributaria: verificar el estado del tramite (pendiente) [operador mesa] Paso 1
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente
    Cerrar Navegador

Test 21 - Consulta Tributaria Rechazado desde Direccion Juridica y Tecnica [operador mesa] Paso 2
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección Jurídica y Técnica
    Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección Jurídica y Técnica
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 21 - Consulta Tributaria verificar si el boton del tacho esta bloqueado - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton del tacho para cancelar el tramite se encuentre bloqueado
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Element Should Be Disabled    //tbody/tr[td[1]="${tramite}"]//button
    Cerrar Navegador

Test 21 - Consulta Tributaria verificar si el boton cancelar tramite no existe - boton cancelar tramite [ciudadano] Paso 2
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Desde el usuario del ciudadano, se verifica que el boton cancelar tramite no exista dentro del tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Wait Until Page Does Not Contain Element    ${botonCancelartramite}
    Cerrar Navegador

Test 21 - Consulta Tributaria: verificar si los botones de acciones son correctos [DireccionJuridicaTecnica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
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

Test 21 - Consulta Tributaria Rechazado desde Direccion Juridica y Tecnica [DireccionJuridicaTecnica] Paso 3
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DespachoSubdireccionGeneral y utiliza la opcion "RechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Cerrar Navegador
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 21 - Consulta Tributaria: verificar el estado del tramite (Finalizado) [DireccionJuridicaTecnica] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionJuridicaTecnica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonTramitesFinalizados}    botonTramitesFinalizados
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Finalizado
    Cerrar Navegador

Test 21 - Consulta Tributaria Rechazado desde Direccion Juridica y Tecnica Chequear Estado Desde Usuario [ciudadano] Paso 4
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Finalizado
    Cerrar Navegador
