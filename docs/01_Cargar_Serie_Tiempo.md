# 01_Cargar_Serie_Tiempo

🎯 **Propósito Principal**

Este notebook toma el dataset original y lo convierte en una **serie temporal agregada** a frecuencia de **1 minuto**, apta para análisis posterior. En términos simples: pasa de una tabla de flujos con timestamps a una “línea de tiempo” que permite observar cómo cambia el tráfico con el tiempo.

Su objetivo es dejar dos productos listos:

1. un **dataset limpio** (columnas normalizadas y timestamp convertido)
2. una **serie temporal** (por minuto) que será la base del EDA, modelado y detección por residuos.

📋 **Requisitos Previos**

Notebooks que debes ejecutar antes:

- `00_Cargar_dataset.ipynb` (si no cargas aquí, este notebook igualmente lee el CSV)

Datos necesarios:

- Archivo: `../data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv` → dataset original

Archivos que genera y luego se reutilizan:

- `../data/processed/dataset_limpio.csv` → dataset limpio
- `../data/processed/serie_temporal.csv` → serie temporal agregada por minuto
- `../results/01_paquetes_por_minuto.png` → gráfico de validación

Herramientas requeridas:

- **Pandas / NumPy**: limpieza, agregación y resampleo
- **Matplotlib**: gráfico de control
- **Regex (re)**: normalización de nombres de columnas
- **Datetime**: conversión de timestamp

🚀 **Cómo Usar Este Notebook**

Pasos Básicos:

1. **Preparación:** confirma rutas `../data/raw/`, `../data/processed/`, `../results/`
2. **Ejecución:** corre todas las celdas en orden (hay dependencias entre pasos)
3. **Verificación:**
    - el timestamp queda en formato datetime
    - la serie temporal no tiene saltos raros
    - se genera el gráfico `01_paquetes_por_minuto.png`
4. **Siguientes pasos:** continúa con `02_EDA.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **3–7 minutos** (depende de hardware)
- Procesamiento de datos: **2–5 minutos**
- Generación de resultados: **< 1 minuto**

🔍 **Explicación por Secciones**

**Sección 1: Carga del dataset**

- Objetivo: leer el CSV original y disponerlo como tabla
- Proceso: lectura con Pandas, revisión inicial de columnas
- Salida esperada: DataFrame `df_trafico` cargado

**Sección 2: Normalización de columnas**

- Objetivo: estandarizar nombres de columnas para evitar errores posteriores
- Proceso: función `limpiar_col()` (string, strip, lower, underscores)
- Salida esperada: columnas consistentes (ej. `timestamp`, `total_fwd_packets`, etc.)
- Nota: esta sección reduce errores por espacios y nombres inconsistentes

**Sección 3: Conversión de timestamp**

- Objetivo: convertir la columna `timestamp` a tipo fecha-hora
- Proceso: `pd.to_datetime()`
- Salida esperada: columna en datetime y tabla ordenable temporalmente
- Nota: si falla aquí, el resampleo posterior queda inválido

**Sección 4: Limpieza de datos (control básico)**

- Objetivo: dejar un dataset consistente para agregación
- Proceso: revisiones generales (nulos, tipos)
- Salida esperada: dataset listo para agrupar

**Sección 5: Construcción de la serie temporal**

- Objetivo: agregar el tráfico en intervalos de 1 minuto
- Proceso: indexar por timestamp + resample/agrupación + suma/conteo según métrica
- Salida esperada: archivo `serie_temporal.csv`

**Sección 6: Exportación**

- Objetivo: guardar productos intermedios para trazabilidad
- Proceso: exportar `dataset_limpio.csv` y `serie_temporal.csv`
- Salida esperada: archivos disponibles en `../data/processed/`

**Sección 7: Verificación de continuidad temporal**

- Objetivo: confirmar que la serie tenga un eje temporal consistente
- Proceso: validaciones simples (rangos, frecuencia, nulos)
- Salida esperada: serie lista para EDA

**Sección 8: Gráfico de validación**

- Objetivo: visualizar rápidamente el comportamiento por minuto
- Proceso: generar y guardar el gráfico
- Salida esperada: `../results/01_paquetes_por_minuto.png`

📊 **Resultados y Productos**

Archivos Generados:

- `../data/processed/dataset_limpio.csv` → usado como base limpia
- `../data/processed/serie_temporal.csv` → entrada directa del EDA y modelado
- `../results/01_paquetes_por_minuto.png` → control visual del resampleo

Visualizaciones:

- Gráfico: “Paquetes por minuto” → confirma forma general y rangos

Métricas Clave:

- Longitud de serie: depende del rango temporal cubierto en el dataset
- Frecuencia: 1 minuto (controlada)

🔗 **Conexiones con Otros Notebooks**

Dependencias (Entradas desde):

- `00_Cargar_dataset.ipynb` → si ya cargaste/validaste el CSV

Salidas hacia (Alimenta a):

- `02_EDA.ipynb` → usa `serie_temporal.csv`

⚠️ **Posibles Problemas y Soluciones**

Error Común 1: `KeyError: 'timestamp'`

- Causa probable: columna original con espacios o nombre distinto
- Solución: confirmar que la normalización de columnas corrió antes del paso 3

Error Común 2: Timestamp no convierte (`ValueError`)

- Causa probable: formato inconsistente en la columna
- Solución: inspeccionar valores “raros” y ajustar `to_datetime(..., errors='coerce')`

Error Común 3: No se crea el archivo en `../data/processed/`

- Causa probable: carpeta no existe
- Solución: crear carpeta o ajustar ruta

💡 **Consejos Prácticos**

Para optimizar el uso:

- No ejecutes celdas “salteadas”; la serie depende de pasos previos

Personalización posible:

- Puedes cambiar la métrica base (siempre documentando el motivo) sin romper el flujo, pero el resto del pipeline debe usar la misma columna objetivo

❓ **Preguntas Frecuentes**

P: ¿Cómo sé que la serie quedó bien?

R: Se genera el gráfico, el eje temporal es continuo y los valores no son “todo cero” ni “todo constante”.

P: ¿Necesito entender el resampleo?

R: Solo a nivel conceptual: estás agrupando tráfico por minuto para observar tendencias.

📈 **Aplicaciones Prácticas**

- Construcción de series temporales desde datos con timestamp
- Preparación reproducible de señales para análisis estadístico

🔄 **Flujo de Trabajo Recomendado**

```
00_Cargar_dataset → 01_Construccion_Serie_Tiempo → 02_EDA
```

📞 **Soporte y Referencias**

Última actualización: 2025-12-13