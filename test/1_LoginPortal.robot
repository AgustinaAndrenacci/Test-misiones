***Settings***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    BuiltIn
Library    DateTime
Library    OperatingSystem
Library    C:/Users/apoke/Desktop/LPA/Portal de Proveedores/Resources/EmbedScreenshotLibrary.py

Resource        C:/Users/apoke/Desktop/LPA/Portal de Proveedores/Resources/KeywordsPortal.robot
Resource        C:/Users/apoke/Desktop/LPA/Portal de Proveedores/Resources/KeywordsMio.robot
Resource        C:/Users/apoke/Desktop/LPA/Portal de Proveedores/Resources/VariablesPortal.robot

Test Setup     Abrir navegador
Test Teardown  Cerrar navegador

***Test Cases***
Login por Google
    [Documentation]    Iniciar sesion con Google
    [tags]    test_01
    Sleep  2s
    Mensaje error

Login Correcto
    [Documentation]    Iniciar sesion con datos correctos
    [tags]    test_02
    Iniciar sesion  ${user}  ${pass}
    Verificar presencia de  ${seccionDashboard}    No se pudo iniciar sesion

Login fallido
    [Documentation]    Inicia sesion con datos falsos para confirmar que no te permite iniciar sesión sin las credenciales correspondientes
    [tags]    test_03
    Iniciar sesion  ${userFake}  ${passFake}
    Verificar alerta  El usuario no existe  ACCEPT

Login sin username
    [Documentation]    Confirma que no se permite Iniciar sesion sin completar el campo username
    [tags]    test_04
    Iniciar sesion  ${campoVacio}  ${pass}
    Verificar alerta  El usuario es obligatorio  ACCEPT

Login sin password
    [Documentation]    Confirma que no se permite Iniciar sesion sin completar el campo password
    [tags]    test_05
    Iniciar sesion  ${user}  ${campoVacio}
    Verificar alerta  La contraseña es obligatoria  ACCEPT

Login Sin Usuario Ni Contrasenia
    [Documentation]    Confirma que no se permite Iniciar sesion sin completar ningun campo
    [tags]    test_06
    Iniciar sesion  ${campoVacio}  ${campoVacio}
    Verificar Alerta    El usuario y contraseña son obligatorios  ACCEPT
