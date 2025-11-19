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
${botonConsultaVinculante}    //h3[normalize-space()='Consulta Vinculante']
${asuntoConsultaVinculante}    //input[@id='cmh99oteg0001n2v8y4enxt0t']
${detalleConsultaVinculante}    //textarea[@id='cmh99w1ak0003n2v87az51vqy']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${UPLOAD_INPUT}    xpath=//input[@type='file']
${FILE_PATH}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/DniPrueba.png

***Test Cases***

Consulta Vinculante Paso 1
    [Documentation]    Crear una nueva consulta vinculante
    [tags]    test_04
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaVinculante}    botonConsultaVinculante
    Validar y completar campo    ${asuntoConsultaVinculante}  Asunto test1    asuntoConsultaVinculante
    Validar y completar campo    ${detalleConsultaVinculante}  Descripcion test1  detalleConsultaVinculante
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

Consulta Vinculante Paso 2
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

Consulta Vinculante Paso 3
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

Consulta Vinculante Paso 4
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

Consulta Vinculante Paso 5
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

