# Análisis de la viabilidad del uso de modelos de series temporales en la identificación de anomalías asociadas a ataques DDoS

El proyecto evalúa la **viabilidad del uso de modelos estadísticos clásicos de series temporales** para la detección de anomalías asociadas a un ataque **DDoS**, utilizando tráfico de red realista del dataset **CICIDS2017**.

---

## 🎓 Información académica

- **Autor:** Tomás Ignacio González Faúndez
- **Carrera:** Ingeniería Civil Informática
- **Institución:** Universidad de Playa Ancha
- **Año:** 2025

---

## 📌 Objetivo del proyecto

Determinar si los **modelos clásicos de series temporales** (ARIMA y Suavizamiento Exponencial Simple) y un **detector estadístico de outliers (ESD)** son viables para identificar anomalías asociadas a un ataque DDoS en el subconjunto **Friday-Afternoon-DDoS** del dataset CICIDS2017.

---

## 🧠 Metodología general

La metodología aplicada es de tipo **cuantitativa y experimental**, estructurada en las siguientes etapas:

1. **Preparación de datos**
    - Selección del subconjunto Friday-Afternoon-DDoS
    - Construcción de series temporales agregadas
    - Separación de ventana benigna y ventana con ataque
2. **Diagnóstico de la serie**
    - Análisis exploratorio de datos (EDA)
    - Evaluación de autocorrelación (ACF y PACF)
    - Pruebas de estacionariedad (ADF y KPSS)
3. **Modelado estadístico**
    - Ajuste de modelos ARIMA mediante metodología Box–Jenkins
    - Aplicación de Suavizamiento Exponencial Simple (SES)
    - Entrenamiento exclusivo con tráfico benigno
4. **Detección de anomalías**
    - Análisis de residuos del modelo
    - Aplicación del test ESD (Extreme Studentized Deviate)

---

## 📊 Dataset utilizado

- **Dataset:** CICIDS2017
- **Fuente:** Canadian Institute for Cybersecurity
- **Subconjunto:** Friday-Afternoon-DDoS

El repositorio **no incluye los datos crudos originales** debido a su tamaño.

Sin embargo, se incluyen **datasets procesados y series temporales derivadas** en `data/processed/`, permitiendo reproducir el análisis completo.

---

## 📂 Estructura del repositorio

```
Deteccion_DDoS/
├── data/
│   ├── raw/          # Datos crudos (NO versionados)
│   └── processed/    # Datos procesados y series temporales (versionados)
├── notebooks/        # Notebooks de análisis y modelado
├── results/          # Gráficos y salidas finales
├── docs/             # Documentación complementaria
├── config/
├── requirements.lock # Dependencias exactas del entorno
├── Dockerfile
├── docker-compose.yml
├── README.md
└── README_UTILIZAR_CONTENEDOR.md
```

## 🐳 Reproducibilidad del proyecto

El proyecto puede ejecutarse de forma completamente reproducible utilizando Docker.

👉 Para un paso a paso detallado, consulta:

- README_UTILIZAR_CONTENEDOR

Este documento explica cómo:

- Instalar Docker
- Construir la imagen
- Levantar el contenedor
- Acceder a Jupyter Notebook
- Ejecutar el pipeline del proyecto

---

✅ Resultados principales

- El tráfico benigno presenta alta variabilidad y baja dependencia temporal.
- Las pruebas de estacionariedad entregan resultados inconsistentes.
- Los modelos ARIMA y SES no logran capturar adecuadamente la dinámica del tráfico.
- Los residuos generados no permiten una detección robusta mediante ESD.
- Bajo las condiciones evaluadas, los modelos clásicos de series temporales no resultan viables para la detección temprana del ataque DDoS analizado.

---

🧾 Conclusión
Los resultados obtenidos indican que, para el subconjunto Friday-Afternoon-DDoS del dataset CICIDS2017, las propiedades estadísticas del tráfico de red no cumplen los supuestos necesarios para una detección efectiva mediante modelos clásicos de series temporales.

Esto evidencia la importancia de validar las características del dominio de aplicación antes de emplear enfoques estadísticos tradicionales en contextos de ciberseguridad.

---

📚 Referencias (selección)

- Sharafaldin, I., Lashkari, A. H., & Ghorbani, A. A. (2018). Toward generating a new intrusion detection dataset.
- Ahmed, M., Mahmood, A. N., & Hu, J. (2016). A survey of network anomaly detection techniques.
- Box, G. E. P., Jenkins, G. M., Reinsel, G. C., & Ljung, G. M. (2015). Time Series Analysis: Forecasting and Control.
- Hyndman, R. J., & Athanasopoulos, G. (2021). Forecasting: Principles and Practice.