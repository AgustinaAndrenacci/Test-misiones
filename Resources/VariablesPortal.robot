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