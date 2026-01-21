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
#       Paso10:Documentacion Complementaria [operador mesa]
#       Paso11:Verificar Historial [operador mesa]
#       Paso 12:Enviar a Direccion [operador mesa]

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
#       Paso10:Documentacion Complementaria [Direccion]
#       Paso11:Verificar Historial [Direccion]
#       Paso 12:Enviar a Gestion [Direccion]

#Test 3: Consulta Tributaria [Gestion]
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

#Test 4: Consulta Tributaria [Operador Mesa]
#       Paso1:Verificar Estado Aprobado [operador mesa]
#       Paso2:Verificar Historial [operador mesa]
#       Paso3:Informar Al Contribuyente [operador mesa]

*** Variables ***
${tramite}    TRAM-0192/2026

*** Test Cases ***
Consulta Tributaria verificar Acciones Disponibles
    [Documentation]    Comprueba las acciones disponibles del ciudadano, buscando como resultado que no tenga ninguna accion disponible ya que acaba de crear la consulta tributaria
    Asignar Tag Numerado
    Abrir Navegador en modo incognito    ${pageCiudadano}
    Inicio sesion y verificacion de texto inicial - ciudadano  ${userCiudadano2}  ${passCiudadano}  ${circuloUsuario}
    ${botonVerDetalleTramite}=    Set Variable    //tr[td[normalize-space()='${tramite}']]//a[contains(., 'Ver Detalle')]
    Validar y hacer clic en el boton    ${botonVerDetalleTramite}    botonVerDetalle
    Validar Acciones Disponibles    True
