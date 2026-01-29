*** Settings ***
Documentation     Se realizan testeos creando tramites verificando si el flujo, los estados, los botones funciona de manera correcta.
...
...               Se realizaron las siguientes pruebas:
...
...               -Test 1: Se verifica el historial del ciudadano y de los operadores en un flujo del tramite donde desde el operador mesa se selecciona la opcion "Solicitar datos adicionales"
...
...               -Test 2: Se verifica el historial del ciudadano y de los operadores en un flujo del tramite donde desde el operador mesa se selecciona la opcion "No corresponde"
...
...               -Test 3: Se verifica el historial del ciudadano y de los operadores en un flujo del tramite donde se selecciona la opcion "Enviar a direccion", luego desde la direccion "Derivar" y termina rechazando el tramite
...

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


*** Variables ***
${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
#${FILE3}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/ubicacion.png
${docLean}    ADJUNTO.pdf
#${docLean}    ubicacion.png

*** Test Cases ***
Test 1 - Crea un nuevo tramite [ciudadano]
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se verifica el historial - creacion del tramite [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Asignado a "Mesa de Entrada Virtual"
    ...    operador=CREDISER AR*****(*****(DATOS PRUEBA TEST)
    ...    mensaje=Trámite iniciado correctamente

Test 1 - Se verifica el historial - creacion del tramite [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Asignado a "Mesa de Entrada Virtual"
    ...    operador=CREDISER AR*****(*****(DATOS PRUEBA TEST)
    ...    mensaje=Trámite iniciado correctamente

Test 1 - Se selecciona la opcion "Solicitar datos adicionales" [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa entrada para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSolicitarDatosAdicionales}    botonSolicitarDatosAdicionales
    Validar y completar campo    ${campoComentario}    Se solicitan datos adicionales    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Execute JavaScript    var input = document.querySelector('input[type="file"]'); if (input) { input.dispatchEvent(new Event("input", { bubbles: true })); input.dispatchEvent(new Event("change", { bubbles: true })); }
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se verifica el historial - solicitar datos adicionales [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Ciudadano"
    ...    operador=Operador Mesa Entrada
    ...    mensaje=Se solicitan datos adicionales

Test 1 - Se verifica el historial - solicitar datos adicionales [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Ciudadano"
    ...    operador=Operador Mesa Entrada
    ...    mensaje=Se solicitan datos adicionales

Test 1 - El usuario avanza con el tramite [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló Solicitar Datos Adicionales desde Operador mesa
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Se verifica si el usuario puede avanzar en el tramite debido a que le solicitaron datos adicionales
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y hacer clic en el boton    ${botonCancelar}    botonCancelar
    Validar y hacer clic en el boton    ${botonResponder}    botonResponder
    Validar y completar campo    ${campoComentario}    Respuesta del Ciudadano    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y hacer clic en el boton    ${botonEjecutarAccion}    botonEjecutarAccion
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se verifica el historial - solicitar datos adicionales respuesta[operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Ciudadano" a "Mesa de Entrada Virtual"
    ...    operador=CREDISER AR*****(*****(DATOS PRUEBA TEST)
    ...    mensaje=Respuesta del Ciudadano

Test 1 - Se verifica el historial - solicitar datos adicionales respuesta[ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Movido de "Ciudadano" a "Mesa de Entrada Virtual"
    ...    operador=CREDISER AR*****(*****(DATOS PRUEBA TEST)
    ...    mensaje=Respuesta del Ciudadano

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
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Se envia a la direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 1 - Se verifica el historial - enviar a direccion [DireccionInformatica]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como DireccionInformatica y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Dirección de Informática"
    ...    operador=Operador Mesa Entrada
    ...    mensaje=Se envia a la direccion

Test 1 - Se verifica el historial - enviar a direccion [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial NO aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar NO Registro En Historial ciudadano
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Dirección de Informática"
    ...    mensaje=Se envia a la direccion

Test 1 - Se selecciona la opcion "No corresponde" [direccion informatica]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como direccion informatica para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userDireccionInformatica}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    no corresponde el area    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se verifica el historial - no corresponde [userOperadorMesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como operador mesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Dirección de Informática" a "Mesa de Entrada Virtual"
    ...    operador=operador05
    ...    mensaje=no corresponde el area

Test 1 - Se verifica el historial - no corresponde [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial NO aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar NO Registro En Historial ciudadano
    ...    titulo=Movido de "Dirección de Informática" a "Mesa de Entrada Virtual"
    ...    mensaje=no corresponde el area

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
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se selecciona la opcion "Derivar" [Direccion Informatica]
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
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Se envia a Planificación y Control de Sistemas Informáticos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 1 - Se verifica el historial - derivar [PlanificacionYControlDeSistemasInformaticos]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como PlanificacionYControlDeSistemasInformaticos y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial depto
    ...    titulo=Movido de "Dirección de Informática" a "Planificación y Control de Sistemas Informáticos"
    ...    operador=operador26
    ...    mensaje=Se envia a Planificación y Control de Sistemas Informáticos

Test 1 - Se verifica el historial - derivar [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial NO aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar NO Registro En Historial ciudadano
    ...    titulo=Movido de "Dirección de Informática" a "Planificación y Control de Sistemas Informáticos"
    ...    mensaje=Se envia a Planificación y Control de Sistemas Informáticos

Test 1 - Se selecciona la opcion "Aprobar e informar al contribuyente" [Planificación y Control de Sistemas Informáticos]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento Planificación y Control de Sistemas Informáticos y utiliza la opcion "AprobarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonAprobarInformarAlContribuyente}    botonAprobar
    Validar y completar campo    ${campoComentario}    se aprueba    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 1 - Se verifica el historial - Aprobar e informar al contribuyente [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Planificación y Control de Sistemas Informáticos" a "Ciudadano"
    ...    operador=operador26
    ...    mensaje=se aprueba

Test 1 - Se verifica el historial - Aprobar e informar al contribuyente [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Movido de "Planificación y Control de Sistemas Informáticos" a "Ciudadano"
    ...    operador=operador26
    ...    mensaje=se aprueba

Test 2 - Crea un nuevo tramite [ciudadano]
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


Test 2 - Se selecciona la opcion "No corresponde" [direccion informatica]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque falló la creacion del tramite
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como direccion informatica para indicar la opcion "Solicitar Datos Adicionales"
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonMesaEntradaVirtual}    botonMesaEntradaVirtual

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonNoCorresponde}    botonNoCorresponde
    Validar y completar campo    ${campoComentario}    no corresponde aca    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 2 - Se verifica el historial - no corresponde [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Ciudadano"
    ...    operador=Operador Mesa Entrada
    ...    mensaje=no corresponde aca

Test 2 - Se verifica el historial - no corresponde [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Movido de "Mesa de Entrada Virtual" a "Ciudadano"
    ...    operador=Operador Mesa Entrada
    ...    mensaje=no corresponde aca

Test 3 - Crea un nuevo tramite [ciudadano]
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_ConsultaTributaria}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Se selecciona la opcion "Enviar a direccion" [operador mesa]
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
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Direccion    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Se selecciona la opcion "Derivar" [Direccion Informatica]
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
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y completar campo    ${campoComentario}    Enviar a Planificación y Control de Sistemas Informáticos    campoComentario
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Se selecciona la opcion "Rechazar e informar al contribuyente" [Planificación y Control de Sistemas Informáticos]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como Departamento Planificación y Control de Sistemas Informáticos y utiliza la opcion "botonRechazarInformarAlContribuyente" para continuar con el proceso
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userPlanificacionYControlDeSistemasInformaticos}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada

    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonRechazarInformarAlContribuyente}    botonRechazarInformarAlContribuyente
    Validar y completar campo    ${campoComentario}    se rechaza    campoComentario
    #    Choose file    ${botonSeleccionarArchivos}    ${FILE3}
    Choose file    ${InputFile}    ${FILE3}
    Validar y hacer clic en el boton    ${botonConfirmar}    botonConfirmar
    Verificar Y Esperar Visibilidad De Elemento    La acción se ha ejecutado correctamente.
    Close browser
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}

Test 3 - Se verifica el historial - Rechazar e informar al contribuyente [operador mesa]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pagePersonal}
    [Documentation]    Entra como userOperadorMesa y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - operador  ${userOperadorMesa}  ${pass}  Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonConsultaDeTramites}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${historialAdmin}    historialAdmin

    Verificar Registro En Historial operador
    ...    titulo=Movido de "Planificación y Control de Sistemas Informáticos" a "Ciudadano"
    ...    operador=operador26
    ...    mensaje=se rechaza

Test 3 - Se verifica el historial - rechazar e informar al contribuyente [ciudadano]
    Run Keyword If    '${TEST_OK}' != 'PASS'    Skip    Se omite el Test porque hubo un fallo en el flujo del tramite anteriormente
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Entra como ciudadano y verifica que en el historial aparezca la accion anterior realizada
    Asignar Tag Numerado
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar y hacer clic en el boton    ${historialCiudadano}    historialCiudadano

    Verificar Registro En Historial ciudadano
    ...    titulo=Movido de "Planificación y Control de Sistemas Informáticos" a "Ciudadano"
    ...    operador=operador26
    ...    mensaje=se rechaza

*** Keywords ***
Verificar Registro En Historial depto
    [Arguments]    ${titulo}    ${operador}    ${mensaje}
    [Documentation]    Busca un bloque de historial por título y verifica operador y comentario.

    # Este XPath busca el div contenedor que tiene el título específico
    ${bloque}=    Set Variable    //h4[contains(text(),'${titulo}')]

    Wait Until Element Is Visible    ${bloque}    timeout=15s

    # Verifica que dentro de ese bloque específico existan los otros textos
    Element Should Contain    //div[@class='flex flex-col flex-1']//main    ${operador}
    ${bloque}=    Set Variable    //p[normalize-space()='${titulo}']
    Wait Until Element Is Visible    ${bloque}    timeout=15s

    Log    Se verificó correctamente el registro: ${titulo}


Verificar Registro En Historial operador
    [Arguments]    ${titulo}    ${operador}    ${mensaje}
    [Documentation]    Busca un bloque de historial por título y verifica operador y comentario.

    # Este XPath busca el div contenedor que tiene el título específico
    ${bloque}=    Set Variable    //h4[contains(text(),'${titulo}')]

    Wait Until Element Is Visible    ${bloque}    timeout=15s

    # Verifica que dentro de ese bloque específico existan los otros textos
    Element Should Contain    //div[@class='flex flex-col flex-1']//main    ${operador}
    Element Should Contain    //div[@class='flex flex-col flex-1']//main    ${mensaje}
    Log    Se verificó correctamente el registro: ${titulo}


Verificar Registro En Historial ciudadano
    [Arguments]    ${titulo}    ${operador}    ${mensaje}
    [Documentation]    Busca un bloque de historial por título y verifica operador y comentario.

    # Este XPath busca el div contenedor que tiene el título específico
    ${bloque}=    Set Variable    //h4[contains(text(),'${titulo}')]

    Wait Until Element Is Visible    ${bloque}    timeout=15s

    # Verifica que dentro de ese bloque específico existan los otros textos
    Element Should Contain    //div[@class='flex flex-col flex-1 w-full']//main    ${operador}
    Element Should Contain    //div[@class='flex flex-col flex-1 w-full']//main    ${mensaje}
    Log    Se verificó correctamente el registro: ${titulo}

Verificar NO Registro En Historial ciudadano
    [Arguments]    ${titulo}    ${mensaje}
    [Documentation]    Busca un bloque de historial por título y verifica operador y comentario.

    # Este XPath busca el div contenedor que tiene el título específico
    ${bloque}=    Set Variable    //h4[contains(text(),'${titulo}')]

    Wait Until Element Is Not Visible    ${bloque}    timeout=15s

    # Verifica que dentro de ese bloque específico existan los otros textos
    Element Should Not Contain    //div[@class='flex flex-col flex-1 w-full']//main    ${mensaje}
    Log    Se verificó correctamente el registro: ${titulo}