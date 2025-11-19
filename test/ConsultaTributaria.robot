*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs

Library    C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/EmbedScreenshotLibrary.py

Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

Test Setup     Abrir navegador
Test Teardown  Cerrar navegador

*** Variables ***

${botonComenzarAhora}    //a[normalize-space()='Comenzar ahora']
${botonConsultaTributaria}    //h3[normalize-space()='Consulta Tributaria']
${asuntoConsultaTributaria}    //input[@id='cmhmi8ndf001xnowdryf6h1jo']
${detalleConsultaTributaria}    //textarea[@id='cmhmi8p0l001znowdbqy9xmv6']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${UPLOAD_INPUT}    xpath=//input[@type='file']
${FILE_PATH}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/DniPrueba.png

${pruebaBoton}    //h4[normalize-space()='No Corresponde']

***Test Cases***

Consulta Tributaria Correcta Paso 4
    [Documentation]    Entra como Gestion para continuar con el proceso
    [tags]    test_18
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Pause Execution
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[1]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Aprobar']    Aprobar
    Validar y completar campo    //textarea[@id='action-notes']    Aprobado    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s


Consulta Tributaria Documentacion NoCorresponde Paso 1
    [Documentation]    Crear una nueva consulta tributaria sin completar
    [tags]    test_01
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y hacer clic en el boton    //button[normalize-space()='Enviar Solicitud']    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Consulta Tributaria Documentacion NoCorresponde Paso 2
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "No Corresponde"
    [tags]    test_02
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='No Corresponde']    botonNoCorresponde
    Validar y completar campo    //textarea[@id='action-notes']    No Corresponde    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 1
    [Documentation]    Crear una nueva consulta tributaria
    [tags]    test_03
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Verificar y presionar ítem en lista    xpath=//select    DNI del Solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=//select    Copia del documento que acredite la representación del solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=//select    Copia del instrumento que origina el acto
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    //button[normalize-space()='Enviar Solicitud']    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso
    [tags]    test_04
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Enviar a Secretaria']    enviarASecretaria
    Validar y completar campo    //textarea[@id='action-notes']    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso
    [tags]    test_05
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='No Corresponde']    botonNoCorresponde
    Validar y completar campo    //textarea[@id='action-notes']    No Corresponde    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 4
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso
    [tags]    test_06
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota OperadorMesa, tramite devuelto    campoComentarioNota
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Verificar Boton Sin Fallar    ${pruebaBoton}    botonNoCorresponde
    Verificar Boton Sin Fallar    //h4[normalize-space()='Solicitar Datos Adicionales']    botonSolicitarDatosAdicionales
    Validar y hacer clic en el boton    //h4[normalize-space()='Enviar a Secretaria']    enviarASecretaria
    Validar y completar campo    //textarea[@id='action-notes']    Enviar a Secretaria, todo ok    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 5
    [Documentation]    Entra como Secretaria para continuar con el proceso
    [tags]    test_07
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Para Resolver']    paraResolver
    Validar y completar campo    //textarea[@id='action-notes']    Para Resolver    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 6
    [Documentation]    Entra como Gestion para continuar con el proceso
    [tags]    test_08
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Pause Execution
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[1]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Aprobar']    Aprobar
    Validar y completar campo    //textarea[@id='action-notes']    Aprobado    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Devuelto a Mesa de Entrada Paso 7
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    [tags]    test_09
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar']    botonCancelar
    Validar y hacer clic en el boton    //h4[normalize-space()='Informar al Contribuyente']    informarContribuyente
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Rechazado desde Gestion Paso 1
    [Documentation]    Crear una nueva consulta tributaria
    [tags]    test_10
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Verificar y presionar ítem en lista    xpath=//select    DNI del Solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    //button[normalize-space()='Enviar Solicitud']    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Consulta Tributaria Rechazado desde Gestion Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso
    [tags]    test_11
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Enviar a Secretaria']    enviarASecretaria
    Validar y completar campo    //textarea[@id='action-notes']    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Rechazado desde Gestion Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso
    [tags]    test_12
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Para Resolver']    paraResolver
    Validar y completar campo    //textarea[@id='action-notes']    Para Resolver    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Rechazado desde Gestion Paso 4
    [Documentation]    Entra como Gestion para continuar con el proceso
    [tags]    test_13
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Pause Execution
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[1]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Rechazar']    Rechazar
    Validar y completar campo    //textarea[@id='action-notes']    Rechazado    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Rechazado desde Gestion Paso 5
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    [tags]    test_14
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar']    botonCancelar
    Validar y hacer clic en el boton    //h4[normalize-space()='Informar al Contribuyente']    informarContribuyente
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Correcta Paso 1
    [Documentation]    Crear una nueva consulta tributaria
    [tags]    test_15
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Verificar y presionar ítem en lista    xpath=//select    DNI del Solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=//select    Copia del documento que acredite la representación del solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=//select    Copia del instrumento que origina el acto
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
#Ver despues como poder aniadir el ultimo select
#    Verificar y presionar ítem en lista index    xpath=//select    0
#    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    //button[normalize-space()='Enviar Solicitud']    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

Consulta Tributaria Correcta Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso
    [tags]    test_16
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota OperadorMesa    campoComentarioNota
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Enviar a Secretaria']    enviarASecretaria
    Validar y completar campo    //textarea[@id='action-notes']    Enviar a Secretaria    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Correcta Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso
    [tags]    test_17
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userSecretaria}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Secretaria    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Para Resolver']    paraResolver
    Validar y completar campo    //textarea[@id='action-notes']    Para Resolver    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Correcta Paso 4
    [Documentation]    Entra como Gestion para continuar con el proceso
    [tags]    test_18
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userGestion}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Pause Execution
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[1]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y completar campo    //textarea[@id='action-notes']    Nota Gestion    campoComentarios
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']   botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s
    Validar y hacer clic en el boton    //h4[normalize-space()='Aprobar']    Aprobar
    Validar y completar campo    //textarea[@id='action-notes']    Aprobado    campoComentario
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

Consulta Tributaria Correcta Paso 5
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    [tags]    test_19
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar']    botonCancelar
    Validar y hacer clic en el boton    //h4[normalize-space()='Informar al Contribuyente']    informarContribuyente
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s

*** Keywords ***

Verificar Boton Sin Fallar
    [Arguments]    ${locator}    ${nombreBoton}

    ${status}    ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator}

    Run Keyword If    '${status}' == 'FAIL'    Log    El botón con locator ${nombreBoton} NO está visible (Error: ${value})    WARN
    Run Keyword If    '${status}' == 'PASS'    Log To Console    El botón con locator ${nombreBoton} está visible.



