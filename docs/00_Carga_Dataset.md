# 00_Carga_Dataset

🎯 **Propósito Principal**

Este notebook realiza la **carga inicial** del dataset de CICIDS2017 (captura Friday-Afternoon-DDoS) desde un archivo CSV y verifica que el contenido sea accesible para el resto del pipeline. Su función es asegurar que el archivo exista, que se lea sin errores y que el dataset quede disponible como una tabla (DataFrame) para los pasos posteriores.

En la práctica, este notebook actúa como un **punto de control**: si aquí falla (por ruta incorrecta, archivo dañado o delimitadores), todo el flujo posterior quedará inválido. Por eso su valor es garantizar que el proyecto parte desde un insumo consistente.

📋 **Requisitos Previos**

Notebooks que debes ejecutar antes:

- Ninguno

Datos necesarios:

- Archivo: `../data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv` → CSV original de CICIDS2017 (Friday Afternoon DDoS)

Configuración:

- No requiere archivos de configuración externos

Herramientas requeridas:

- **Python**: ejecutar el entorno
- **Pandas**: lectura del CSV y visualización rápida
- **OS**: validación de rutas/directorios (si se usa)

🚀 **Cómo Usar Este Notebook**

Pasos Básicos:

1. **Preparación:** confirma que el archivo CSV exista en `../data/raw/`
2. **Ejecución:** corre todas las celdas en orden
3. **Verificación:** deberías ver filas iniciales del dataset (ej. con `head()`)
4. **Siguientes pasos:** continúa con `01_Construccion_Serie_Tiempo.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **< 1 minuto**
- Procesamiento de datos: **No aplica**
- Generación de resultados: **No aplica**

🔍 **Explicación por Secciones**

*(Este notebook es corto y no está dividido por títulos internos; se interpreta como dos bloques lógicos.)*

**Sección 1: Importación de librerías**

- Objetivo: preparar el entorno mínimo de carga
- Proceso: importar Pandas (y utilidades si aplica)
- Salida esperada: entorno sin errores

**Sección 2: Carga y visualización rápida del dataset**

- Objetivo: confirmar lectura correcta del CSV
- Proceso: leer el archivo y mostrar una muestra
- Salida esperada: tabla cargada con columnas esperadas
- Notas importantes: si se ve “todo en una sola columna”, el separador es incorrecto

📊 **Resultados y Productos**

Archivos Generados:

- Ninguno (solo carga)

Visualizaciones:

- Ninguna (solo vista previa de tabla)

Métricas Clave:

- No aplica en este notebook

🔗 **Conexiones con Otros Notebooks**

Dependencias (Entradas desde):

- Ninguna

Salidas hacia (Alimenta a):

- `01_Construccion_Serie_Tiempo.ipynb` → aporta el dataset base para limpieza y resampleo

⚠️ **Posibles Problemas y Soluciones**

Error Común 1: `FileNotFoundError`

- Causa probable: ruta incorrecta o archivo no está en `../data/raw/`
- Solución: validar el nombre exacto del archivo y la estructura de carpetas

Error Común 2: CSV queda “mal leído” (una sola columna)

- Causa probable: separador distinto (`,` vs `;`)
- Solución: indicar `sep=','` (o el separador correcto) al leer

💡 **Consejos Prácticos**

Para optimizar el uso:

- Mantén este notebook como “smoke test”: si carga bien aquí, el resto es reproducible

Personalización posible:

- Puedes agregar un conteo de filas/columnas como verificación rápida del insumo

❓ **Preguntas Frecuentes**

P: ¿Necesito entender todo el dataset aquí?

R: No. Aquí solo importa que **cargue bien** y quede listo para transformaciones.

P: ¿Cómo sé que funcionó?

R: Ves un DataFrame con múltiples columnas coherentes y filas sin errores.

📈 **Aplicaciones Prácticas**

- Validación de insumos antes de análisis reproducible

🔄 **Flujo de Trabajo Recomendado**

Ejecutar en este orden:

- `00_Cargar_dataset.ipynb` → `01_Construccion_Serie_Tiempo.ipynb`

📞 **Soporte y Referencias**

- Dataset CICIDS2017 (Friday-Afternoon-DDoS)
    
    Última actualización: 2025-12-13