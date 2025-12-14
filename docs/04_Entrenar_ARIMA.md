# 04_Entrenar_ARIMA

🎯 **Propósito Principal**

Este notebook entrena un modelo ARIMA utilizando únicamente la **ventana benigna** y luego lo usa para producir predicciones (y residuos) que serán analizados como posible señal de anomalía. La idea práctica es: “si el modelo aprende lo normal, el error debería aumentar cuando aparece el ataque”.

El notebook se enfoca en dejar evidencia: gráficos de ajuste, comportamiento de residuos y un archivo de residuos exportado para su uso en el notebook de detección.

📋 **Requisitos Previos**

- `03_Construir_Serie_Modelar.ipynb`

Datos necesarios:

- `../data/processed/serie_preparada.csv`

Archivos Generados:

- `../data/processed/residuos_arima.csv`
- `../results/14_ACF_PACF_Ventana_beningna.png`
- `../results/15_Residuos_ARIMA_Ventana_Benigna.png`
- `../results/16_ACF_PACF_Ventana_Benigna_Residuos.png`
- `../results/17_Paquetes_Minuto_ARIMA_Residuo.png`

Herramientas requeridas:

- Statsmodels (ARIMA, ACF/PACF)
- Pandas / NumPy
- Matplotlib

🚀 **Cómo Usar Este Notebook**

1. Ejecuta todo en orden (parámetros dependen de etapas previas)
2. Verifica que se exporte `residuos_arima.csv`
3. Continúa con `05_Entrenar_SES.ipynb` y luego `05_Comparacion_modelos.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **5–15 minutos**
- Entrenamiento/ajuste: **3–12 minutos**
- Figuras/exportación: **1–3 minutos**

🔍 **Explicación por Secciones**

**Sección 1: Cargar serie preparada**

- Objetivo: usar el mismo estándar para todo el pipeline
- Salida: serie lista para entrenar

**Sección 2: Diagnóstico ventana benigna (ACF/PACF)**

- Objetivo: observar dependencia temporal previa al ajuste
- Salida: `14_...png`

**Sección 3: Entrenamiento ARIMA**

- Objetivo: ajustar el modelo en “normalidad”
- Salida: modelo entrenado

**Sección 4: Residuos en ventana benigna**

- Objetivo: revisar si el error se comporta razonablemente
- Salida: `15_...png` y `16_...png`

**Sección 5: Predicción serie completa + residuos**

- Objetivo: medir error al pasar por el ataque
- Salida: `17_...png` y `residuos_arima.csv`

📊 **Resultados y Productos**

- `residuos_arima.csv` → insumo directo para detección ESD (notebook 06)