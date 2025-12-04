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

#Suite Setup    Inicializar Contador

***Test Cases***

Crear Consulta Tributaria [ciudadano]
    [Documentation]    Crear una nueva consulta tributaria
    Asignar Tag Numerado
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
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}

Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

#-------------MESA DE ENTRADA VIRTUAL----------------------

Consulta Tributaria MesaEntrada verificar SubTitulo [operador mesa]
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria MesaEntrada Verificar NumeroTramite [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Tributaria MesaEntrada Verificar Fecha de Creacion [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Tributaria MesaEntrada verificar Estado [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Pendiente

Consulta Tributaria MesaEntrada verificar Datos Ciudadano [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria MesaEntrada verificar Asignacion [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Mesa de Entrada Virtual

Consulta Tributaria MesaEntrada verificar Boton Documentacion complementaria [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota MesaEntrada  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria MesaEntrada verificar Historial [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite enviado por el usuario."']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota MesaEntrada""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Enviar a Secretaria [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------SECRETARIA----------------------

Consulta Tributaria Secretaria verificar SubTitulo [secretaria]
    [Documentation]    Desde la Secretaria Dirección abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Secretaria Verificar NumeroTramite [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Secretaria Verificar Fecha de Creacion [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Secretaria Verificar Numero de Seguimiento [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Tributaria Secretaria Verificar DatosPresentados Asunto [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Tributaria Secretaria Verificar DatosPresentados Detalle [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Tributaria Secretaria verificar Estado [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Asignado

Consulta Tributaria Secretaria verificar Datos Ciudadano [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria Secretaria verificar Asignacion [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Secretaria Dirección

Consulta Tributaria Secretaria verificar Boton Documentacion complementaria [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota Secretaria  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Enviar a Secretaria"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Secretaria""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Enviar a Gestion [secretaria]
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------GESTION----------------------

Consulta Tributaria Gestion verificar SubTitulo [gestion]
    [Documentation]    Desde la Gestión Dirección abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Consulta Tributaria Gestion Verificar NumeroTramite [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Tributaria Gestion Verificar Fecha de Creacion [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Tributaria Gestion Verificar Numero de Seguimiento [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Tributaria Gestion Verificar DatosPresentados Asunto [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Tributaria Gestion Verificar DatosPresentados Detalle [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Tributaria Gestion verificar Estado [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    En revisión

Consulta Tributaria Gestion verificar Datos Ciudadano [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Tributaria Gestion verificar Asignacion [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Gestión Dirección

Consulta Tributaria Gestion verificar Boton Documentacion complementaria [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE}
    Validar y completar campo    ${campoDescripcion}  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s

Consulta Tributaria Secretaria verificar Historial [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Para Resolver"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Gestion""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Aprobado Enviar a MesaEntrada [gestion]
    [Documentation]    Entra como Gestion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

#-------------APROBADO Y MESA DE ENTRADA VIRTUAL----------------------

Consulta Tributaria MesaEntrada verificar Estado Aprobado [operador mesa]
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto. En este caso buscando el estado Aprobado
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Aprobado

Consulta Tributaria MesaEntrada verificar Historial Aprobado [operador mesa]
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Tributaria y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Aprobar"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Tributaria Informar al Contribuyente [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Aprobado"
    Asignar Tag Numerado
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

