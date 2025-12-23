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

Test Setup    Abrir Navegador en modo incognito
Test Teardown    Cerrar navegador

Suite Setup    Inicializar Contador

*** Test Cases ***
#------------------------------- SUBIR DOCUMENTACION CON CAMPOS INCOMPLETOS -----------------------------------

Test X - Nota formal: agregar documentacion complementaria - intentar subir sin observacion [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se pueda crear la documentacion sin añadir una observacion
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Element Should Be Disabled    ${botonSubirDocumento}

Test X - Nota formal: agregar documentacion complementaria - intentar subir sin archivo [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se pueda crear la documentacion sin añadir un archivo
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}

#---------------------- NO SE SUBE LA DOCUMENTACION PORQUE SE PRESIONA EL BOTON CANCELAR -----------------------

Test X - Nota formal: agregar documentacion complementaria - intentar que no se suba debido a que se presiona el boton cancelar [operador mesa]
    [Documentation]    Entra como operador mesa entrada y se verifica que no se suba la documentacion complementaria debido a que se presiono le boton cancelar en vez de subir
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${botonCancelar}   boton subir documento
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

#------------------------- SE SUBE Y ELIMINA (ADEMÁS DEL CANCELAR) UNA DOC. COMPLEMENTARIA ---------------------
#Subir y borrar un archivo
Test X - Nota formal: se agrega documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: no se elimina la documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador mesa entrada y cuando se quiere eliminar la documentacion complementaria agregada, se presiona el boton cancelar
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${botonCancelar}   boton cancelar
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

Test X - Nota formal: se elimina la documentacion complementaria - [operador mesa]
    [Documentation]    Entra como operador mesa entrada y elimina la documentacion complementaria agregada
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonEliminarDocumentacion}   boton eliminar
    Validar y hacer clic en el boton    ${EliminarDocumento}   boton eliminar documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha eliminado correctamente.

Test X - Nota formal: verificacion de documentacion complementaria eliminada - archivo: doc [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

#--------------------------  SE PRUEBA LA SUBIDA DE DIFERENTES TIPOS DE ARCHIVOS ---------------------------------
#////////Doc
Test X - Nota formal: se agrega documentacion complementaria - archivo: doc [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEdocAgus}
    Validar y completar campo    ${campoDescripcion}    archivo doc    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: verificacion de documentacion complementaria - archivo: doc [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${docAgus}

#--------------------------------------------------------------------------------------------------------
#////////Excel
Test X - Nota formal: se agrega documentacion complementaria - archivo incorrecto: excel [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria de un archivo que no seria valido
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEexcAgus}
    Validar y completar campo    ${campoDescripcion}    archivo excel    descripcion
    Element Should Be Disabled    ${botonSubirDocumento}
    #Condicion para los proximos test
    #[Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: verificacion de documentacion complementaria - archivo: excel [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar NO presencia de... con...    ${espacioDeArchivosDocCom}    ${excAgus}

#------------------------------------------------------------------------------------------------------
#////////Png
Test X - Nota formal: se agrega documentacion complementaria - archivo: png [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEpngAgus}
    Validar y completar campo    ${campoDescripcion}    archivo png    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: verificacion de documentacion complementaria - archivo: png [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pngAgus}

#-----------------------------------------------------------------------------------------------
#////////Jpeg
Test X - Nota formal: se agrega documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEjpegAgus}
    Validar y completar campo    ${campoDescripcion}    archivo jpeg    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

Test X - Nota formal: verificacion de documentacion complementaria - archivo: jpeg [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${jpegAgus}

#--------------------------------------------------------------------------------------------------------
#////////Pdf
Test X - Nota formal: se agrega documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
   # Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque fallo un test importante
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Validar y hacer clic en el boton    ${botonSubir}    boton subir
    Choose file    ${inputFileUpload}    ${FILEpdfAgus}
    Validar y completar campo    ${campoDescripcion}    archivo pdf    descripcion
    Validar y hacer clic en el boton    ${botonSubirDocumento}   boton subir documento
    Verificar Y Esperar Visibilidad De Elemento    El documento se ha agregado correctamente al trámite.
    #Condicion para los proximos test
    [Teardown]    Set Suite Variable    ${TEST_OK}    ${TEST_STATUS}

#cambiar porque no funciona
Test X - Nota formal: verificacion de documentacion complementaria - archivo: pdf [operador mesa]
    [Documentation]    Entra como operador mesa entrada y agrega documentacion complementaria
    Asignar Tag Numerado
    #Si fallo lo anterior
    Run Keyword If   '${TEST_OK}'!='PASS'    Skip   Se omite el test porque no se se subio la documentacion complementaria en el test anterior
    #Sino corre
    Validar y hacer clic en la seccion  ${pestañaPersonal}  pestañaPersonal
    Iniciar sesion  ${userOperadorMesa}  ${pass}  ${campoMail}  ${campoPass}  ${botonEnviar2}
    Verificar Y Esperar Visibilidad De Elemento    Reportes y Estadísticas
    Validar y hacer clic en el boton    ${botonBandejaEntrada}    botonBandejaEntrada
    Abrir Tramite Por Numero    ${tramite}
    Verificar presencia de... con...    ${espacioDeArchivosDocCom}    ${pdfAgus}


*** Keywords ***
Crear tramite para X tipo
    [Arguments]    ${tipoTramite}    ${campoAsunto}    ${campoDetalle}    ${campoContenido}
    Iniciar sesion  ${userCiudadano3}  ${passCiudadano}  ${campoCuit}  ${campoClaveFiscal}  ${botonEnviar}
    Verificar Y Esperar Visibilidad De Elemento por localizador    ${circuloUsuario}
    Validar y hacer clic en el boton    ${botonComenzarAhora}    botonComenzarAhora
    Validar y hacer clic en el boton    ${tipoTramite}    ${tipoTramite}
    Validar y completar campo    ${campoAsunto}  Asunto test2    asunto
    Validar y completar campo    ${campoDetalle}  Descripcion test2  detalle
    Validar y completar campo    ${campoContenido}  Contenido test2  contenido
    Verificar y presionar ítem en lista index    ${select}    1
    Choose file    ${InputTypeFile}    ${FILEAgus}
    Validar y hacer clic en el boton    ${botonAniadir}    botonAniadir
    Validar y hacer clic en el boton    ${botonEnviarSolicitud}    botonEnviarSolicitud
    Verificar Y Esperar Visibilidad De Elemento    ha sido registrado y está siendo procesado
