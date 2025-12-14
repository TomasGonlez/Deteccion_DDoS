# 05_Entrenar_SES

🎯 **Propósito Principal**

Este notebook entrena un modelo SES (suavizamiento exponencial simple) y genera predicciones y residuos. En el flujo del proyecto, cumple un rol comparativo: evaluar un modelo más simple como referencia frente a ARIMA, manteniendo el mismo principio: aprender el comportamiento benigno y observar si el error aumenta durante el ataque.

📋 **Requisitos Previos**

- `03_Construir_Serie_Modelar.ipynb`

Datos necesarios:

- `../data/processed/serie_preparada.csv`

Archivos Generados:

- `../data/processed/prediccion_ses.csv`
- `../data/processed/residuos_ses.csv`
- `../results/18_Prediccion_SES_Serie_Completa.png`
- `../results/19_Paquetes_Minuto__SES_Residuo.png`

Herramientas requeridas:

- Statsmodels (SES / ETS según implementación)
- Pandas / NumPy
- Matplotlib

🚀 **Cómo Usar Este Notebook**

1. Ejecuta completo en orden
2. Verifica exportación de predicción y residuos
3. Continúa con `05_Comparacion_modelos.ipynb` y luego `06_Detectar_anomalia.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **3–8 minutos**
- Entrenamiento: **1–4 minutos**
- Figuras/exportación: **1–3 minutos**

🔍 **Explicación por Secciones**

- Carga serie
- Entrena SES en ventana benigna
- Predice serie completa
- Calcula residuos
- Exporta resultados
- Genera figuras de control

📊 **Productos**

- `prediccion_ses.csv` y `residuos_ses.csv` → insumo de detección y resumen final