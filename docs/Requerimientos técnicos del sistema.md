# Requerimientos técnicos del sistema

# 1.- Objetivos

## Objetivo General

Desarrollar un sistema estadístico capaz de detectar de manera temprana anomalías asociadas a ataques de denegación de servicio distribuido (DDoS) mediante el análisis de series temporales aplicadas a tráfico de red.

## Objetivos Específicos

- Preprocesar el dataset CICIDS2017 para construir series temporales representativas del tráfico.
- Aplicar modelos estadísticos (Holt-Winters y ARIMA) para modelar el comportamiento normal del tráfico.
- Implementar un mecanismo de detección de anomalías basado en residuos y umbrales estadísticos.
- Evaluar el rendimiento del sistema mediante métricas de precisión, recall y F1-score.
- Generar visualizaciones que permitan interpretar resultados de forma clara.

---

# 2.- Alcance del sistema

El sistema se centrará exclusivamente en la detección temprana de anomalías asociadas a ataques DDoS en tráfico de red. Su propósito es analítico y complementario, proporcionando indicadores, métricas y visualizaciones que permitan identificar comportamientos inusuales dentro de series temporales construidas a partir del dataset CICIDS2017.

El sistema **NO** **realiza mitigación activa de ataques, no interviene directamente en el tráfico en tiempo real y no reemplaza sistemas comerciales de protección**. Su alcance se limita a la ingestión de datos, procesamiento, modelado estadístico, detección y evaluación.

---

# 3.- Fuente de datos

El conjunto de datos utilizado es CICIDS2017 del [Canadian Institute for Cybersecurity](https://www.unb.ca/cic/), que contiene ataques benignos y actuales similares a tráfico real (PCAP). Incluye [resultados del análisis de tráfico](https://github.com/ISCX/CICFlowMeter) con CICFlowMeter: flujos etiquetados con marca de tiempo, IPs, puertos, protocolos y ataques (archivos CSV).

La captura de datos abarcó cinco días, desde las 9:00 del lunes 3 de julio de 2017 hasta las 17:00 del viernes 7 de julio de 2017. El lunes representa un día normal con únicamente tráfico benigno. Los ataques implementados incluyen Brute Force FTP, Brute Force SSH, DoS, Heartbleed, Web Attack, Infiltration, Botnet y DDoS. Estos ataques se ejecutaron durante las mañanas y tardes de martes a viernes.

El conjunto de datos se puede obtener en el siguiente enlace

https://www.unb.ca/cic/datasets/ids-2017.html

El sistema utiliza el conjunto de datos CICIDS2017, específicamente los archivos con tráfico benigno y malicioso asociado a ataques DDoS. Estos archivos provienen de una simulación realista de red empresarial e incluyen etiquetas que diferencian el tráfico normal del malicioso.

El archivo principal para este proyecto es:

- `Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv`

El usuario debe incorporar este dataset localmente en la carpeta `data/raw/` debido a su tamaño y a las mejores prácticas de manejo de datos.

¿Qué significa pcap?

La captura de paquetes — o PCAP — se refiere al proceso de interceptar y realizar un registro de paquetes de datos, que son las unidades de datos y carga útil que componen el tráfico de la red. El paquete de datos capturado se convierte en archivos legibles, conocidos como archivos PCAP, que los administradores de red y los equipos de seguridad pueden luego analizar para solucionar problemas [**monitorear el comportamiento de la red**](https://corelight.com/resources/glossary/network-security-monitoring-nsm), y detectar actividad maliciosa.

---

# 4.- Entradas del sistema

¿Qué son las entradas del sistema?

Las entradas son:

1. Los datos crudos que el sistema recibe del entorno (dataset)
2. Los atributos o variables del flujo de red
3. Los parámetros configurables que modifican el comportamiento del pipeline

No son aún los procesos ni las salidas, **solo describen lo que el sistema necesita para funcionar**

El sistema va a recibir como entradas:

- Archivos CSV provenientes del dataset CICIDS2017.
- Columnas relevantes del flujo de red (timestamps, bytes, duración de flujo, etc.)
- Parámetros de configuración para:
    - Frecuencia de agregación temporal
    - Selección de variables
    - Parámetros de modelos estadísticos
    - Umbrales de detección

---

# 5.- Procesos Principales

El pipeline va a contar con 5 “fases” importantes para lograr con el objetivo general que es un sistema automatizado de detección de anomalías enfocado a ataque DDoS.
Las fases son las siguientes

- Ingesta y validación del dataset
    
    Lectura del archivo CSV, verificación de tipos de datos, manejo de valores faltantes y ordenamiento por timestamp.
    
- Construcción de series temporales
    
    Agregación del tráfico por intervalos regulares (por ejemplo, 1 o 5 segundos), cálculo de métricas como `bytes_total` y `pkts_total`.
    
- Modelado estadístico
    
    Entrenamiento de modelos Holt-Winters y ARIMA para capturar el comportamiento normal del tráfico y generar predicciones.
    
- Detección de anomalías
    
    Cálculo de residuos, identificación de puntos atípicos mediante umbrales estadísticos o pruebas como S-H-ESD.
    
- Evaluación y visualización
    
    Comparación con etiquetas reales del dataset, cálculo de métricas como precision, recall y F1-score, y generación de gráficos para interpretación.
    

---

# 6.- Salidas del sistema

El sistema va a generar:

- `serie_temporal.csv`: agregación temporal del tráfico, contiene la versión agregada del dataset original, en la forma de una serie temporal regular. Incluye:
    - Timestamp redondeado a la frecuencia definida (1s o 5s)
    - Tráfico total por intervalo:
        - bytes_total
        - pkts_total
    - Variables derivadas (si se requiere):
        - Tráfico promedio
        - ratio forward/backward
    
    Es una salida clave ya que es la entrada principal para los modelos estadísticos
    
- `residuos_hw.csv` y `residuos_arima.csv`: residuos de cada modelo, los residuos permiten medir que tan bien el modelo captura el comportamiento normal del tráfico, 
$residual = real - prediccion$
Los picos altos en los residuos suelen corresponder a eventos anómalos, el modelo con residuos más estables y sin tendencia es mejor.
- `anomalias_detectadas.csv`: puntos marcados como anómalos, este archivo reporta exactamente cuándo y porqué el sistema detectó una anomalía, es fundamental para validar la eficacia del detector.
- `metricas_resultado.csv`: métricas de evaluación del sistema, permite cuantificar la cualidad del sistema y compararlos con otros enfoques.
- Gráficos en formato PNG que incluyen:
    - Tráfico temporal
    - Predicciones del modelo
    - Anomalías detectadas
    - Matriz de confusión

---

# 7.- Entorno técnico de ejecución

El sistema se ejecuta en un entorno reproducible basado en Docker, utilizando las imágenes configuradas en los archivos `Dockerfile` y `docker-compose.yml`.

Componentes principales:

- Python 3.10
- Jupyter Notebook como entorno de análisis
- Bibliotecas: pandas, numpy, scipy, statsmodels, scikit-learn, matplotlib, seaborn
- Orquestación mediante `docker compose up`

---

# 8.- Criterios de éxito del sistema

Para evaluar la efectividad del sistema estadístico de detección temprana de ataques DDoS, se establecen los siguientes criterios de éxito. Estos criterios miden el desempeño del pipeline, su capacidad predictiva y su reproducibilidad.

## 8.1 Criterios cuantitativos (métricas de desempeño)

### a) Detección de anomalías

El sistema es exitoso si:

- Identifica correctamente la mayoría de los períodos etiquetados como ataques DDoS en el dataset CICIDS2017.
- Alcanza un rendimiento mínimo de:
    - **Precision ≥ 0.70**
    - **Recall ≥ 0.70**
    - **F1-score ≥ 0.70**

*(Estos valores pueden ajustarse según el comportamiento real del dataset.)*

### b) Residuos del modelo

- Los residuos de los modelos Holt-Winters y ARIMA deben mostrar una distribución centrada en cero y sin tendencia.
- El error promedio debe mantenerse bajo un umbral razonable según la escala del tráfico:
    - **MAE (Mean Absolute Error) aceptable según la variabilidad del tráfico.**

---

## 8.2 Criterios cualitativos (comportamiento esperado)

### a) Estabilidad del modelo

El modelo debe capturar:

- Tendencias del tráfico
- Estacionalidad predominante
- Variaciones naturales del comportamiento benigno

Sin generar sobreajuste ni alta sensibilidad al ruido.

### b) Claridad de las anomalías detectadas

Las anomalías marcadas deben:

- Coincidir visualmente con picos de tráfico atípicos
- Separarse claramente del comportamiento normal
- Ser explicables a nivel operativo

---

## 8.3 Criterios de reproducibilidad

El sistema es reproducible si:

- **Puede ejecutarse completamente dentro del entorno Docker** sin requerir configuraciones adicionales.
- El pipeline produce los mismos resultados (o variaciones mínimas) cuando se ejecuta en:
    - Distintos computadores
    - Distintos sistemas operativos
    - Instalaciones independientes del entorno Docker

---

## 8.4 Criterios de trazabilidad y documentación

El proyecto está bien documentado si:

- Todas las etapas del pipeline (ingesta → preprocesamiento → modelado → detección → evaluación) están documentadas en Jupyter Notebooks.
- Cada archivo generado (serie temporal, residuos, anomalías, métricas, gráficos) se almacena en la estructura propuesta.
- La documentación permite a un tercero comprender, ejecutar y evaluar el sistema.

---

## 8.5 Criterios operativos del pipeline

El sistema es exitoso si:

- La construcción de la serie temporal se ejecuta sin errores.
- Los modelos Holt-Winters y ARIMA se entrenan correctamente.
- El pipeline completo se ejecuta de principio a fin sin interrupciones.