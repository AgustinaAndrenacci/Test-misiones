# TagGenerator.py
class TagGenerator:
    ROBOT_LISTENER_API_VERSION = 3
    test_counter = 0

    def start_test(self, data, result):
        # Incrementar el contador por cada test
        self.test_counter += 1

        # Formatear el número con ceros a la izquierda (ej. 01, 02)
        tag_number = f"test_{self.test_counter:03d}"

        # Añadir la tag al caso de prueba actual
        result.tags.add(tag_number)

        print(f"DEBUG: Added tag '{tag_number}' to test '{data.name}'")