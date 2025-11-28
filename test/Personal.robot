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
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    [tags]    test_02
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria MesaEntrada Verificar NumeroTramite
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    [tags]    test_03
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria MesaEntrada Verificar Fecha de Creacion
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    [tags]    test_04
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    [tags]    test_05
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    [tags]    test_06
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    [tags]    test_07
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria MesaEntrada verificar Estado
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    [tags]    test_08
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria MesaEntrada verificar Datos Ciudadano
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    [tags]    test_09
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria MesaEntrada verificar Asignacion
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    [tags]    test_10
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Mesa de Entrada Virtual

Consulta Tributaria MesaEntrada verificar Boton Documentacion complementaria
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    [tags]    test_11
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota MesaEntrada  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria MesaEntrada verificar Historial
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    [tags]    test_12
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
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
    [Documentation]    Desde la Secretaria Dirección abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    [tags]    test_14
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Secretaria Verificar NumeroTramite
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    [tags]    test_15
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Secretaria Verificar Fecha de Creacion
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    [tags]    test_16
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Secretaria Verificar Numero de Seguimiento
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    [tags]    test_17
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria Secretaria Verificar DatosPresentados Asunto
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    [tags]    test_18
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria Secretaria Verificar DatosPresentados Detalle
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    [tags]    test_19
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria Secretaria verificar Estado
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    [tags]    test_20
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Asignado

Consulta Tributaria Secretaria verificar Datos Ciudadano
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    [tags]    test_21
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria Secretaria verificar Asignacion
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    [tags]    test_22
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Secretaria Dirección

Consulta Tributaria Secretaria verificar Boton Documentacion complementaria
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    [tags]    test_23
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota Secretaria  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    [tags]    test_24
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
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
    [Documentation]    Desde la Gestión Dirección abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    [tags]    test_26
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Gestion Verificar NumeroTramite
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    [tags]    test_27
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar presencia parcial    ${NumeroTramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Gestion Verificar Fecha de Creacion
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    [tags]    test_28
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Gestion Verificar Numero de Seguimiento
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    [tags]    test_29
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    ${NumeroTramite}=    Get text    ${abrirPrimerTramite}
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Verificar Numero de Seguimiento    ${NumeroTramite}

Consulta Tributaria Gestion Verificar DatosPresentados Asunto
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    [tags]    test_30
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Asunto    Asunto test1

Consulta Tributaria Gestion Verificar DatosPresentados Detalle
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    [tags]    test_31
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Detalle    Descripcion test1

Consulta Tributaria Gestion verificar Estado
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    [tags]    test_32
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    En revisión

Consulta Tributaria Gestion verificar Datos Ciudadano
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    [tags]    test_33
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria Gestion verificar Asignacion
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    [tags]    test_34
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Area Asignada    Gestión Dirección

Consulta Tributaria Gestion verificar Boton Documentacion complementaria
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    [tags]    test_35
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    [tags]    test_36
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
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
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto. En este caso buscando el estado Aprobado
    [tags]    test_38
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar Estado Del Tramite    Aprobado

Consulta Tributaria MesaEntrada verificar Historial Aprobado
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    [tags]    test_39
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Validar y hacer clic en el boton    ${abrirPrimerTramite}    abrirPrimerTramite
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
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

