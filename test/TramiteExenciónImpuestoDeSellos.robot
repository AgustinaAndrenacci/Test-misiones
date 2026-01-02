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


#-------INDICACION DE TESTS-------

#Test 1: Crear tramite como borrador
#Test 2: Solicitar datos adicionales
#Test 3: No corresponde [Operador Mesa]
#Test 4: Enviado a Direccion - Devuelto a Mesa de Entrada - Enviado a direccion - Aprobado [Gestion]
#Test 5: Rechazado [Gestion]
#Test 6: Aprobado [Direccion]
#Test 7: Rechazado [Direccion]

***Test Cases***
Test 1 - Excencion Impuesto de Sellos: Indicacion del proceso 1
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite como borrador [ciudadano]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 1 - Excencion Impuesto de Sellos: crear tramite como borrador [ciudadano] 2
    [Documentation]    El ciudadano crea un tramite de Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    botonExenciónImpuestoDeSellos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test0    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test0  detalleExenciónImpuestoDeSellos
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido test0  contenidoExenciónImpuestoDeSellos

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    Copia de DNI del solicitante
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    Limpieza de variable    ${tramite}
    ${tramite}=    Obtener Numero De Tramite
    Verificacion de si se creo el tramite   ${tramite}
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado 3
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 1 - Excencion Impuesto de Sellos: verificar el estado del tramite (borrador) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

Test 1 - Excencion Impuesto de Sellos: verificar el estado del tramite (Borrador) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

#verificacion del actualizar borrador
Test 1 - Excencion Impuesto de Sellos: Verificacion de datos
    [Documentation]    Desde el ciudadano, se verifica que los datos de los campos sean correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    tramite

    #chequeo que los campos esten corretos
    Verificar Contenido De Campos    ${idAsuntoExenciónImpuestoDeSellos}  Asunto  Asunto test0
    Verificar Contenido De Campos    ${idDetalleExenciónImpuestoDeSellos}  Descripcion  Descripcion test0
    Verificar Contenido De Campos    ${idContenidoExenciónImpuestoDeSellos}  Contenido  Contenido test0
    Verificar presencia de... con...    ${ubicacionArchivoBorrador}    Copia de DNI del solicitante

Test 1 - Excencion Impuesto de Sellos: modificacion de datos
    [Documentation]    Desde el ciudadano, se modifican los datos del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    tramite

    #borro y actualizo los datos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto    asunto
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion  detalle
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido  contenido
    Verificar y presionar ítem en lista index    ${select}    Copia del instrumento que origina el acto
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonActualizarBorrador}    boton actualizar borrador
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 - Excencion Impuesto de Sellos: verificacion de los datos del tramite
    [Documentation]    Desde el ciudadano, se verifica si los datos son correctos del tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    tramite

    #chequeo que los campos esten corretos
    Verificar Contenido De Campos    ${idAsuntoExenciónImpuestoDeSellos}  Asunto  Asunto
    Verificar Contenido De Campos    ${idDetalleExenciónImpuestoDeSellos}  Descripcion  Descripcion
    Verificar Contenido De Campos    ${idContenidoExenciónImpuestoDeSellos}  Contenido  Contenido
    Verificar presencia de... con...    ${ubicacionArchivoBorrador}    Copia del instrumento que origina el acto

Test 1 - Excencion Impuesto de Sellos: pasar de borrador a guardado
    [Documentation]    Desde el ciudadano, se guarda el tramite asi deja de ser borrador
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${abrirTramiteGenerado}    tramite

    Validar y hacer clic en el boton    ${botonContinuarBorrador}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.

Test 1 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 10
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 1 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador] 4
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 12
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 13
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 14
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: Indicacion del proceso 1
    [Documentation]    El proceso que se realiza en el TEST 2 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... solicitar datos adicionales [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 - Excencion Impuesto de Sellos: crear tramite [ciudadano] 2
    [Documentation]    El ciudadano crea una nueva Excencion Impuesto de Sellos sin agregar adjuntos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    botonExenciónImpuestoDeSellos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test2    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test2  detalleExenciónImpuestoDeSellos
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido test2  contenidoExenciónImpuestoDeSellos

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado 3
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 2 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 9
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ##Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 2 - Excencion Impuesto de Sellos: se selecciona la opcion "solicitar datos adicionales" [operador mesa] 10
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Execute Javascript    window.scrollTo(0,800)
    Se selecciona X accion    ${botonSolicitarDatosAdicionales}    boton Solicitar Datos Adicionales    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente contributente) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 12
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 13
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 14
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 2 - Excencion Impuesto de Sellos: se responde [ciudadano]
    [Documentation]    Desde el ciudadano, se responde con los archivos necesarios para el operador
    Asignar Tag Numerado
    #Si fallo lo anterior
    #Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Presionar x boton en la fila del tramite    ${tablaMistramitesRecientes}    ${botonVerDetalleINICIO}    ${tramite}
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Te envio los archivos faltantes    campoComentarioAdicional
    Choose file    ${botonSeleccionarArchivos}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Verificar Y Esperar Visibilidad De Elemento    Su trámite ha sido actualizado. Recargamos la información para reflejar el nuevo estado.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 2 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 2 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 2 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 3 - Excencion Impuesto de Sellos: Indicacion del proceso 1
    [Documentation]    El proceso que se realiza en el TEST 3 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... no corresponde [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 - Excencion Impuesto de Sellos: Se crea un tramite de Excencion Impuesto de Sellos [ciudadano] 2
    [Documentation]    El ciudadano crea una nueva Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    botonExenciónImpuestoDeSellos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test3    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test3  detalleExenciónImpuestoDeSellos
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido test3  contenidoExenciónImpuestoDeSellos

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir


    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado 3
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 3 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 9
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 3 - Excencion Impuesto de Sellos: se selecciona la opcion "no corresponde" [operador mesa] 10
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${botonNoCorresponde}    boton No Corresponde    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 3 - Excencion Impuesto de Sellos: verificar el estado del tramite (cerrado) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 12
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 13
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 14
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 3 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: Indicacion del proceso 1
    [Documentation]    El proceso que se realiza en el TEST 4 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a Direccion [operador mesa]
    ...    ... no corresponde [Direccion]
    ...    ... enviar a Direccion [operador mesa]
    ...    ... para resolver [Direccion]
    ...    ... aprobar [gestion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 4 - Excencion Impuesto de Sellos: se crea un tramite de norta formal [ciudadano] 2
    [Documentation]    Crear una nueva Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    botonExenciónImpuestoDeSellos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test4    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test4  detalleExenciónImpuestoDeSellos
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido test4  contenidoExenciónImpuestoDeSellos

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir


    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado 3
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 9
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "enviar a Direccion" [operador mesa] 10
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${enviarDireccion}    enviar A Direccion    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 12
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [responsable area] 12
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 13
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [Direccion] 16
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [direccion] - instancia 1

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "no corresponde" [Direccion] 17
    [Documentation]    Entra como Direccion para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Execute Javascript    window.scrollTo(0,1200)
    Se selecciona X accion    ${botonNoCorresponde}    boton No Corresponde    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 18
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 19
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Devuelto

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 20
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 21
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 22
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 23
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "enviar a Direccion". [operador mesa] 24
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${enviarDireccion}    enviar A Direccion    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 25
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [Direccion] 26
    [Documentation]    Desde la Direccion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [responsable area] 12
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 27
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 29
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [Direccion] 30
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

   Verificar los botones de acciones [direccion] - instancia 1

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "para resolver" [Direccion] 31
    [Documentation]    Entra como Direccion para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${paraResolver}    para Resolver    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 32
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [gestion] 33
    [Documentation]    Desde el usuario gestion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 34
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 35
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 36
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [gestion] 37
    [Documentation]    Se ingresa como gestion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [gestion] - instancia 1

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "aprobado" [gestion] 38
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${botonAprobar}    boton Aprobar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 39
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 40
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Aprobado

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 41
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 42
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 43
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 44
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 2

Test 4 - Excencion Impuesto de Sellos: se selecciona la opcion "informar al contribuyente" [operador mesa] 45
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    #Se selecciona X accion con estado final    ${informarContribuyente}    informar Contribuyente
    Se selecciona X accion    ${informarContribuyente}    informar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (cerrado) [ciudadano] 46
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 47
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 48
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 49
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 4 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 50
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}


Test 5 - Excencion Impuesto de Sellos: Indicacion del proceso 1
    [Documentation]    El proceso que se realiza en el TEST 5 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a Direccion [operador mesa]
    ...    ... para resolver [Direccion]
    ...    ... rechazar [gestion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 5 - Excencion Impuesto de Sellos: se crea un tramite de Excencion Impuesto de Sellos [ciudadano] 2
    [Documentation]    Crear una nueva Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    botonExenciónImpuestoDeSellos
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test5    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test5  detalleExenciónImpuestoDeSellos
    Validar y completar campo    ${contenidoExenciónImpuestoDeSellos}  Contenido test5  contenidoExenciónImpuestoDeSellos

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 5 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado 3
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 9
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 5 - Excencion Impuesto de Sellos: se selecciona la opcion "enviar a Direccion" [operador entrada] 10
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    #Se selecciona X accion con estado final    ${informarContribuyente}    informar Contribuyente
    Se selecciona X accion    ${informarContribuyente}    informar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [Direccion] 12
    [Documentation]    Desde la Direccion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [responsable area] 12
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 13
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [Direccion] 16
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [direccion] - instancia 1

Test 5 - Excencion Impuesto de Sellos: se selecciona la opcion "para resolver" [Direccion] 17
    [Documentation]    Entra como Direccion para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${paraResolver}    para Resolver    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 18
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [gestion] 19
    [Documentation]    Desde el usuario gestion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 20
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 21
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 22
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [gestion] 23
    [Documentation]    Se ingresa como gestion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [gestion] - instancia 1

Test 5 - Excencion Impuesto de Sellos: se selecciona la opcion "rechazar" [gestion] 24
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${botonRechazar}    rechazar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 25
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 26
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Rechazado

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 27
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 28
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 29
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 30
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 2

Test 5 - Excencion Impuesto de Sellos: se selecciona la opcion "informar contribuyente" [operador mesa] 31
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    #Se selecciona X accion con estado final    ${informarContribuyente}    informar Contribuyente
    Se selecciona X accion    ${informarContribuyente}    informar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 5 - Excencion Impuesto de Sellos: verificar el estado del tramite (cerrado) [ciudadano] 32
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaOperador}    3    ${tramite}    Cerrado

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 33
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 34
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 35
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 5 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 36
    [Documentation]    Desde el USUARIO, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}


Test 6 - Excencion Impuesto de Sellos: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el Test 6 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a Direccion [operador mesa]
    ...    ... aprobar [Direccion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 - Excencion Impuesto de Sellos: se crea un tramite de Excencion Impuesto de Sellos [ciudadano]
    [Documentation]    Crear una nueva Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonNotaFormal}    botonNotaFormal
    Validar y completar campo    ${asuntoNotaFormal}  Asunto test5    asuntoNotaFormal
    Validar y completar campo    ${detalleNotaFormal}  Descripcion test5  detalleNotaFormal
    Validar y completar campo    ${contenidoNotaFormal}  Contenido test5  contenidoNotaFormal

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista    ${select}    Poder/Representación
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 6 - Excencion Impuesto de Sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${enviarDireccion}    enviar A Direccion    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (asignado) [Direccion] 12
    [Documentation]    Desde la Direccion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (asignado) [responsable area] 12
    [Documentation]    Desde resp area, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 13
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [Direccion] 2
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [direccion] - instancia 1

Test 6 - Excencion Impuesto de Sellos: se selecciona la opcion "aprobar" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso, utilizando la opcion "aprobar" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${botonAprobar}    aprobar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (resuelto) [ciudadano] 25
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (aprobado) [operador mesa] 26
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Aprobado

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 27
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 28
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 29
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 4
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 2

Test 6 - Excencion Impuesto de Sellos: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    #Se selecciona X accion con estado final    ${informarContribuyente}    informar Contribuyente
    Se selecciona X accion    ${informarContribuyente}    informar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 6 - Excencion Impuesto de Sellos: verificar el estado del tramite (cerrado) [ciudadano] 32
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaOperador}    3    ${tramite}    Cerrado

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 33
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 34
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 35
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 6 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 36
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el Test 7 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a Direccion [operador mesa]
    ...    ... rechazar [Direccion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 7 - Excencion Impuesto de Sellos: se crea un tramite de Excencion Impuesto de Sellos [ciudadano]
    [Documentation]    Crear una nueva Excencion Impuesto de Sellos
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonNotaFormal}    botonNotaFormal
    Validar y completar campo    ${asuntoNotaFormal}  Asunto test5    asuntoNotaFormal
    Validar y completar campo    ${detalleNotaFormal}  Descripcion test5  detalleNotaFormal
    Validar y completar campo    ${contenidoNotaFormal}  Contenido test5  contenidoNotaFormal

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILEAgus}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista    ${select}    Poder/Representación
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 7 - Excencion Impuesto de Sellos: Indicacion del numero de proceso creado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (pendiente) [operador mesa] 5
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 6
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 7
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 8
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 1

Test 7 - Excencion Impuesto de Sellos: se selecciona la opcion "enviar a Direccion" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Se selecciona X accion    ${enviarDireccion}    enviar A Direccion    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (en curso) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (asignado) [Direccion] 12
    [Documentation]    Desde la Direccion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (asignado) [responsable area] 12
    [Documentation]    Desde resp area, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 13
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 15
    [Documentation]    Desde el gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [Direccion] 2
    [Documentation]    Se ingresa como Direccion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [direccion] - instancia 1

Test 7 - Excencion Impuesto de Sellos: se selecciona la opcion "rechazar" [Direccion]
    [Documentation]    Entra como Direccion para continuar con el proceso, utilizando la opcion "rechazar" enviandolo hacia Gestion
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
     Se selecciona X accion    ${botonRechazar}    rechazar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (resuelto) [ciudadano] 25
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (rechazado) [operador mesa] 26
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Rechazado

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 27
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 28
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 29
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar si los botones de acciones son correctos [operador mesa] 4
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Verificar Y Esperar Visibilidad De Elemento por localizador    xpath=${mensajeSeleccioneUnaAccionParaContinuar}

    Verificar los botones de acciones [operador mesa] - instancia 2

Test 7 - Excencion Impuesto de Sellos: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    #Se selecciona X accion con estado final    ${informarContribuyente}    informar Contribuyente
    Se selecciona X accion    ${informarContribuyente}    informar    ${FILEpdfAgus}    ${pdfAgus}
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 7 - Excencion Impuesto de Sellos: verificar el estado del tramite (cerrado) [ciudadano] 32
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano3}  ${passCiudadano}  ${circuloUsuario}
    Validar Estado con numero de tramite    ${tablaOperador}    3    ${tramite}    Cerrado

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [operador mesa] 33
    [Documentation]    Desde el operador mesa, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [responsable area] 34
    [Documentation]    Desde resp area, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userRespArea}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [Direccion] 35
    [Documentation]    Desde Direccion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userSecretaria}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 7 - Excencion Impuesto de Sellos: verificar que el tramite no exista [gestion] 36
    [Documentation]    Desde gestion, se verifica que no se pueda visualizar el tramite
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Inicio sesion y verificacion de texto inicial - operador    ${userGestion}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}