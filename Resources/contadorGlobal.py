# Inicializa el contador en 0.
_contador_actual = 0

def get_contador_incremental():
    global _contador_actual
    _contador_actual += 1
    # Formateamos el número con ceros a la izquierda (por ejemplo, 001, 002)
    return f"TC-{_contador_actual:03d}"

# Eliminamos: CONTADOR_TC = get_contador_incremental()