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

#-------INDICACION DE TESTS-------

#Test 1: Consulta Vinculante [operador mesa]
#       Paso1:Verificar SubTitulo [operador mesa]
#       Paso2:Verificar NumeroTramite [operador mesa]
#       Paso3:Verificar Fecha de Creacion [operador mesa]
#       Paso4:Verificar Numero de Seguimiento [operador mesa]
#       Paso5:Verificar DatosPresentados Asunto [operador mesa]
#       Paso6:Verificar DatosPresentados Detalle [operador mesa]
#       Paso7:Verificar Estado [operador mesa]
#       Paso8:Verificar Datos Ciudadano [operador mesa]
#       Paso9:Verificar Asignacion [operador mesa]
#       Paso10:Documentacion Complementaria [operador mesa]
#       Paso11:Verificar Historial [operador mesa]
#       Paso 12:Enviar a Direccion [operador mesa]

#Test 2: Consulta Vinculante [Direccion]
#       Paso1:Verificar SubTitulo [Direccion]
#       Paso2:Verificar NumeroTramite [Direccion]
#       Paso3:Verificar Fecha de Creacion [Direccion]
#       Paso4:Verificar Numero de Seguimiento [Direccion]
#       Paso5:Verificar DatosPresentados Asunto [Direccion]
#       Paso6:Verificar DatosPresentados Detalle [Direccion]
#       Paso7:Verificar Estado [Direccion]
#       Paso8:Verificar Datos Ciudadano [Direccion]
#       Paso9:Verificar Asignacion [Direccion]
#       Paso10:Documentacion Complementaria [Direccion]
#       Paso11:Verificar Historial [Direccion]
#       Paso 12:Enviar a Gestion [Direccion]

#Test 3: Consulta Vinculante [Gestion]
#       Paso1:Verificar SubTitulo [Gestion]
#       Paso2:Verificar NumeroTramite [Gestion]
#       Paso3:Verificar Fecha de Creacion [Gestion]
#       Paso4:Verificar Numero de Seguimiento [Gestion]
#       Paso5:Verificar DatosPresentados Asunto [Gestion]
#       Paso6:Verificar DatosPresentados Detalle [Gestion]
#       Paso7:Verificar Estado [Gestion]
#       Paso8:Verificar Datos Ciudadano [Gestion]
#       Paso9:Verificar Asignacion [Gestion]
#       Paso10:Documentacion Complementaria [Gestion]
#       Paso11:Verificar Historial [Gestion]
#       Paso 12:Aprobado Enviar a MesaEntrada [Gestion]

#Test 4: Consulta Vinculante [Operador Mesa]
#       Paso1:Verificar Estado Aprobado [operador mesa]
#       Paso2:Verificar Historial [operador mesa]
#       Paso3:Informar Al Contribuyente [operador mesa]

Test 1 - Crear Consulta Vinculante Correcta [ciudadano]
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

Test 1 - Consulta Vinculante MesaEntrada verificar SubTitulo [operador mesa] Paso 1
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Test 1 - Consulta Vinculante MesaEntrada Verificar NumeroTramite [operador mesa] Paso 2
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 1 - Consulta Vinculante MesaEntrada Verificar Fecha de Creacion [operador mesa] Paso 3
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 1 - Consulta Vinculante MesaEntrada Verificar Numero de Seguimiento [operador mesa] Paso 4
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 1 - Consulta Vinculante MesaEntrada Verificar DatosPresentados Asunto [operador mesa] Paso 5
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 1 - Test 1 - Consulta Vinculante MesaEntrada Verificar DatosPresentados Detalle [operador mesa] Paso 6
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 1 - Consulta Vinculante MesaEntrada verificar Estado [operador mesa] Paso 7
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Pendiente

Test 1 - Consulta Vinculante MesaEntrada verificar Datos Ciudadano [operador mesa] Paso 8
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 1 - Consulta Vinculante MesaEntrada verificar Asignacion [operador mesa] Paso 9
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

Test 1 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [operador mesa] Paso 10
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

Test 1 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [operador mesa]
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

Test 1 - Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [operador mesa]
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

Test 1 - Consulta Vinculante verificar Boton Documentacion complementaria [operador mesa]
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

Test 1 - Consulta Vinculante: no se elimina la documentacion complementaria - [operador mesa]
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

Test 1 - Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [operador mesa]
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

Test 1 - Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Test 1 - Consulta Vinculante MesaEntrada verificar Historial [operador mesa] Paso 11
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

Test 1 - Consulta Vinculante Enviar a Direccion [operador mesa] Paso 12
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#-------------Direccion----------------------

Test 2 - Consulta Vinculante Direccion verificar SubTitulo [Direccion] Paso 1
    [Documentation]    Desde la Direccion abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Test 2 - Consulta Vinculante Direccion Verificar NumeroTramite [Direccion] Paso 2
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 2 - Consulta Vinculante Direccion Verificar Fecha de Creacion [Direccion] Paso 3
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 2 - Consulta Vinculante Direccion Verificar Numero de Seguimiento [Direccion] Paso 4
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 2 - Consulta Vinculante Direccion Verificar DatosPresentados Asunto [Direccion] Paso 5
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 2 - Consulta Vinculante Direccion Verificar DatosPresentados Detalle [Direccion] Paso 6
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 2 - Consulta Vinculante Direccion verificar Estado [Direccion] Paso 7
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Asignado

Test 2 - Consulta Vinculante Direccion verificar Datos Ciudadano [Direccion] Paso 8
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 2 - Consulta Vinculante Direccion verificar Asignacion [Direccion] Paso 9
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Direccion

#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------
#-----------------------DOCUMENTACION COMPLEMENTARIA---------------------

Test 2 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [Direccion] Paso 10
    [Documentation]    Entra como Direccion y se verifica que no se pueda crear la documentacion sin añadir una observacion
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

Test 2 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [Direccion]
    [Documentation]    Entra como Direccion y se verifica que no se pueda crear la documentacion sin añadir un archivo
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

Test 2 - Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [Direccion]
    [Documentation]    Entra como Direccion y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
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

Test 2 - Consulta Vinculante verificar Boton Documentacion complementaria [Direccion]
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que se pueda agregar una "Documentacion complementaria" y subirla correctamente
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

Test 2 - Consulta Vinculante: no se elimina la documentacion complementaria [Direccion]
    [Documentation]    Entra como Direccion y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar
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

Test 2 - Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [Direccion]
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y comprueba que se pueda eliminar la "Documentacion complementaria"
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

Test 2 - Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [Direccion]
    [Documentation]    Entra como Direccion y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Test 2 - Consulta Vinculante Direccion verificar Historial [Direccion] Paso 11
    [Documentation]    Desde la Direccion, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}     ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Enviar a Direccion"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"
    Verificar presencia de    //p[normalize-space()='"Se agregó el documento complementario: "Nota Direccion""']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Test 2 - Consulta Vinculante Enviar a Gestion [Direccion] Paso 12
    [Documentation]    Entra como Direccion para continuar con el proceso, utilizando la opcion "Para Resolver" enviandolo hacia Gestion
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

Test 3 - Consulta Vinculante Gestion verificar SubTitulo [gestion] Paso 1
    [Documentation]    Desde la Gestión Dirección abre la Consulta Vinculante anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaVinculante}    El titulo no se encontro visible

Test 3 - Consulta Vinculante Gestion Verificar NumeroTramite [gestion] Paso 2
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 3 - Consulta Vinculante Gestion Verificar Fecha de Creacion [gestion] Paso 3
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 3 - Consulta Vinculante Gestion Verificar Numero de Seguimiento [gestion] Paso 4
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 3 - Consulta Vinculante Gestion Verificar DatosPresentados Asunto [gestion] Paso 5
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 3 - Consulta Vinculante Gestion Verificar DatosPresentados Detalle [gestion] Paso 6
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 3 - Consulta Vinculante Gestion verificar Estado [gestion] Paso 7
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    En revisión

Test 3 - Consulta Vinculante Gestion verificar Datos Ciudadano [gestion] Paso 8
    [Documentation]    Desde la Gestión Dirección, abre la Consulta Vinculante y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 3 - Consulta Vinculante Gestion verificar Asignacion [gestion] Paso 9
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

Test 3 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin observacion [gestion] Paso 10
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

Test 3 - Consulta Vinculante: agregar documentacion complementaria - intentar subir sin archivo [gestion]
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

Test 3 - Consulta Vinculante: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [gestion]
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

Test 3 - Consulta Vinculante verificar Boton Documentacion complementaria [gestion]
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

Test 3 - Consulta Vinculante: no se elimina la documentacion complementaria [gestion]
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

Test 3 - Consulta Vinculante verificar Boton Eliminar Documentacion complementaria [gestion]
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

Test 3 - Consulta Vinculante: verificacion de documentacion complementaria eliminada - archivo: doc [gestion]
    [Documentation]    Entra como gestion y agrega documentacion complementaria
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docLean}

Test 3 - Consulta Vinculante Direccion verificar Historial [gestion] Paso 11
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

Test 3 - Consulta Vinculante Aprobado Enviar a MesaEntrada [gestion] Paso 12
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

Test 4 - Consulta Vinculante MesaEntrada verificar Estado Aprobado [operador mesa] Paso 1
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Vinculante y comprueba que el "Estado del Tramite" sea visible y correcto. En este caso buscando el estado Aprobado
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Aprobado

Test 4 - Consulta Vinculante MesaEntrada verificar Historial Aprobado [operador mesa] Paso 2
    [Documentation]    Nuevamente entra a la Mesa de Entrada, abre la Consulta Vinculante y verificar que en el "Historial" se vean los mensajes de notas/cambios correspondientes
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    botonHistorial
    Verificar presencia de    //p[normalize-space()='"Acción ejecutada: Aprobar"']    En el Historial no se encontro visible que el tramite se asigne a la "Mesa de Entrada Virtual"

Test 4 - Consulta Vinculante Informar al Contribuyente [operador mesa] Paso 3
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