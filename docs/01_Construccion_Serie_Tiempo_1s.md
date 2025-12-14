# 01_Construccion_Serie_Tiempo_1s

🎯 **Propósito Principal**

Este notebook replica el proceso de construcción de serie temporal, pero usando una **frecuencia de 1 segundo**. Su finalidad es **explorar** cómo se ve la señal al aumentar la resolución temporal y evaluar si aporta valor para detectar cambios abruptos asociados a un ataque.

En el contexto de CICIDS2017 (basado en registros de flujos), esta versión suele usarse como **experimento metodológico**: permite observar si el resampleo fino produce una serie interpretable o si introduce distorsión/fragmentación por la naturaleza del dataset.

📋 **Requisitos Previos**

Notebooks que debes ejecutar antes:

- `00_Cargar_dataset.ipynb` (opcional si aquí se lee el CSV)

Datos necesarios:

- `../data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv`

Archivos generados:

- `../data/processed/dataset_limpio.csv`
- `../data/processed/serie_temporal.csv` *(ojo: en tu caso el notebook genera salida asociada a “por segundo”)*
- `../results/01_paquetes_por_segundo.png`

Herramientas requeridas:

- Pandas / NumPy / Matplotlib / re / datetime

🚀 **Cómo Usar Este Notebook**

Pasos Básicos:

1. Ejecuta todas las celdas en orden
2. Verifica que la serie resultante tenga suficiente densidad (no demasiados ceros/gaps)
3. Usa el gráfico de control para evaluar si la señal es interpretable

⏱️ **Tiempos Estimados**

- Ejecución completa: **5–12 minutos**
- Procesamiento de datos: **4–10 minutos**
- Generación de resultados: **< 1 minuto**

🔍 **Explicación por Secciones**

*(Mismas secciones que la versión por minuto, pero cambiando la agregación temporal.)*

- Sección 5 (Construcción de serie) cambia a **resample por 1 segundo**
- Sección 8 exporta `01_paquetes_por_segundo.png`

📊 **Resultados y Productos**

Archivos Generados:

- `../results/01_paquetes_por_segundo.png` → validación visual 1s

Visualizaciones:

- Gráfico por segundo → útil para evaluar “granularidad vs ruido”

🔗 **Conexiones con Otros Notebooks**

- No se recomienda como entrada del flujo principal salvo que TODO el pipeline se ajuste a esta frecuencia.

⚠️ **Posibles Problemas y Soluciones**

Error común: serie “vacía” o con muchos ceros

- Causa: el dataset no tiene eventos densos por segundo en forma uniforme
- Solución: evaluar si la frecuencia es metodológicamente conveniente o usar 1 minuto