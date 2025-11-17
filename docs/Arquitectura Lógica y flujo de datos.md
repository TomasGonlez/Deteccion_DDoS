# Arquitectura Lógica y flujo de datos

## 1. Visión general de la arquitectura

El sistema implementa un pipeline estadístico para la detección temprana de anomalías asociadas a ataques DDoS a partir de tráfico de red. La arquitectura se organiza de forma modular, separando claramente las etapas de ingestión de datos, preprocesamiento, construcción de series temporales, modelado, detección de anomalías, evaluación y visualización.

El núcleo del sistema se ejecuta dentro de un entorno reproducible basado en Docker, donde cada etapa del pipeline se implementa mediante código en `src/` y notebooks en `notebooks/`, utilizando los datos almacenados en `data/` y generando resultados en `results/` y `artifacts/`.

A nivel lógico, el flujo de datos sigue el siguiente recorrido:

> Dataset crudo (flows) → Serie temporal agregada → Modelos estadísticos → Residuos → Detección de anomalías → Métricas y visualizaciones
> 

---

## 2. Componentes principales del sistema

La arquitectura lógica se compone de los siguientes módulos:

### 2.1 Módulo de ingestión (`src/ingestion/`) [INGESTA]

**Responsabilidad principal:**

Leer los archivos CSV del dataset CICIDS2017 desde `data/raw/`, validar su estructura y dejarlos listos para el preprocesamiento.

**Funciones típicas:**

- Cargar archivos CSV (por ejemplo, `Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv`).
- Verificar tipos de datos (timestamps, numéricos, categóricos).
- Filtrar columnas relevantes para el análisis.
- Manejar errores de lectura y rutas.

---

### 2.2 Módulo de preprocesamiento (`src/preprocessing/`) [PREPROCESAMIENTO]

**Responsabilidad principal:**

Transformar los datos crudos en una estructura adecuada para construir series temporales.

**Funciones típicas:**

- Limpiar valores nulos o inconsistentes.
- Convertir timestamps a formato de fecha y hora.
- Ordenar los registros por tiempo.
- Seleccionar variables de tráfico relevantes (por ejemplo, bytes y paquetes).
- Preparar el dataset para la agregación temporal.

---

### 2.3 Módulo de construcción de series temporales (`src/preprocessing/` o submódulo dedicado especificamente a esto) [PREPROCESAMIENTO]

**Responsabilidad principal:**

Generar la serie temporal agregada que represente el comportamiento del tráfico en el tiempo.

**Funciones típicas:**

- Definir la frecuencia de agregación (por ejemplo, 1s o 5s).
- Agrupar por intervalo de tiempo.
- Calcular métricas agregadas, como:
    - `bytes_total` por intervalo.
    - `pkts_total` por intervalo.
- Guardar el resultado en `data/processed/serie_temporal.csv`.

---

### 2.4 Módulo de modelado (`src/modeling/`) [MODELADO]

**Responsabilidad principal:**

Entrenar modelos estadísticos para aprender el comportamiento normal del tráfico.

**Modelos considerados:**

- Modelo Holt-Winters (suavizamiento exponencial con tendencia/estacionalidad).
- Modelo ARIMA (autoregresivo integrado de media móvil).

**Funciones típicas:**

- Cargar `serie_temporal.csv`.
- Separar datos de entrenamiento y prueba, si aplica.
- Ajustar parámetros de los modelos (p, d, q, etc.).
- Generar predicciones para cada instante de tiempo.
- Guardar los residuos en:
    - `artifacts/residuos_hw.csv`
    - `artifacts/residuos_arima.csv`

---

### 2.5 Módulo de detección de anomalías (`src/detection/`) [DETECCIÓN]

**Responsabilidad principal:**

Identificar puntos en el tiempo que se desvían significativamente del comportamiento esperado del modelo.

**Funciones típicas:**

- Cargar residuos del modelo seleccionado.
- Calcular un indicador de anomalía (por ejemplo, z-score o umbral basado en desviación estándar).
- Marcar observaciones como normales o anómalas.
- Generar un archivo `results/anomalias_detectadas.csv` que incluya:
    - timestamp,
    - valor real,
    - predicción,
    - residual,
    - flag de anomalía.

---

### 2.6 Módulo de evaluación (`src/evaluation/`) [EVALUACIÓN]

**Responsabilidad principal:**

Medir el desempeño del sistema comparando las anomalías detectadas con las etiquetas reales del dataset.

**Funciones típicas:**

- Cruzar `anomalias_detectadas.csv` con las etiquetas reales (ataque / no ataque).
- Calcular:
    - precision,
    - recall,
    - F1-score,
    - matriz de confusión.
- Guardar los resultados en `results/metricas_resultado.csv`.

---

### 2.7 Módulo de visualización (`src/evaluation/`) [VISUALIZACIÓN]

**Responsabilidad principal:**

Generar gráficos y visualizaciones que permitan interpretar el comportamiento del sistema.

**Funciones típicas:**

- Graficar la serie temporal con las predicciones del modelo.
- Destacar las anomalías sobre el gráfico del tráfico.
- Mostrar la matriz de confusión como imagen.
- Guardar gráficos en `results/` (por ejemplo, `.png`).

---

## 3. Flujo de datos entre módulos

El flujo de datos se describe de la siguiente forma:

1. **Entrada de datos:**
    - Origen: `data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv`
    - Consumido por: módulo de ingestación.
2. **Preprocesamiento:**
    - Entrada: dataset crudo.
    - Salida: dataset ordenado y limpio en memoria ().
3. **Construcción de serie temporal:**
    - Entrada: datos preprocesados.
    - Salida:
        - `data/processed/serie_temporal.csv`
4. **Modelado estadístico:**
    - Entrada: `serie_temporal.csv`.
    - Salidas:
        - `artifacts/residuos_hw.csv`
        - `artifacts/residuos_arima.csv`
5. **Detección de anomalías:**
    - Entrada: residuos del modelo seleccionado.
    - Salida:
        - `results/anomalias_detectadas.csv`
6. **Evaluación del sistema:**
    - Entradas:
        - `results/anomalias_detectadas.csv`
        - etiquetas reales del dataset.
    - Salida:
        - `results/metricas_resultado.csv`
        - matriz de confusión (imagen).
7. **Visualización:**
    - Entradas:
        - `serie_temporal.csv`
        - resultados del modelado,
        - anomalías detectadas,
        - métricas.
    - Salidas:
        - gráficos en `results/` para informe y análisis.

---

## 4. Relación con la estructura de carpetas

La arquitectura lógica se refleja directamente en la estructura del proyecto:

- **`data/raw/`**: entrada del sistema (dataset crudo).
- **`data/processed/`**: salidas intermedias (serie temporal).
- **`src/`**: implementación del pipeline modular:
    - `ingestion/`, `preprocessing/`, `modeling/`, `detection/`, `evaluation/`, `pipeline/`.
- **`notebooks/`**: experimentación y documentación ejecutable de cada etapa.
- **`artifacts/`**: residuos y artefactos de modelos.
- **`results/`**: anomalías, métricas y gráficos finales.
- **`configs/`**: parámetros de configuración (por ejemplo, frecuencia temporal, umbrales, parámetros de modelos).
- **`docs/`**: documentación de requerimientos, arquitectura y otros documentos de apoyo.

---

## 5. Orquestación y ejecución del pipeline

El entorno se orquesta mediante Docker y `docker compose`:

- El `Dockerfile` define la imagen base, las dependencias y el entorno de ejecución.
- `docker-compose.yml` levanta un contenedor (`ddos-dev`) que:
    - monta el proyecto en `/app`,
    - expone el puerto 8888,
    - ejecuta Jupyter Notebook.

En términos prácticos, la ejecución típica del pipeline sigue este orden:

1. Levantar el entorno:
    
    ```bash
    docker compose up
    
    ```
    
2. Ejecutar los notebooks en este orden:
    - `00_sanity_check.ipynb`
    - `01_construccion_serie_temporal.ipynb`
    - `02_analisis_exploratorio.ipynb`
    - `03_modelo_holt_winters.ipynb`
    - `04_modelo_arima.ipynb`
    - `05_deteccion_anomalias.ipynb`
    - `06_evaluacion_sistema.ipynb`
3. Revisar las salidas generadas en `data/processed/`, `artifacts/` y `results/`.

Esta secuencia garantiza que el flujo de datos respete la arquitectura lógica definida y que el sistema pueda ser reproducido de forma consistente en otros entornos.