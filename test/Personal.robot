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

***Test Cases***

Crear Consulta Tributaria
    [Documentation]    Crear una nueva consulta tributaria
    [tags]    test_01
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Verificar y presionar ítem en lista    ${select}    DNI del Solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del documento que acredite la representación del solicitante
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    ${select}    Copia del instrumento que origina el acto
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

#-------------MESA DE ENTRADA VIRTUAL----------------------

Consulta Tributaria MesaEntrada verificar SubTitulo
    [Documentation]
    [tags]    test_02
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    //p[@class='text-muted-foreground']    El titulo no se encontro visible

Consulta Tributaria MesaEntrada Verificar NumeroTramite
    [Documentation]
    [tags]    test_03
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria MesaEntrada Verificar Fecha de Creacion
    [Documentation]
    [tags]    test_04
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    xpath=//label[normalize-space(.)='Fecha de Creación']/following-sibling::p
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento
    [Documentation]
    [tags]    test_05
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto
    [Documentation]
    [tags]    test_06
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle
    [Documentation]
    [tags]    test_07
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria MesaEntrada verificar Estado
    [Documentation]
    [tags]    test_08
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria MesaEntrada verificar Datos Ciudadano
    [Documentation]
    [tags]    test_09
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    CREDISER AR    30709021296@tsg.gob.ar    30709021296

Consulta Tributaria MesaEntrada verificar Asignacion
    [Documentation]
    [tags]    test_10
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Mesa de Entrada Virtual

Consulta Tributaria MesaEntrada verificar Boton Documentacion complementaria
    [Documentation]
    [tags]    test_11
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //button[normalize-space()='Subir']    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    //textarea[@id='description']  Nota MesaEntrada  Descripcion
    Validar y hacer clic en el boton    //button[normalize-space()='Subir Documento']  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria MesaEntrada verificar Historial
    [Documentation]
    [tags]    test_12
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //h3[normalize-space()='Historial y Notas']    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite enviado por el usuario."']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota MesaEntrada""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Enviar a Secretaria
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    [tags]    test_13
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------SECRETARIA----------------------

Consulta Tributaria Secretaria verificar SubTitulo
    [Documentation]
    [tags]    test_14
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    //p[@class='text-muted-foreground']    El titulo no se encontro visible

Consulta Tributaria Secretaria Verificar NumeroTramite
    [Documentation]
    [tags]    test_15
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Secretaria Verificar Fecha de Creacion
    [Documentation]
    [tags]    test_16
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    xpath=//label[normalize-space(.)='Fecha de Creación']/following-sibling::p
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Secretaria Verificar Numero de Seguimiento
    [Documentation]
    [tags]    test_17
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria Secretaria Verificar DatosPresentados Asunto
    [Documentation]
    [tags]    test_18
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria Secretaria Verificar DatosPresentados Detalle
    [Documentation]
    [tags]    test_19
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria Secretaria verificar Estado
    [Documentation]
    [tags]    test_20
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Asignado

Consulta Tributaria Secretaria verificar Datos Ciudadano
    [Documentation]
    [tags]    test_21
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    CREDISER AR    30709021296@tsg.gob.ar    30709021296

Consulta Tributaria Secretaria verificar Asignacion
    [Documentation]
    [tags]    test_22
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Secretaria Dirección

Consulta Tributaria Secretaria verificar Boton Documentacion complementaria
    [Documentation]
    [tags]    test_23
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //button[normalize-space()='Subir']    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    //textarea[@id='description']  Nota Secretaria  Descripcion
    Validar y hacer clic en el boton    //button[normalize-space()='Subir Documento']  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial
    [Documentation]
    [tags]    test_24
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //h3[normalize-space()='Historial y Notas']    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Enviar a Secretaria"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Secretaria""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Enviar a Gestion
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    [tags]    test_25
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------GESTION----------------------

Consulta Tributaria Gestion verificar SubTitulo
    [Documentation]
    [tags]    test_26
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    //p[@class='text-muted-foreground']    El titulo no se encontro visible

Consulta Tributaria Gestion Verificar NumeroTramite
    [Documentation]
    [tags]    test_27
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Gestion Verificar Fecha de Creacion
    [Documentation]
    [tags]    test_28
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    xpath=//label[normalize-space(.)='Fecha de Creación']/following-sibling::p
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Gestion Verificar Numero de Seguimiento
    [Documentation]
    [tags]    test_29
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria Gestion Verificar DatosPresentados Asunto
    [Documentation]
    [tags]    test_30
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria Gestion Verificar DatosPresentados Detalle
    [Documentation]
    [tags]    test_31
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria Gestion verificar Estado
    [Documentation]
    [tags]    test_32
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    En revisión

Consulta Tributaria Gestion verificar Datos Ciudadano
    [Documentation]
    [tags]    test_33
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    CREDISER AR    30709021296@tsg.gob.ar    30709021296

Consulta Tributaria Gestion verificar Asignacion
    [Documentation]
    [tags]    test_34
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Gestión Dirección

Consulta Tributaria Gestion verificar Boton Documentacion complementaria
    [Documentation]
    [tags]    test_35
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //button[normalize-space()='Subir']    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    //textarea[@id='description']  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    //button[normalize-space()='Subir Documento']  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial
    [Documentation]
    [tags]    test_36
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //h3[normalize-space()='Historial y Notas']    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Para Resolver"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Gestion""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Aprobado Enviar a MesaEntrada
    [Documentation]    Entra como Gestion y utiliza la opcion "Aprobar" para continuar con el proceso
    [tags]    test_37
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------APROBADO Y MESA DE ENTRADA VIRTUAL----------------------

Consulta Tributaria MesaEntrada verificar Estado Aprobado
    [Documentation]
    [tags]    test_38
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Aprobado

Consulta Tributaria MesaEntrada verificar Historial Aprobado
    [Documentation]
    [tags]    test_39
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    //h3[normalize-space()='Historial y Notas']    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Aprobar"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Informar al Contribuyente
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Aprobado"
    [tags]    test_40
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s


*** Keywords ***

Verificar Numero de Seguimiento
    [Arguments]    ${codigo_esperado}
    Wait Until Element Is Visible    //label[normalize-space()='Número de Seguimiento']    timeout=5s
    Log    El <p> con clase 'text-muted-foreground mt-1' está visible
    ${codigo_actual}=    Get Text    (//p[@class='font-mono'])[1]
    Log    Codigo de tramite capturado: ${codigo_actual}
    Run Keyword If    '${codigo_actual}' != '${codigo_esperado}'    Fail    El Numero de Seguimiento no coincide con el esperado. Se esperaba: '${codigo_esperado}', sin embargo aparecio: '${codigo_actual}'
    Log    El asunto coincide con el valor esperado


Verificar presencia parcial
    [Arguments]    ${textoEsperado}    ${mensajeExtra}
    Wait Until Page Contains    ${textoEsperado}    timeout=7s
    ${existe}=    Run Keyword And Return Status    Page Should Contain    ${textoEsperado}
    IF    not ${existe}
        Captura Screenshot In Log
        Fail    ${mensajeExtra}
    END
    Sleep    2s


Extraer Fecha Creado
    ${FECHA_CREADO_RAW}=    Get Text    //label[normalize-space()='Fecha de Creación']
    ${FECHA_CREADO_LIMPIA}=    Replace String    ${FECHA_CREADO_RAW}    Creado:    ${EMPTY}
    RETURN    ${FECHA_CREADO_LIMPIA}

Comparar Fecha Creacion
    [Arguments]    ${FECHA_RAW}
    ${partes}=    Split String    ${FECHA_RAW}    ,
    ${FECHA_SOLO}=    Strip String    ${partes[0]}
    Log To Console    Fecha sin hora: ${FECHA_SOLO}

    ${FECHA_ISO}=    Convertir Fecha Slash A ISO    ${FECHA_SOLO}
    ${FECHA_ACTUAL}=    Get Current Date    result_format=%Y-%m-%d

    Log To Console    Fecha actual: ${FECHA_ACTUAL}
    Log To Console    Fecha extraída (ISO): ${FECHA_ISO}

    Should Be Equal    ${FECHA_ISO}    ${FECHA_ACTUAL}
    Log To Console    La fecha de creación coincide con la fecha actual

Convertir Fecha Slash A ISO
    [Arguments]    ${fecha_slash}
    ${partes}=    Split String    ${fecha_slash}    /
    ${dia}=    Strip String    ${partes[0]}
    ${mes}=    Strip String    ${partes[1]}
    ${anio}=    Strip String    ${partes[2]}
    ${fecha_iso}=    Set Variable    ${anio}-${mes}-${dia.zfill(2)}
    RETURN    ${fecha_iso}

Validar Detalle
    [Arguments]    ${detalle_esperado}
    ${detalle_actual}=    Get Text    xpath=//span[normalize-space(.)='Detalle']/following-sibling::span
    Log    Detalle capturado: ${detalle_actual}
    Run Keyword If    '${detalle_actual}' != '${detalle_esperado}'    Fail    El detalle no coincide con el esperado. Se esperaba: '${detalle_esperado}', sin embargo aparecio: '${detalle_actual}'
    Log    El detalle coincide con el valor esperado

Validar Asunto
    [Arguments]    ${asunto_esperado}
    Wait Until Element Is Visible    xpath=//div[@class="flex flex-col"]    timeout=5s
    Log    El bloque de asunto está visible
    ${asunto_actual}=    Get Text    xpath=(//div[@class="flex flex-col"]/span)[2]
    Log    Asunto capturado: ${asunto_actual}
    Run Keyword If    '${asunto_actual}' != '${asunto_esperado}'    Fail    El asunto no coincide con el esperado. Se esperaba: '${asunto_esperado}', sin embargo aparecio: '${asunto_actual}'
    Log    El asunto coincide con el valor esperado

Validar Datos Identidad
    [Arguments]    ${nombreEsperado}    ${emailEsperado}    ${dniEsperado}

    ${nombreHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//h4[contains(@class, 'font-semibold')]
    Log To Console    \nNombre extraido: ${nombreHTML}
    Should Contain    ${nombreHTML}    ${nombreEsperado}

    ${emailHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//p[contains(text(), '@')]
    Log To Console    Email extraido: ${emailHTML}
    Should Be Equal    ${emailHTML}    ${emailEsperado}

    ${dniHTML}=    Get Text    xpath=//div[.//h3[normalize-space(.)='Ciudadano']]//p[contains(text(), 'DNI')]
    Log To Console    DNI extraido: ${dniHTML}
    Should Contain    ${dniHTML}    ${dniEsperado}


Validar Area Asignada
    [Arguments]    ${areaEsperada}
    ${areaHTML}=    Get Text    xpath=//label[normalize-space(.)='Área Asignada']/following-sibling::div//span
    Log To Console    Area extraida: ${areaHTML}

    IF    "${areaHTML}" == "${areaEsperada}"
        Log To Console    Area asignada coincide con la esperada
    ELSE
        Fail    Area asignada no coincide: se esperaba '${areaEsperada}' pero se encontró '${areaHTML}'
    END

Validar Estado Del Tramite
    [Arguments]    ${estado_esperado}
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//span[normalize-space(text())='${estado_esperado}']    timeout=10s
    IF    ${visible}
        ${estado_actual}=    Get Text    xpath=//span[normalize-space(text())='${estado_esperado}']
        Log    Estado validado correctamente: ${estado_actual}
    ELSE
        Fail    No se encontro visible el estado esperado.
    END