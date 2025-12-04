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
#Agustina: ${FILE2}
#************************************************************************************************************

#Agregar acciones que no van
#Ver que no funciona seleccionar la flecha

***Test Cases***
Test 0 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite como borrador [ciudadano]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 0 - Nota formal: crear tramite como borrador [ciudadano]
    [Documentation]    El ciudadano crea un tramite de Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test1  detalleExenciónImpuestoDeSellos
    
    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILE2}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir


    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 0 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 0 - Nota formal: verificar el estado del tramite (borrador) [ciudadano]
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

Test 0 - Nota formal: verificar el estado del tramite (Borrador) [operador mesa] 2
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Tramite Inexistente    ${tablaOperador}    ${tramite}

Test 1 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite como borrador [ciudadano]
    ...    ... se guarda el tramite [ciudadano]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 1 - Nota formal: crear tramite como borrador [ciudadano]
    [Documentation]    El ciudadano crea un tramite de Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test1  detalleExenciónImpuestoDeSellos
    
    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILE2}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 1 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 1 - Nota formal: verificar el estado del tramite (borrador) [ciudadano] 1
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

Test 1 - Nota formal: pasar de borrador a guardado
    [Documentation]    Desde el ciudadano, se entra al tramite y se guarda para que deje de estar en borrador
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${tramiteBorrador}    abrirPrimerTramite

    Validar y hacer clic en el boton    ${botonContinuarBorrador}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonEnviarTramite}    botonEnviarTramite
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s


Test 1 - Nota formal: verificar el estado del tramite (pendiente) [ciudadano] 2
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 2 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 2 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... solicitar datos adicionales [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 2 - Nota formal: crear tramite [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal sin agregar adjuntos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 2 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso


Test 2 - Nota formal: verificar el estado del tramite (pendiente) [ciudadano] 3
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 2 - Nota formal: verificar el estado del tramite (pendiente) [operador] 4
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 2 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ##Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria


Test 2 - Nota formal: se selecciona la opcion "solicitar datos adicionales" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Execute Javascript    window.scrollTo(0,800)
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 2 - Nota formal: verificar el estado del tramite (pendiente contributente) [ciudadano] 5
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente Contribuyente

Test 2 - Nota formal: el ciudadano avanza en el tramite [ciudadano] 6
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    #ATENCION! - Modificar debido a que aún no se sabe el método en que el usuario podrá cargar datos adicionales
    Fail    Fallo: el ciudadano no puede cargar datos adicionales

Test 3 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 3 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... no corresponde [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 - Nota formal: Se crea un tramite de Nota formal [ciudadano]
    [Documentation]    El ciudadano crea una nueva Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test1  detalleExenciónImpuestoDeSellos
    
    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILE2}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir


    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 3 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 3 - Nota formal: verificar el estado del tramite (pendiente) [ciudadano] 1
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 3 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 2
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 3 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria


Test 3 - Nota formal: se selecciona la opcion "no corresponde" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep    7s
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 3 - Nota formal: verificar el estado del tramite (cerrado) [ciudadano] 3
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 4 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 4 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a secretaria [operador mesa]
    ...    ... no corresponde [secretaria]
    ...    ... enviar a secretaria [operador mesa]
    ...    ... para resolver [secretaria]
    ...    ... aprobar [gestion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 4 - Nota formal: se crea un tramite de norta formal [ciudadano]
    [Documentation]    Crear una nueva Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test1  detalleExenciónImpuestoDeSellos
    
    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILE2}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
     Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir


    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 4 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 4 - Nota formal: verificar el estado del tramite (pendiente) [ciudadano] 1
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 4 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 2
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

#VER ESTE ---------------------------------------------------------------------------------------------------------------
Test 4 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria



Test 4 - Nota formal: se selecciona la opcion "enviar a secretaria" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s

    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 3
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Nota formal: verificar si los botones de acciones son correctos [secretaria] 2
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resolver

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

#ACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Test 4 - Nota formal: se selecciona la opcion "no corresponde" [secretaria]
    [Documentation]    Entra como Secretaria para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Execute Javascript    window.scrollTo(0,1200)
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 5
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 6
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Devuelto

Test 4 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 3
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 4 - Nota formal: se selecciona la opcion "enviar a secretaria". [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 7
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Nota formal: verificar el estado del tramite (pendiente) [secretaria] 8
    [Documentation]    Desde la secretaria, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Asignado

Test 4 - Nota formal: verificar si los botones de acciones son correctos [secretaria] 4
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resolver

Test 4 - Nota formal: se selecciona la opcion "para resolver" [secretaria]
    [Documentation]    Entra como Secretaria para continuar con el proceso,utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 9
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 4 - Nota formal: verificar el estado del tramite (en curso) [gestion] 10
    [Documentation]    Desde el usuario gestion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 4 - Nota formal: verificar si los botones de acciones son correctos [gestion] 5
    [Documentation]    Se ingresa como gestion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente


Test 4 - Nota formal: se selecciona la opcion "aprobado" [gestion]
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 11
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 4 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 12
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Aprobado

Test 4 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 6
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

Test 4 - Nota formal: se selecciona la opcion "informar al contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - Nota formal: verificar el estado del tramite (cerrado) [ciudadano] 13
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Cerrado

Test 5 - Nota formal: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 5 es el siguiente:
    ...    ... crear tramite [ciudadano] -
    ...    ... enviar a secretaria [operador mesa]
    ...    ... para resolver [secretaria]
    ...    ... rechazar [gestion]
    ...    ... informar al contribuyente [operador mesa]
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 5 - Nota formal: se crea un tramite de nota formal [ciudadano]
    [Documentation]    Crear una nueva Nota formal
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExenciónImpuestoDeSellos}    ${botonExenciónImpuestoDeSellos}
    Validar y completar campo    ${asuntoExenciónImpuestoDeSellos}  Asunto test1    asuntoExenciónImpuestoDeSellos
    Validar y completar campo    ${detalleExenciónImpuestoDeSellos}  Descripcion test1  detalleExenciónImpuestoDeSellos

    #Verificar y presionar ítem en lista    ${select}    DNI/CUIT
    #Choose file    ${InputTypeFile}    ${FILE2}
    #Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir

    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILE2}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Test 5 - Nota formal: Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Asignar Tag Numerado
    Log To Console    Comentario del proceso

Test 5 - Nota formal: verificar el estado del tramite (pendiente) [ciudadano] 1
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Pendiente

Test 5 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 2
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Pendiente

Test 5 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 1
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria

    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 5 - Nota formal: se selecciona la opcion "enviar a secretaria" [operador entrada]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 3
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Nota formal: verificar si los botones de acciones son correctos [secretaria] 2
    [Documentation]    Se ingresa como secretaria y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar Boton Sin Fallar  ${paraResolver}  boton para resolver

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 5 - Nota formal: se selecciona la opcion "para resolver" [secretaria]
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    En curso

Test 5 - Nota formal: verificar el estado del tramite (en curso) [gestion] 5
    [Documentation]    Desde el usuario gestion, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    En revisión

Test 5 - Nota formal: verificar si los botones de acciones son correctos [gestion] 3
    [Documentation]    Se ingresa como gestion y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar Boton Sin Fallar  ${botonRechazar}  boton rechazar

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${informarContribuyente}  boton informar contribuyente

Test 5 - Nota formal: se selecciona la opcion "rechazar" [gestion]
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Sleep  6s
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Nota formal: verificar el estado del tramite (en curso) [ciudadano] 6
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Resuelto

Test 5 - Nota formal: verificar el estado del tramite (pendiente) [operador mesa] 7
    [Documentation]    Desde el operador mesa, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Rechazado

Test 5 - Nota formal: verificar si los botones de acciones son correctos [operador mesa] 4
    [Documentation]    Se ingresa como operador mesa y se verifica que aparezcan los botones de acciones correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}

    Wait Until Element Is Visible    xpath=${mensajeSeleccioneUnaAccionParaContinuar}    timeout=10s

    Verificar Boton Sin Fallar  ${agregarNota}  boton agregar nota
    Verificar Boton Sin Fallar  ${informarContribuyente}  boton informar al contribuyente

    Verificar si el boton no existe Sin Fallar  ${botonSolicitarDatosAdicionales}  boton solicitar datos adicionales
    Verificar si el boton no existe Sin Fallar  ${botonNoCorresponde}  boton no corresponde
    Verificar si el boton no existe Sin Fallar  ${enviarSecretaria}  boton enviar a secretaria
    Verificar si el boton no existe Sin Fallar  ${paraResolver}  boton para resolver
    Verificar si el boton no existe Sin Fallar  ${botonAprobar}  boton aprobar
    Verificar si el boton no existe Sin Fallar  ${botonRechazar}  boton rechazar

Test 5 - Nota formal: se selecciona la opcion "informar contribuyente" [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    #Validar y hacer clic en el boton    ${abrirPrimerTramiteAgus}    abrirPrimerTramite
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - Nota formal: verificar el estado del tramite (cerrado) [ciudadano] 8
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado con numero de tramite    ${tablaOperador}    4    ${tramite}    Cerrado

#-----------------------------------------------------------------------------------------------

