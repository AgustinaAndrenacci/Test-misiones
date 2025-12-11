***Settings***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn

***Variables***
#Variable Para Tags Automatica-------------------------------------------------------------------
${COUNTER}    0

#Principal --------------------------------------------------------------------------------------
${browser}  Chrome
${page}  https://tsgqa.digitrack.com.ar/auth/signin

#Usuarios --------------------------------------------------------------------------------------
${userCiudadano}  20401234560
${userCiudadano3}  30709021296
${userCiudadano2}  30709021296
${passCiudadano}  1234

${userAdmin}  admin
${passAdmin}  Lpa23291

${userOperadorMesa}  operador.mesa
${userRespArea}  resp.area
${userSecretaria}  secretaria
${userGestion}  gestion
${pass}  admin123

${userFakeCorto}  asd
${passFake}  asd
${userFake}  123456789
${userFake7}  1234567
${userFake12}  123456789101112

#Pagina inicio-----------------------------------------------------------------------------------
#Cerrar sesion///////////////////////////////////////////////
${circuloUsuario}  css:.rounded-full
${cerrarSesion}  //button[normalize-space()='Cerrar Sesión']
${tituloPagina1}    //h1[normalize-space()='Portal del Ciudadano']
${tituloPagina2}    //h1[normalize-space()='Portal de Administrador']

#Pagina log-----------------------------------------------------------------------------------
${loginFrase}    //h3[normalize-space()='Iniciar Sesión']
${campoCuit}    //input[@id='cuit']
${campoClaveFiscal}    //input[@id='fiscal-password']
${campoMail}    //input[@id='identifier']
${campoPass}    //input[@id='local-password']
${botonEnviar}    //button[normalize-space()='Acceso Ciudadanos']
${botonEnviar2}    //button[normalize-space()='Acceso Personal']
${leyendaIniciarSesion}    //div[@role='alert']
${pestañaPersonal}    //button[text()='Personal']

#Nuevo-----------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------

#-------------------------VARIABLES GLOBALES ADMINISTRACION------------------------------
#----------------------------------------------------------------------------------------

${botonBandejaEntrada}    //span[@class='group-data-[collapsible=icon]:hidden'][normalize-space()='Bandeja de Entrada']
${abrirPrimerTramite}    //tbody/tr[1]/td[1]
${abrirPrimerTramiteAgus}    //tbody/tr[1]/td[1]//a

${agregarNota}    //h4[normalize-space()='Agregar Nota']
${campoComentario}    //textarea[@id='action-notes']

${botonConfirmar}    //button[normalize-space()='Confirmar']
${botonCancelar}    //button[normalize-space()='Cancelar']
${botonActualizarBorrador}    //button[normalize-space()='Actualizar Borrador']

${botonSolicitarDatosAdicionales}    //h4[normalize-space()='Solicitar Datos Adicionales']
${botonNoCorresponde}    //h4[normalize-space()='No Corresponde']
${enviarSecretaria}    //h4[normalize-space()='Enviar a Secretaria']
${paraResolver}    //h4[normalize-space()='Para Resolver']
${botonAprobar}    //h4[normalize-space()='Aprobar']
${botonRechazar}    //h4[normalize-space()='Rechazar']
${informarContribuyente}    //h4[normalize-space()='Informar al Contribuyente']
${botonAgregarNota}    //button[normalize-space()='Agregar Nota']

${subtituloConsultaTributaria}    //p[@class='text-muted-foreground']
${fechaCreacion}    //label[normalize-space(.)='Fecha de Creación']/following-sibling::p

${botonSubir}    //button[normalize-space()='Subir']
${campoDescripcion}    //textarea[@id='description']
${botonSubirDocumento}    //button[normalize-space()='Subir Documento']
${historialAdmin}    //h3[normalize-space()='Historial y Notas']

#------------------------------DATOS DEL CIUDADANO---------------------------------------
#----------------------------------------------------------------------------------------

${nombreCiudadano}    CREDISER AR
${emailCiudadano}    30709021296@tsg.gob.ar
${cuitCiudadano}    30709021296


#-------------------------VARIABLES GLOBALES TRAMITE-------------------------------------
#----------------------------------------------------------------------------------------

${botonComenzarAhora}    //a[normalize-space()='Comenzar ahora']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonGuardarBorrador}    //button[normalize-space()='Guardar Borrador']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${abrirTramiteGenerado}    //td[normalize-space()='${tramite}']/..//a[contains(text(),'Continuar Borrador')]
${botonEnviarTramite}    //button[normalize-space()='Enviar Trámite']

${botonVerDetalle}    //a[contains(., 'Ver Detalle')]
${botonExportarPDF}    //button[contains(., 'Exportar PDF')]

${tablaMisTramitesRecientes}    /html/body/div[2]/div/div[2]/main/div/div[3]/div/div[2]/div[2]/table
${tablaOperador}    /html/body/div[2]/div[2]/main/div/div[2]/div[2]/div
${tablaCiudadano}    //div[@class='p-6 pt-0']

${select}    //select

${InputTypeFile}    xpath=//input[@type='file']
${FILE}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/DniPrueba.png
${FILE2}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
${FILEpdf}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/ADJUNTO.pdf
${FILEdoc}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/A 2.docx
${FILEexc}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/A 3.xlsx
${FILEpng}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/unnamed.png
${FILEjpeg}      D:/Agus/OneDrive/Lap_Agus_Dell/Usuario/Escritorio/Lpa/Archivos - excel, word, img, pdf/A 4.jpeg
${pdf}      ADJUNTO.pdf
${doc}      A 2.docx
${exc}      A 3.xlsx
${png}      unnamed.png
${jpeg}      A 4.jpeg

${tituloConsultaTributaria}    //h1[normalize-space()='Consulta Tributaria']
${datosPresentados}    //h3[normalize-space()='Datos Presentados']

${botonMesaAyuda}    //button[normalize-space()='Contactar con Mesa de Ayuda']
${botonCancelarTramite}    //button[normalize-space()='Cancelar Trámite']
${botonVolver}    //button[normalize-space()='Volver']
${botonSiCancelar}    //button[normalize-space()='Sí, cancelar']

${historialCiudadano}    //h3[normalize-space()='Historial y Comunicaciones']

${DNIdelSolicitante}    (//td[@class='p-4 align-middle [&:has([role=checkbox])]:pr-0 font-medium'])[1]
${copiaDelInstrumentoQueOriginaElActo}    (//td[@class='p-4 align-middle [&:has([role=checkbox])]:pr-0 font-medium'])[2]
#--------------------------------CONSULTA TRIBUTARIA-------------------------------------
#----------------------------------------------------------------------------------------

${botonConsultaTributaria}    //h3[normalize-space()='Consulta Tributaria']
${asuntoConsultaTributaria}    //input[@id='cmhmi8ndf001xnowdryf6h1jo']
${detalleConsultaTributaria}    //textarea[@id='cmhmi8p0l001znowdbqy9xmv6']

#--------------------------------CONSULTA VINCULANTE-------------------------------------
#----------------------------------------------------------------------------------------

${botonConsultaVinculante}    //h3[normalize-space()='Consulta Vinculante']
${asuntoConsultaVinculante}    //input[@id='cmh99oteg0001n2v8y4enxt0t']
${detalleConsultaVinculante}    //textarea[@id='cmh99w1ak0003n2v87az51vqy']


#----------------------EXENCION DE IMPUESTO INMOBILIARIO BASICO--------------------------
#----------------------------------------------------------------------------------------

${botonExencionImpuestoInmobiliarioBasico}    //h3[normalize-space()='Exención de Impuesto Inmobiliario Básico']
${asuntoExencionImpuestoIB}    //input[@id='cmhy6sett000gnocln3chn0tn']
${detalleExencionImpuestoIB}    //textarea[@id='cmhy6t90w000inocljvj5tanb']

#-----------------------------------NOTA FORMAL------------------------------------------
#----------------------------------------------------------------------------------------
${botonNotaFormal}    //h3[normalize-space()='Nota Formal']
${asuntoNotaFormal}    //input[@id='cmgzsgypz000xn27sdc6h01o9']
${detalleNotaFormal}    //input[@id='cmi6sfs9600v6no9fds4l7cwv']
${contenidoNotaFormal}    //textarea[@id='cmgzsgyq00010n27ssk5kwr8x']
${idAsuntoNotaFormal}    id:cmgzsgypz000xn27sdc6h01o9
${idDetalleNotaFormal}    id:cmi6sfs9600v6no9fds4l7cwv
${idContenidoNotaFormal}    id:cmgzsgyq00010n27ssk5kwr8x


#-------------------EXENCION IMPUESTO SOBRE LOS INGRESOS BRUTOS---------------------------------

${botonExencionImpuestoSobreLosIngresosBrutos}    //h3[normalize-space()='Exención Impuesto sobre los Ingresos Brutos']
${asuntoExencionImpuestoSobreLosIngresosBrutos}    //input[@id='cmhy6z41g000snocl92vpu6kd']
${detalleExencionImpuestoSobreLosIngresosBrutos}    //textarea[@id='cmhy6z4ku000unocl3m3glkcl']
${contenidoImpuestoSobreLosIngresosBrutos}    //textarea[@id='cmist09qd00vbnonaxnvwh9yj']
${idAsuntoExencionImpuestoSobreLosIngresosBrutos}    id:cmhy6z41g000snocl92vpu6kd
${idDetalleExencionImpuestoSobreLosIngresosBrutos}    id:cmhy6z4ku000unocl3m3glkcl
${idContenidoImpuestoSobreLosIngresosBrutos}    id:cmist09qd00vbnonaxnvwh9yj

#-------------------Exención Impuesto Provincial Automotor---------------------------------------
${botonExencionImpuestoProvincialAutomotor}    //h3[normalize-space()='Exención Impuesto Provincial Automotor']
${asuntoExencionImpuestoProvincialAutomotor}    //input[@id='cmhy6wocq000mnoclzrsuf9db']
${detalleExencionImpuestoProvincialAutomotor}    //textarea[@id='cmhy6wqsv000onoclwrg7k7oo']
${contenidoExencionImpuestoProvincialAutomotor}    //textarea[@id='cmissydfl00v9nona59u5g8dg']
${idAsuntoExencionImpuestoProvincialAutomotor}    id:cmhy6wocq000mnoclzrsuf9db
${idDetalleExencionImpuestoProvincialAutomotor}    id:cmhy6wqsv000onoclwrg7k7oo
${idContenidoExencionImpuestoProvincialAutomotor}    id:cmissydfl00v9nona59u5g8dg

#--------------------------Exención Impuesto de Sellos--------------------------------------------
${botonExenciónImpuestoDeSellos}    //h3[normalize-space()='Exención Impuesto de Sellos']
${asuntoExenciónImpuestoDeSellos}    //input[@id='cmhy6g6hz000anoclh53yu9v1']
${detalleExenciónImpuestoDeSellos}    //textarea[@id='cmhy6k427000cnocl5n1cgb7e']
${contenidoExenciónImpuestoDeSellos}    //input[@id='cmisswslj00v7nona8nw5wo5f']
${idAsuntoExenciónImpuestoDeSellos}    id:cmhy6g6hz000anoclh53yu9v1
${idDetalleExenciónImpuestoDeSellos}    id:cmhy6k427000cnocl5n1cgb7e
${idContenidoExenciónImpuestoDeSellos}    id:cmisswslj00v7nona8nw5wo5f

${tramiteBorrador}    //tbody/tr[1]
${botonContinuarBorrador}    //a[normalize-space()='Continuar Borrador']
${botonEnviarTramite}    //button[normalize-space()='Enviar Trámite']
${mensajeSeleccioneUnaAccionParaContinuar}    //p[contains(text(),'Seleccione una acción para continuar con el proces')]
