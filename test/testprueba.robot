
*** Settings ***
Library    OperatingSystem
Library    C:/Users/apoke/Desktop/LPA/Ticket Processor/Resources/EmbedScreenshotLibrary.py

Resource        C:/Users/apoke/Desktop/LPA/Ticket Processor/Resources/Tickets
Resource        C:/Users/apoke/Desktop/LPA/Ticket Processor/Resources/Tickets/ImagenesExtra
Resource        C:/Users/apoke/Desktop/LPA/Ticket Processor/Resources/VariablesTicket.robot
Resource        C:/Users/apoke/Desktop/LPA/Portal de Proveedores/Resources/KeywordsMio.robot

Test Setup     Abrir navegador
Test Teardown  Cerrar navegador

***Test Cases***

prueba