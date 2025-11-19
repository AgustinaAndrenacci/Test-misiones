# ConfigBrowser.py
import sys
from selenium.webdriver.chrome.options import Options

def get_chrome_options():
    """
    Crea y configura el objeto ChromeOptions con argumentos para 
    deshabilitar funciones de seguridad y gestión de contraseñas (incógnito).
    """
    
    # 1. Crear el objeto Options
    chrome_options = Options()

    # 2. Añadir argumentos de línea de comandos para evitar diálogos
    chrome_options.add_argument("--incognito")
    chrome_options.add_argument("--disable-infobars")
    chrome_options.add_argument("--disable-features=CredentialManagement")
    
    # Opcional pero recomendado: Deshabilitar el servicio de credenciales en las prefs
    prefs = {
        "credentials_enable_service": False,
        "password_manager_enabled": False,
    }
    chrome_options.add_experimental_option("prefs", prefs)

    # 3. La función devuelve el objeto configurado
    return chrome_options