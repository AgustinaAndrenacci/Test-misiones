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

Suite Setup    Inicializar Contador

*** Variables ***

#Chequear si funcionan
${UPLOAD_INPUT2}    xpath=//input[@type='file'][2]
${UPLOAD_INPUT3}    xpath=//input[@type='file'][3]
${UPLOAD_TEMPLOS}    xpath=//h4[contains(text(), 'Inmuebles destinados a templos religiosos')]/following::input[@type='file']

***Test Cases***

Test 1 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 1 es el siguiente:
    ...    ... crear tramite como borrador [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 1 - ExencionImpuestoInmobiliarioBasico GuardarBorrador [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonGuardarBorrador}    botonGuardarBorrador
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 1 - ExencionImpuestoInmobiliarioBasico GuardarBorrador Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Borrador

Test 2 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 2 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... solicitar datos adicionales [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 2 - ExencionImpuestoInmobiliarioBasico Solicitar Datos [ciudadano] Adicionales Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico sin agregar abjuntos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 2 - ExencionImpuestoInmobiliarioBasico Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente

Test 2 - ExencionImpuestoInmobiliarioBasico Solicitar Datos Adicionales [operador mesa] Paso 2
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Solicitar Datos Adicionales    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 2 - ExencionImpuestoInmobiliarioBasico Solicitar Datos Adicionales Chequear Estado Desde Usuario [ciudadano] Paso 2
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente Contribuyente

Test 3 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
    [Documentation]    El proceso que se realiza en el TEST 3 es el siguiente:
    ...    ... crear tramite [ciudadano]
    ...    ... chequear estado del tramite [ciudadano]
    ...    ... documentacion no corresponde [operador mesa]
    ...    ... chequear estado del tramite [ciudadano]
    Log To Console    Comentario del proceso

Test 3 - ExencionImpuestoInmobiliarioBasico Documentacion NoCorresponde [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico sin agregar abjuntos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 3 - ExencionImpuestoInmobiliarioBasico Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente

Test 3 - ExencionImpuestoInmobiliarioBasico Documentacion NoCorresponde [operador mesa] Paso 2
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 3 - ExencionImpuestoInmobiliarioBasico Documentacion NoCorresponde Chequear Estado Desde Usuario [ciudadano] Paso 2
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Cerrado

Test 4 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
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

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico completando todos los campos
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que acredite la titularidad del inmueble
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [operador mesa] Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 2
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [secretaria] Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso dandole a la opcion "No Corresponde" devolviendo el tramite hacia Mesa de Entrada.
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    No Corresponde    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 3
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [operador mesa] Paso 4
    [Documentation]    Entra como operador mesa entrada, verifica que los botones del operador se encuentren disponibles, y continua con el proceso del tramite enviandolo a secretaria nuevamente
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa, tramite devuelto    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Verificar Boton Sin Fallar    ${botonNoCorresponde}    botonNoCorresponde
    Verificar Boton Sin Fallar    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria, todo ok    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 4
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [secretaria] Paso 5
    [Documentation]    Entra como Secretaria para continuar con el proceso, ahora si utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 5
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [gestion] Paso 6
    [Documentation]    Entra como Gestion aprobando el tramite para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 6
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Resuelto

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada [operador mesa] Paso 7
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 4 - ExencionImpuestoInmobiliarioBasico Devuelto a Mesa de Entrada Chequear Estado Desde Usuario [ciudadano] Paso 7
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Cerrado

Test 5 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
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

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado desde Gestion [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado desde Gestion [operador mesa] Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 2
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado desde Gestion [secretaria] Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 3
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado desde Gestion [gestion] Paso 4
    [Documentation]     Entra como Gestion Rechazando el tramite y continua con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonRechazar}    botonRechazar
    Validar y completar campo    ${campoComentario}    Rechazado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 4
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Resuelto

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado desde Gestion [operador mesa] Paso 5
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Rechazado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 5 - ExencionImpuestoInmobiliarioBasico Rechazado Chequear Estado Desde Usuario [ciudadano] Paso 5
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Cerrado

Test 6 - ExencionImpuestoInmobiliarioBasico: Indicacion del proceso
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

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [ciudadano] Paso 1
    [Documentation]    Crear una nueva ExencionImpuestoInmobiliarioBasico
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que acredite la titularidad del inmueble
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
#Ver despues como poder aniadir el ultimo select
#    Verificar y presionar ítem en lista index    xpath=//select    0
#    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta Chequear Estado Desde Usuario [ciudadano] Paso 1
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Pendiente

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [operador mesa] Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y completar campo    ${campoComentario}    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta Chequear Estado Desde Usuario [ciudadano] Paso 2
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [secretaria] Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y completar campo    ${campoComentario}    Para Resolver    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta Chequear Estado Desde Usuario [ciudadano] Paso 3
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    En curso

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [gestion] Paso 4
    [Documentation]    Entra como Gestion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y completar campo    ${campoComentario}    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    ${botonConfirmar}   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y completar campo    ${campoComentario}    Aprobado    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta Chequear Estado Desde Usuario [ciudadano] Paso 4
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Resuelto

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta [operador mesa] Paso 5
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Aprobado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${agregarNota}    agregarNota
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Test 6 - ExencionImpuestoInmobiliarioBasico Correcta Chequear Estado Desde Usuario [ciudadano] Paso 5
    [Documentation]    Entra desde el usuario para chequear que se actualiza el Estado del tramite segun en que parte del ciclo esta
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar Estado Primer Tramite    ${tablaMisTramitesRecientes}    Cerrado

