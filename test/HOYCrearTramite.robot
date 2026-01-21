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
${userDireccionAdministracion}    operador01
${userDireccionAuditoriaPlanificacion}    operador02
${userDireccionCoordinacionPoliticasFiscales}    operador03
${userDireccionFiscalizacion}    operador04
${userDireccionInformatica}    operador05
${userDireccionRecaudaciones}    operador06
${userDireccionJuridicaTecnica}    operador07
${userDespachoDireccionGeneral}    operador10
${userDespachoSubdireccionGeneral}    operador11
${userPlanificacionYControlDeSistemasInformaticos}    operador26


${areaDestino}    //button[@role='combobox']

#${textoEjecutarAccion}    //p[contains(@class,'text-muted-foreground')]
${textoEjecutarAccion}    //p[@id='radix-_r_k9_']

${a}  Tu trámite TRAM-0105/2026 ha sido registrado y está siendo procesado. Recibirás actualizaciones por email.

${FILE3}    D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
${docLean}    ADJUNTO.pdf

&{TRAMITE_ConsultaTributaria}    boton=${botonConsultaTributaria}    asunto=${asuntoConsultaTributaria}    detalle=${detalleConsultaTributaria}    cont=${contenidoConsultaTributaria}    lista=DNI del Solicitante
&{TRAMITE_ConsultaVinculante}    boton=${botonConsultaVinculante}    asunto=${asuntoConsultaVinculante}    detalle=${detalleConsultaVinculante}    cont=${contenidoConsultaVinculante}    lista=DNI del Solicitante
&{TRAMITE_ExencionImpuestoInmobiliarioBasico}    boton=${botonExencionImpuestoInmobiliarioBasico}    asunto=${asuntoExencionImpuestoIB}    detalle=${detalleExencionImpuestoIB}    cont=${contenidoExencionImpuestoIB}    lista=DNI del Solicitante
&{TRAMITE_ExenciónImpuestoDeSellos}    boton=${botonExenciónImpuestoDeSellos}    asunto=${asuntoExenciónImpuestoDeSellos}    detalle=${detalleExenciónImpuestoDeSellos}    cont=${contenidoExenciónImpuestoDeSellos}    lista=Copia de DNI del Solicitante
&{TRAMITE_ExencionImpuestoProvincialAutomotor}    boton=${botonExencionImpuestoProvincialAutomotor}    asunto=${asuntoExencionImpuestoProvincialAutomotor}    detalle=${detalleExencionImpuestoProvincialAutomotor}    cont=${contenidoExencionImpuestoProvincialAutomotor}    lista=Copia de DNI del Solicitante
&{TRAMITE_ExencionImpuestoSobreLosIngresosBrutos}    boton=${botonExencionImpuestoSobreLosIngresosBrutos}    asunto=${asuntoExencionImpuestoSobreLosIngresosBrutos}    detalle=${detalleExencionImpuestoSobreLosIngresosBrutos}    cont=${contenidoExencionImpuestoSobreLosIngresosBrutos}    lista=Presentación de Declaración jurada
&{TRAMITE_NotaFormal}    boton=${botonNotaFormal}    asunto=${asuntoNotaFormal}    detalle=${detalleNotaFormal}    cont=${contenidoNotaFormal}    lista=DNI del Solicitante

*** Test Cases ***
#Test 22: Aprobado desde Departamento de informatica
#Test 23: Rechazado desde Departamento de informatica
#Test 24: Solicita datos adicionales en operador, direccion y departamento + rechaza

Test 22 - Crea un nuevo tramite [ciudadano] Paso 1
    Abrir Navegador en modo incognito    ${pageCiudadano}
    [Documentation]    Crear un nuevo tramite
    Asignar Tag Numerado
    Iniciar sesion  ${userCiudadano2}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  //button[normalize-space()='Ingresar']
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora

    Crea un nuevo tramite [ciudadano]    ${TRAMITE_NOTA}

    ${tramite}=    Obtener Numero De Tramite
    Set Suite Variable    ${tramite}
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST STATUS}


*** Keywords ***
Crea un nuevo tramite [ciudadano]
    [Arguments]    ${datos}
    # Uso de datos dinámicos del diccionario
    Validar y hacer clic en el boton    ${datos}[boton]     botonTramite
    Validar y completar campo    ${datos}[asunto]    Asunto    asunto
    Validar y completar campo    ${datos}[detalle]   Descripcion  detalle
    Validar y completar campo    ${datos}[cont]      Contenido  contenido

    Subir Documento Correctamente    ${FILE3}    ${datos}[lista]    ${docLean}
    Wait Until Page Does Not Contain Element    xpath=//*[contains(@class,'spinner')]    timeout=10s

    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado