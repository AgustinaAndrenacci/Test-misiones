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

Test Teardown  Cerrar navegador

Suite Setup    Inicializar Contador

#IMPORTANTE **************************************************************************************************
#Leandro: ${FILE}
#Agustina: ${FILEAgus}
#************************************************************************************************************

*** Variables ***
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
${docLean}    ADJUNTO.pdf
#${docLean}    ubicacion.png

${espacioDeArchivosDocCom}    //div[@class='flex flex-col flex-1']//main

***Test Cases***

#-------INDICACION DE TESTS-------

#Test 1: Consulta Tributaria [operador mesa]
#       Paso1:Verificar SubTitulo [operador mesa]
#       Paso2:Verificar NumeroTramite [operador mesa]
#       Paso3:Verificar Fecha de Creacion [operador mesa]
#       Paso4:Verificar Numero de Seguimiento [operador mesa]
#       Paso5:Verificar DatosPresentados Asunto [operador mesa]
#       Paso6:Verificar DatosPresentados Detalle [operador mesa]
#       Paso7:Verificar Estado [operador mesa]
#       Paso8:Verificar Datos Ciudadano [operador mesa]
#       Paso9:Verificar Asignacion [operador mesa]

#Test 2: Consulta Tributaria [Direccion]
#       Paso1:Verificar SubTitulo [Direccion]
#       Paso2:Verificar NumeroTramite [Direccion]
#       Paso3:Verificar Fecha de Creacion [Direccion]
#       Paso4:Verificar Numero de Seguimiento [Direccion]
#       Paso5:Verificar DatosPresentados Asunto [Direccion]
#       Paso6:Verificar DatosPresentados Detalle [Direccion]
#       Paso7:Verificar Estado [Direccion]
#       Paso8:Verificar Datos Ciudadano [Direccion]
#       Paso9:Verificar Asignacion [Direccion]

#Test 3: Consulta Tributaria [Departamento]
#       Paso1:Verificar SubTitulo [Gestion]
#       Paso2:Verificar NumeroTramite [Gestion]
#       Paso3:Verificar Fecha de Creacion [Gestion]
#       Paso4:Verificar Numero de Seguimiento [Gestion]
#       Paso5:Verificar DatosPresentados Asunto [Gestion]
#       Paso6:Verificar DatosPresentados Detalle [Gestion]
#       Paso7:Verificar Estado [Gestion]
#       Paso8:Verificar Datos Ciudadano [Gestion]
#       Paso9:Verificar Asignacion [Gestion]


Test 1 - Crear Consulta Tributaria [ciudadano]
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite de consulta tributaria
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonIngresar}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${botonConsultaTributaria}    botonConsultaTributaria
    Validar y completar campo    ${asuntoConsultaTributaria}  Asunto test1    asuntoConsultaTributaria
    Wait Until Element Is Visible    ${botonGuardarBorrador}    timeout=10s
    Validar y completar campo    ${detalleConsultaTributaria}  Descripcion test1  detalleConsultaTributaria
    Validar y completar campo    ${contenidoConsultaTributaria}  Contenido test1  contenidoConsultaTributaria
    Subir Documento Correctamente    ${FILE3}    DNI del Solicitante    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Indicacion del numero de proceso creado
    [Documentation]    Numero del proceso creado: ${tramite}
    Log To Console    Comentario del proceso

#-------------MESA DE ENTRADA VIRTUAL----------------------

Test 1 - Consulta Tributaria MesaEntrada verificar SubTitulo [operador mesa] Paso 1
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Test 1 - Consulta Tributaria MesaEntrada Verificar NumeroTramite [operador mesa] Paso 2
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 1 - Consulta Tributaria MesaEntrada Verificar Fecha de Creacion [operador mesa] Paso 3
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Sleep  2s
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 1 - Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento [operador mesa] Paso 4
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 1 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Archivo [operador mesa] Paso 4.5
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el adjunto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    //div[@class='grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4']    DNI del Solicitante

Test 1 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto [operador mesa] Paso 5
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 1 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle [operador mesa] Paso 6
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 1 - Consulta Tributaria MesaEntrada Verificar Estado [operador mesa] Paso 7
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Pendiente

Test 1 - Consulta Tributaria MesaEntrada Verificar Datos Ciudadano [operador mesa] Paso 8
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 1 - Consulta Tributaria MesaEntrada Verificar Asignacion [operador mesa] Paso 9
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Mesa de Entrada Virtual

Test 1 - Se selecciona la opcion "Enviar a direccion" [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para continuar con el proceso, enviando el tramite a Direccion de informatica
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${enviarDireccion}    enviarADireccion
    Verificar y presionar ítem en lista combobox  ${areaDestino}  Dirección de Informática
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Dirección de Informática
    Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 2 - Consulta Tributaria MesaEntrada verificar SubTitulo [operador mesa] Paso 1
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Test 2 - Consulta Tributaria MesaEntrada Verificar NumeroTramite [operador mesa] Paso 2
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 2 - Consulta Tributaria MesaEntrada Verificar Fecha de Creacion [operador mesa] Paso 3
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Sleep  2s
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 2 - Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento [operador mesa] Paso 4
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 2 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Archivo [operador mesa] Paso 4.5
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el adjunto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    //div[@class='grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4']    DNI del Solicitante

Test 2 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto [operador mesa] Paso 5
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 2 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle [operador mesa] Paso 6
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 2 - Consulta Tributaria MesaEntrada Verificar Estado [operador mesa] Paso 7
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Asignado

Test 2 - Consulta Tributaria MesaEntrada Verificar Datos Ciudadano [operador mesa] Paso 8
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 2 - Consulta Tributaria MesaEntrada Verificar Asignacion [operador mesa] Paso 9
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Dirección de Informática

Test 2 - Se selecciona la opcion "Derivar" [Direccion Informatica]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Direccion informatica y utiliza la opcion "Derivar" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonDerivar}    boton derivar
    #Verificar y presionar ítem en lista combobox  ${areaDestino}  Planificación y Control de Sistemas Informáticos
    #Verificar Texto Actualizado    ${textoEjecutarAccion}    Planificación y Control de Sistemas Informáticos
    #Validar y completar campo    ${NroExpediente}    123456/1234    NroExpediente
    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Planificación y Control de Sistemas Informáticos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 3 - Consulta Tributaria MesaEntrada verificar SubTitulo [operador mesa] Paso 1
    [Documentation]    Desde la Mesa de Entrada abre la Consulta Tributaria anteriormente creada y comprueba que el "subtitulo" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de    ${subtituloConsultaTributaria}    El titulo no se encontro visible

Test 3 - Consulta Tributaria MesaEntrada Verificar NumeroTramite [operador mesa] Paso 2
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Numero de Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia parcial    ${tramite}    El Numero Tramite no se encontro visible

Test 3 - Consulta Tributaria MesaEntrada Verificar Fecha de Creacion [operador mesa] Paso 3
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Creacion" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Sleep  2s
    ${FECHA_COMPLETA}=    Get Text    ${fechaCreacion}
    Comparar Fecha Creacion    ${FECHA_COMPLETA}

Test 3 - Consulta Tributaria MesaEntrada Verificar Numero de Seguimiento [operador mesa] Paso 4
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Fecha de Seguimiento" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar Numero de Seguimiento    ${tramite}

Test 3 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Archivo [operador mesa] Paso 4.5
    [Documentation]    Verifica que el ciudadano pueda ver correctamente los Datos Presentados de la consulta tributaria, en este caso especificamente el adjunto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    //div[@class='grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-4']    DNI del Solicitante

Test 3 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Asunto [operador mesa] Paso 5
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Asunto"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Asunto    Asunto test1

Test 3 - Consulta Tributaria MesaEntrada Verificar DatosPresentados Detalle [operador mesa] Paso 6
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que en los Datos Presentados sea visible y correcto el "Detalle"
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Detalle    Descripcion test1

Test 3 - Consulta Tributaria MesaEntrada Verificar Estado [operador mesa] Paso 7
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que el "Estado del Tramite" sea visible y correcto
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Estado Del Tramite    Asignado

Test 3 - Consulta Tributaria MesaEntrada Verificar Datos Ciudadano [operador mesa] Paso 8
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos del ciudadano sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Datos Identidad    ${nombreCiudadano}    ${emailCiudadano}    ${cuitCiudadano}

Test 3 - Consulta Tributaria MesaEntrada Verificar Asignacion [operador mesa] Paso 9
    [Documentation]    Desde la Mesa de Entrada, abre la Consulta Tributaria y comprueba que los datos de "Asignacion" sean visibles y correctos
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    Abrir Navegador en modo incognito    ${pagePersonal}
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar Area Asignada    Planificación y Control de Sistemas Informáticos

