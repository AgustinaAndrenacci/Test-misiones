    ***Settings***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn

***Variables***
#Principal --------------------------------------------------------------------------------------
${browser}  Chrome
${page}  https://tsgqa.digitrack.com.ar/auth/signin

#Usuarios --------------------------------------------------------------------------------------
${userCiudadano}  20401234560
${userCiudadano2}  20301112220
${passCiudadano}  123456

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

${agregarNota}    //h4[normalize-space()='Agregar Nota']
${campoComentario}    //textarea[@id='action-notes']

${botonConfirmar}    //button[normalize-space()='Confirmar']
${botonCancelar}    //button[normalize-space()='Cancelar']

${botonSolicitarDatosAdicionales}    //h4[normalize-space()='Solicitar Datos Adicionales']
${botonNoCorresponde}    //h4[normalize-space()='No Corresponde']
${enviarSecretaria}    //h4[normalize-space()='Enviar a Secretaria']
${paraResolver}    //h4[normalize-space()='Para Resolver']
${botonAprobar}    //h4[normalize-space()='Aprobar']
${botonRechazar}    //h4[normalize-space()='Rechazar']
${informarContribuyente}    //h4[normalize-space()='Informar al Contribuyente']

#-------------------------VARIABLES GLOBALES TRAMITE-------------------------------------
#----------------------------------------------------------------------------------------

${botonComenzarAhora}    //a[normalize-space()='Comenzar ahora']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${select}    //select

${InputTypeFile}    xpath=//input[@type='file']
${FILE}       C:/Users/apoke/Desktop/LPA/Misiones/Test-misiones/Resources/DniPrueba.png

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

