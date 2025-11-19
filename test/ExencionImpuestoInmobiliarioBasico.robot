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
${botonExencionImpuestoInmobiliarioBasico}    //h3[normalize-space()='Exención de Impuesto Inmobiliario Básico']
${asuntoExencionImpuestoIB}    //input[@id='cmhy6sett000gnocln3chn0tn']
${detalleExencionImpuestoIB}    //textarea[@id='cmhy6t90w000inocljvj5tanb']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${UPLOAD_INPUT}    xpath=//input[@type='file'][1]
${FILE_PATH}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/DniPrueba.png

#Chequear si funcionan
${UPLOAD_INPUT2}    xpath=//input[@type='file'][2]
${UPLOAD_INPUT3}    xpath=//input[@type='file'][3]
${UPLOAD_TEMPLOS}    xpath=//h4[contains(text(), 'Inmuebles destinados a templos religiosos')]/following::input[@type='file']

***Test Cases***

ExencionImpuestoInmobiliarioBasico Paso 1
    [Documentation]    Crear una nueva Exencion de Impuesto Inmobiliari oBasico
    [tags]    test_01
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonExencionImpuestoInmobiliarioBasico}    botonExencionImpuestoInmobiliarioBasico
    Validar y completar campo    ${asuntoExencionImpuestoIB}  Asunto test1    asuntoExencionImpuestoIB
    Validar y completar campo    ${detalleExencionImpuestoIB}  Descripcion test1  detalleExencionImpuestoIB
    Verificar y presionar ítem en lista    xpath=(//select)[1]    DNI del Solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=(//select)[1]    Copia del documento que acredite la representación del solicitante
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Verificar y presionar ítem en lista    xpath=(//select)[1]    Constancia de CUIT del titular/Organismo/Institucion
    Choose File    ${UPLOAD_INPUT}    ${FILE_PATH}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
#Ver despues como poder aniadir el ultimo select
#    Verificar y presionar ítem en lista    xpath=(//select)[2]    Constancia de inscripción en el Registro Nacional de Cultos
#    Choose File    ${UPLOAD_TEMPLOS}    ${FILE_PATH}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
#    Verificar y presionar ítem en lista    xpath=(//select)[2]    Constancia de inscripción en el Registro Nacional de Cultos
#    Choose File    ${UPLOAD_INPUT2}    ${FILE_PATH}
#    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    //button[normalize-space()='Enviar Solicitud']    botonEnviarSolicitud
    Wait Until Page Contains    ha sido registrado y está siendo procesado    timeout=10s

ExencionImpuestoInmobiliarioBasico Paso 2
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso
    [tags]    test_02
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

ExencionImpuestoInmobiliarioBasico Paso 3
    [Documentation]    Entra como Secretaria para continuar con el proceso
    [tags]    test_03
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

ExencionImpuestoInmobiliarioBasico Paso 4
    [Documentation]    Entra como Gestion para continuar con el proceso
    [tags]    test_04
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

ExencionImpuestoInmobiliarioBasico Paso 5
    [Documentation]    Entra como operador mesa entrada para informar al usuario de la decision final del proceso
    [tags]    test_05
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Validar y hacer clic en el boton    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']    botonBandejaEntrada
    Validar y hacer clic en el boton    //tbody/tr[1]/td[8]    flechaSiguiente
    Validar y hacer clic en el boton    //h4[normalize-space()='Agregar Nota']    agregarNota
    Validar y hacer clic en el boton    //button[normalize-space()='Cancelar']    botonCancelar
    Validar y hacer clic en el boton    //h4[normalize-space()='Informar al Contribuyente']    informarContribuyente
    Validar y hacer clic en el boton    //button[normalize-space()='Confirmar']    botonConfirmar
    Wait Until Page Contains    La acción se ha ejecutado correctamente.    timeout=10s


