# 05_Comparacion_Modelos

🎯 **Propósito Principal**

Este notebook compara ARIMA y SES sobre la misma serie preparada, buscando una lectura práctica: cuál ajusta mejor lo benigno, cuál generaliza peor, y qué tipo de residuos produce cada uno. Es un notebook de **contraste**: organiza la evidencia para justificar el resultado metodológico.

📋 **Requisitos Previos**

- `04_Entrenar_ARIMA.ipynb`
- `05_Entrenar_SES.ipynb`

Datos necesarios:

- `../data/processed/serie_preparada.csv`
- (implícito) residuos/predicciones generadas previamente

Herramientas:

- Pandas / Matplotlib

🚀 **Cómo Usar Este Notebook**

- Ejecuta en orden
- Verifica que puedas visualizar comparaciones (gráficos inline)
- Continúa con `06_Detectar_anomalia.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **2–6 minutos**

🔍 **Secciones**

- Carga de serie
- Comparación visual/estadística de resultados
- Conclusión comparativa

📊 **Resultados**

- No exporta grandes artefactos (principalmente visualización y criterio comparativo)