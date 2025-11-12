from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn
import pyautogui
import base64
import os
from datetime import datetime
from PIL import Image

class EmbedScreenshotLibrary:
    @keyword
    def embed_clean_resized_base64(self, mensaje="Captura limpia redimensionada", width=1152, height=864):
        # Obtener carpeta de salida dinámica
        output_dir = BuiltIn().get_variable_value("${OUTPUT DIR}")
        if not output_dir:
            output_dir = os.getcwd()  # Fallback

        screen_width, screen_height = pyautogui.size()
        taskbar_height = 48  # Ajustado para Windows 11

        # Capturar región sin barra
        region = (0, 0, screen_width, screen_height - taskbar_height)
        screenshot = pyautogui.screenshot(region=region)

        # Redimensionar
        resized = screenshot.resize((width, height), Image.LANCZOS)

        # Guardar en carpeta de logs
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"screenshot_clean_resized_{timestamp}.png"
        filepath = os.path.join(output_dir, filename)
        resized.save(filepath)

        # Convertir a base64
        with open(filepath, "rb") as img_file:
            b64 = base64.b64encode(img_file.read()).decode("utf-8")

        # Generar HTML embebido
        html = f'<div><b>{mensaje}</b><br><img src="data:image/png;base64,{b64}"></div>'
        return html