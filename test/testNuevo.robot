*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    Dialogs
Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Misiones/Resources/EmbedScreenshotLibrary.py
Library    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/QA/Misiones/Resources/InternetOculto.py

Resource        ../Resources/KeywordsPortal.robot
Resource        ../Resources/KeywordsMio.robot
Resource        ../Resources/VariablesPortal.robot

#Test Setup       Abrir Navegador en modo incognito
Test Teardown    Cerrar navegador

*** Variables ***
# Definimos la configuración de cada trámite en un diccionario
&{TRAMITE_NOTA}    boton=${botonExenciónImpuestoDeSellos}    asunto=${asuntoExenciónImpuestoDeSellos}    detalle=${detalleExenciónImpuestoDeSellos}    cont=${contenidoExenciónImpuestoDeSellos}
&{TRAMITE_GEN}     boton=${botonExencionImpuestoProvincialAutomotor}  asunto=${asuntoExencionImpuestoProvincialAutomotor}           detalle=${detalleExencionImpuestoProvincialAutomotor}           cont=${contenidoExencionImpuestoProvincialAutomotor}
&{TRAMITE_REC}     boton=${botonExencionImpuestoSobreLosIngresosBrutos}       asunto=${asuntoExencionImpuestoSobreLosIngresosBrutos}           detalle=${detalleExencionImpuestoSobreLosIngresosBrutos}           cont=${contenidoImpuestoSobreLosIngresosBrutos}

*** Test Cases ***
# --- BLOQUE TRÁMITE 1: NOTA FORMAL ---
T1 - Crear Borrador Nota Formal
    #Abre el navegador
    ${chrome_options_object}=    get chrome options
    #options: configuracion para abrir el navegador
    Open Browser    https://mde-digital.ngrok.io/auth/signin/extranet    ${browser}    options=${chrome_options_object}
    Maximize Browser Window

    #Sigue
    Crear Tramite Generico    ${TRAMITE_NOTA}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test 1 - Nota formal: verificar el estado del tramite (borrador) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Abre el navegador
    ${chrome_options_object}=    get chrome options
    #options: configuracion para abrir el navegador
    Open Browser    https://mde-digital.ngrok.io/auth/signin/extranet    ${browser}    options=${chrome_options_object}
    Maximize Browser Window

    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador

# --- BLOQUE TRÁMITE 2: SOLICITUD GENERAL ---
T2 - Crear Borrador Solicitud General
    #Abre el navegador
    ${chrome_options_object}=    get chrome options
    #options: configuracion para abrir el navegador
    Open Browser    https://mde-digital.ngrok.io/auth/signin/extranet    ${browser}    options=${chrome_options_object}
    Maximize Browser Window

    Crear Tramite Generico    ${TRAMITE_GEN}
    [Teardown]    Set Suite Variable    ${TEST_OK_2}    ${TEST_STATUS}

Test 1 - Nota formal: verificar el estado del tramite (borrador) [ciudadano] 4
    [Documentation]    Desde el usuario del ciudadano, se verifica el estado del tramite para saber en que parte del ciclo esta
    Asignar Tag Numerado
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Abre el navegador
    ${chrome_options_object}=    get chrome options
    #options: configuracion para abrir el navegador
    Open Browser    https://mde-digital.ngrok.io/auth/signin/extranet    ${browser}    options=${chrome_options_object}
    Maximize Browser Window

    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    #Validar Estado con numero de tramite    ${tablaMisTramitesRecientes}    3    ${tramite}    Borrador


# ... (Repetir para el trámite 3)

*** Keywords ***
Crear Tramite Generico
    [Arguments]    ${datos}
    Inicio sesion y verificacion de texto inicial - ciudadano    ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    
    # Aquí usamos las llaves del diccionario para que sea dinámico
    Validar y hacer clic en el boton    ${datos}[boton]     botonTramite
    Validar y completar campo    ${datos}[asunto]    Asunto test    asunto
    Validar y completar campo    ${datos}[detalle]   Descripcion test  detalle
    Validar y completar campo    ${datos}[cont]      Contenido test  contenido

    Sleep  2s
    Validar y hacer clic en el boton    //button[normalize-space()='Guardar Borrador']    botonGuardarBorrador
    Sleep  2s
    #Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}