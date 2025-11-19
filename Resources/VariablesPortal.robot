    ***Settings***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn

***Variables***
#LOGIN-----------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------

${browser}  Chrome
${page}  https://tsgqa.digitrack.com.ar/auth/signin
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
${campoVacio}
${botonLoginGoogle}    /html/body/div[1]/div[5]/div/div/div
#MENU------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
${tituloPagina}    //h1[normalize-space()='Portal del Ciudadano']
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

${botonComenzarAhora}    //a[normalize-space()='Comenzar ahora']
${botonConsultaTributaria}    //h3[normalize-space()='Consulta Tributaria']
${asuntoConsultaTributaria}    //input[@id='cmhmi8ndf001xnowdryf6h1jo']
${detalleConsultaTributaria}    //textarea[@id='cmhmi8p0l001znowdbqy9xmv6']
${botonAniadir}    //button[normalize-space()='Añadir']
${botonEnviarSolicitud}    //button[normalize-space()='Enviar Solicitud']

${botonConsultaVinculante}    //h3[normalize-space()='Consulta Vinculante']
${asuntoConsultaVinculante}    //input[@id='cmh99oteg0001n2v8y4enxt0t']
${detalleConsultaVinculante}    //textarea[@id='cmh99w1ak0003n2v87az51vqy']


${botonExencionImpuestoInmobiliarioBasico}    //h3[normalize-space()='Exención de Impuesto Inmobiliario Básico']
${asuntoExencionImpuestoIB}    //input[@id='cmhy6sett000gnocln3chn0tn']
${detalleExencionImpuestoIB}    //textarea[@id='cmhy6t90w000inocljvj5tanb']