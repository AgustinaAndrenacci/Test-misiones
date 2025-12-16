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

*** Variables ***
${espacioDeArchivosDocCom}    //div[@class='flex flex-col flex-1']//main

***Test Cases***

Crear Consulta Vinculante Correcta [ciudadano]
    [Documentation]    Crear una nueva consulta Vinculante
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Wait Until Element Is Visible    ${circuloUsuario}    timeout=10s
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y completar campo    ${asuntoConsultaVinculante}  Asunto test1    asuntoConsultaVinculante
    Validar y completar campo    ${detalleConsultaVinculante}  Descripcion test1  detalleConsultaVinculante
    Validar y completar campo    ${contenidoConsultaVinculante}  Contenido test1  contenidoConsultaVinculante
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
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

#-------------MESA DE ENTRADA VIRTUAL----------------------

Consulta Vinculante MesaEntrada verificar SubTitulo [operador mesa]
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Consulta Vinculante MesaEntrada Verificar NumeroTramite [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Vinculante MesaEntrada Verificar Fecha de Creacion [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Vinculante MesaEntrada Verificar Numero de Seguimiento [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Vinculante MesaEntrada Verificar DatosPresentados Asunto [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Vinculante MesaEntrada Verificar DatosPresentados Detalle [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Vinculante MesaEntrada verificar Estado [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Pendiente

Consulta Vinculante MesaEntrada verificar Datos Ciudadano [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Vinculante MesaEntrada verificar Asignacion [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Mesa de Entrada Virtual

#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------
#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se pueda crear la documentacion sin añadir una observacion
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se pueda crear la documentacion sin añadir un archivo
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcionDocCom}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${campoDescripcion}   boton subir documento
    Verificar NO presencia de... con...    ${botonSubirDocumento}    ${docLean}

Consulta Vinculante verificar Boton Documentacion complementaria [operador mesa]
    [Documentation]    Desde el operador mesa entrada, abre la Consulta Vinculante y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcion}  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Consulta Vinculante: no se elimina la documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador mesa entrada y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [operador mesa]
    [Documentation]    Desde el operador mesa entrada, abre la Consulta Vinculante y comprueba que se pueda eliminar la "Documentacion complementaria"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}    botonEliminarDocumentacion
    Validar y hacer clic en el boton    ${EliminarDocumento}    EliminarDocumento
    Wait Until Page Contains    El documento se ha eliminado correctamente.    timeout=10s

Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante MesaEntrada verificar Historial [operador mesa]
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Trámite enviado por el usuario."']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota MesaEntrada""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Vinculante Enviar a Secretaria [operador mesa]
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a secretaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarSecretaria}    enviarASecretaria
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------SECRETARIA----------------------

Consulta Vinculante Secretaria verificar SubTitulo [secretaria]
    [Documentation]    Desde la Secretaria Dirección abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Consulta Vinculante Secretaria Verificar NumeroTramite [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Vinculante Secretaria Verificar Fecha de Creacion [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Vinculante Secretaria Verificar Numero de Seguimiento [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Vinculante Secretaria Verificar DatosPresentados Asunto [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Vinculante Secretaria Verificar DatosPresentados Detalle [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Vinculante Secretaria verificar Estado [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Asignado

Consulta Vinculante Secretaria verificar Datos Ciudadano [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Vinculante Secretaria verificar Asignacion [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Secretaria Dirección

#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------
#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [secretaria]
    [Documentation]    Entra como secretaria y se verifica que no se pueda crear la documentacion sin añadir una observacion
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [secretaria]
    [Documentation]    Entra como secretaria y se verifica que no se pueda crear la documentacion sin añadir un archivo
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [secretaria]
    [Documentation]    Entra como secretaria y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcionDocCom}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${campoDescripcion}   boton subir documento
    Verificar NO presencia de... con...    ${botonSubirDocumento}    ${docLean}

Consulta Vinculante verificar Boton Documentacion complementaria [secretaria]
    [Documentation]    Desde la secretaria, abre la Consulta Vinculante y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcion}  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Consulta Vinculante: no se elimina la documentacion complementaria [secretaria]
    [Documentation]    Entra como secretaria y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [secretaria]
    [Documentation]    Desde la secretaria, abre la Consulta Vinculante y comprueba que se pueda eliminar la "Documentacion complementaria"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}    botonEliminarDocumentacion
    Validar y hacer clic en el boton    ${EliminarDocumento}    EliminarDocumento
    Wait Until Page Contains    El documento se ha eliminado correctamente.    timeout=10s

Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [secretaria]
    [Documentation]    Entra como secretaria y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante Secretaria verificar Historial [secretaria]
    [Documentation]    Desde la Secretaria Dirección, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Enviar a Secretaria"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Secretaria""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Vinculante Enviar a Gestion [secretaria]
    [Documentation]    Entra como Secretaria para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${paraResolver}    paraResolver
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------GESTION----------------------

Consulta Vinculante Gestion verificar SubTitulo [gestion]
    [Documentation]    Desde la Gestión Dirección abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Consulta Vinculante Gestion Verificar NumeroTramite [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Consulta Vinculante Gestion Verificar Fecha de Creacion [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Consulta Vinculante Gestion Verificar Numero de Seguimiento [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Consulta Vinculante Gestion Verificar DatosPresentados Asunto [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Consulta Vinculante Gestion Verificar DatosPresentados Detalle [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Consulta Vinculante Gestion verificar Estado [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    En revisión

Consulta Vinculante Gestion verificar Datos Ciudadano [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Consulta Vinculante Gestion verificar Asignacion [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Gestión Dirección

#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------
#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [gestion]
    [Documentation]    Entra como gestion y se verifica que no se pueda crear la documentacion sin añadir una observacion
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [gestion]
    [Documentation]    Entra como gestion y se verifica que no se pueda crear la documentacion sin añadir un archivo
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}

Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [gestion]
    [Documentation]    Entra como gestion y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcionDocCom}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${campoDescripcion}   boton subir documento
    Verificar NO presencia de... con...    ${botonSubirDocumento}    ${docLean}

Consulta Vinculante verificar Boton Documentacion complementaria [gestion]
    [Documentation]    Desde la gestion, abre la Consulta Vinculante y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    botonSubir
    Choose File    ${InputTypeFile}    ${FILE3}
    Validar y completar campo    ${campoDescripcion}  Nota Gestion  Descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}  botonSubirDocumento
    Wait Until Page Contains    El documento se ha agregado correctamente al trámite.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Consulta Vinculante: no se elimina la documentacion complementaria [gestion]
    [Documentation]    Entra como gestion y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [gestion]
    [Documentation]    Desde la gestion, abre la Consulta Vinculante y comprueba que se pueda eliminar la "Documentacion complementaria"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}    botonEliminarDocumentacion
    Validar y hacer clic en el boton    ${EliminarDocumento}    EliminarDocumento
    Wait Until Page Contains    El documento se ha eliminado correctamente.    timeout=10s

Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [gestion]
    [Documentation]    Entra como gestion y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Consulta Vinculante Secretaria verificar Historial [gestion]
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Para Resolver"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Gestion""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Vinculante Aprobado Enviar a MesaEntrada [gestion]
    [Documentation]    Entra como Gestion y utiliza la opcion "Aprobar" para continuar con el proceso
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobar}    botonAprobar
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------APROBADO Y MESA DE ENTRADA VIRTUAL----------------------

Consulta Vinculante MesaEntrada verificar Estado Aprobado [operador mesa]
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto. En este caso buscando el estado Aprobado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Aprobado

Consulta Vinculante MesaEntrada verificar Historial Aprobado [operador mesa]
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Aprobar"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Consulta Vinculante Informar al Contribuyente [operador mesa]
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso, en este caso "Aprobado"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${informarContribuyente}    informarContribuyente
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s