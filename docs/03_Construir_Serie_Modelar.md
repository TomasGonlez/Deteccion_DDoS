# 03_Construir_Serie_Modelar

🎯 **Propósito Principal**

Este notebook prepara la serie temporal en su forma “final” para el modelado. Aquí se delimita la **ventana benigna** (entrenamiento) y se construye un dataset que luego usarán ARIMA y SES.

También genera figuras específicas para respaldar decisiones (por ejemplo, delimitación de ventana y evidencia de comportamiento estadístico), dejando un archivo final listo para los notebooks de entrenamiento.

📋 **Requisitos Previos**

- `02_EDA.ipynb` (recomendado: ya define qué métrica se modela)
- `01_Construccion_Serie_Tiempo.ipynb`

Datos necesarios:

- `../data/processed/serie_temporal.csv` (entrada implícita del flujo)

Archivos Generados:

- `../data/processed/serie_preparada.csv`
- `../results/12_ventana_benigna_delimitacion.png`
- `../results/13_estacionariedad_ventana_trafico_benigno_PACF.png`

Herramientas requeridas:

- Pandas / NumPy
- Matplotlib
- Herramientas de análisis temporal (según implementación)

🚀 **Cómo Usar Este Notebook**

1. Ejecutar de arriba hacia abajo
2. Verificar que la ventana benigna esté correctamente definida
3. Confirmar exportación de `serie_preparada.csv`
4. Continuar con `04_Entrenar_ARIMA.ipynb` y `05_Entrenar_SES.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **3–8 minutos**
- Procesamiento: **2–6 minutos**
- Figuras: **< 2 minutos**

🔍 **Explicación por Secciones**

**Sección 1: Preparación final**

- Objetivo: consolidar la métrica objetivo y estructura temporal
- Salida: serie lista para segmentar

**Sección 2–3: Delimitación ventana benigna**

- Objetivo: separar entrenamiento (pre-ataque) del resto
- Salida: figura `12_...png` como evidencia de segmentación

**Sección 4: Construcción de la serie preparada**

- Objetivo: crear `serie_preparada.csv` como estándar de entrada para modelos
- Salida: archivo exportado en `../data/processed/`

📊 **Resultados y Productos**

- `serie_preparada.csv` → entrada base para ARIMA/SES y detección