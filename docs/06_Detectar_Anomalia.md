# 06_Detectar_Anomalia

🎯 **Propósito Principal**

Este notebook aplica la detección de anomalías usando ESD sobre los residuos de ARIMA y SES. Su objetivo práctico es validar si el enfoque “modelo + residuo + detector” logra destacar el periodo del ataque como un conjunto de observaciones anómalas.

Además, incluye explícitamente el análisis del **residuo relativo de SES** como alternativa a usar solo residuo absoluto (útil cuando la escala del tráfico cambia).

📋 **Requisitos Previos**

- `04_Entrenar_ARIMA.ipynb`
- `05_Entrenar_SES.ipynb`

Datos necesarios:

- `../data/processed/serie_preparada.csv`
- `../data/processed/residuos_arima.csv`
- `../data/processed/prediccion_ses.csv`
- `../data/processed/residuos_ses.csv`

Archivos Generados:

- `../results/19_residuo_relativo_ses.png`

Herramientas requeridas:

- Pandas / NumPy
- Implementación ESD (según notebook)
- Matplotlib

🚀 **Cómo Usar Este Notebook**

1. Ejecuta todas las celdas
2. Verifica que carguen correctamente los residuos
3. Confirma generación del gráfico de residuo relativo
4. Continúa con `07_Resumen.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **4–12 minutos**
- Detección ESD: **1–5 minutos**
- Visualizaciones: **1–3 minutos**

🔍 **Explicación por Secciones**

- Carga y alineación de series y residuos
- Extracción de componentes para SES/ARIMA
- Aplicación ESD
- Construcción de residuo relativo (SES)
- Figura final de soporte

⚠️ **Problemas comunes**

- Desalineación temporal (índices distintos)
- Nulos en predicción SES (división para residuo relativo)
- ESD no detecta → esto también es un “resultado” del estudio, no necesariamente un error