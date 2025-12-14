# 02_EDA

🎯 **Propósito Principal**

Este notebook realiza el **análisis exploratorio (EDA)** de la serie temporal construida, con el fin de entender su comportamiento global y determinar si presenta patrones útiles para modelado clásico. En términos simples: aquí se responde “¿cómo se comporta el tráfico en el tiempo?” antes de intentar ajustar modelos.

Además, este notebook genera gran parte de las **figuras de soporte** del trabajo: comparaciones antes/durante/después del ataque, autocorrelación (ACF/PACF) y descomposición (STL), que ayudan a justificar las decisiones metodológicas posteriores.

📋 **Requisitos Previos**

Notebooks que debes ejecutar antes:

- `01_Construccion_Serie_Tiempo.ipynb`

Datos necesarios:

- `../data/processed/serie_temporal.csv`
- (y opcionalmente) `../data/processed/dataset_limpio.csv`

Archivos/Resultados que genera:

- `../results/02_{numero}_comportamiento_temporal_{nombre_metrico}.png`
- `../results/03_{numero}_{nombre_metrico}.png`
- `../results/04_metricas_principales_ts.png`
- `../results/05_metricas_secundarias.png`
- `../results/06_referencia_temporal_ataque_ddos.png`
- `../results/07_paquetes_por_minuto_antes_durante_despues.png`
- `../results/08_paquetes_por_minuto_antes_durante_despues_rolling_mean.png`
- `../results/09_paquetes_por_minuto_antes_durante_despues_rolling_std.png`
- `../results/10_ACF.png`, `../results/10_PACF.png`
- `../results/11_STL.png`

Herramientas requeridas:

- Pandas / NumPy
- Matplotlib
- Statsmodels (para ACF/PACF y STL si corresponde)

🚀 **Cómo Usar Este Notebook**

Pasos Básicos:

1. **Preparación:** asegúrate de tener `serie_temporal.csv` generado
2. **Ejecución:** corre todas las celdas en orden
3. **Verificación:** revisa que se generen las figuras en `../results/`
4. **Siguientes pasos:** continúa con `03_Construir_Serie_Modelar.ipynb`

⏱️ **Tiempos Estimados**

- Ejecución completa: **8–20 minutos**
- Procesamiento (cálculos/rolling/ACF/STL): **6–15 minutos**
- Generación de figuras: **2–5 minutos**

🔍 **Explicación por Secciones**

*(Basado en los títulos del notebook; se resume el objetivo práctico.)*

**Sección 1: EDA general**

- Objetivo: inspección inicial de la serie y su rango temporal
- Salida esperada: entendimiento base de escala/variabilidad

**Sección 2–3: Comportamiento temporal por métricas**

- Objetivo: comparar métricas candidatas y su estabilidad
- Salida: gráficos con nombre templado `{nombre_metrico}`
- Nota: los placeholders indican que el notebook puede iterar sobre métricas

**Sección 4–5: Métricas principales y secundarias**

- Objetivo: concentrar visualmente las métricas más relevantes
- Salida: `04_metricas_principales_ts.png` y `05_metricas_secundarias.png`

**Sección 6: Referencia temporal del ataque**

- Objetivo: ubicar claramente antes/durante/después del ataque
- Salida: `06_referencia_temporal_ataque_ddos.png`

**Sección 7–9: Análisis antes/durante/después + rolling**

- Objetivo: comparar comportamiento por segmentos y suavizamientos
- Salida:
    - `07_...png` (segmentación)
    - `08_...png` (media móvil)
    - `09_...png` (desviación estándar móvil)

**Sección 10: ACF y PACF**

- Objetivo: observar dependencia temporal (si existe)
- Salida: `10_ACF.png` y `10_PACF.png`

**Sección 11: STL**

- Objetivo: explorar si hay componentes separables (tendencia/estacionalidad/residuo)
- Salida: `11_STL.png`

📊 **Resultados y Productos**

Archivos Generados:

- Principalmente figuras en `../results/` (ver lista)

Visualizaciones (qué aportan):

- Segmentación antes/durante/después: evidencia cambios y variabilidad
- Rolling mean/std: muestra estabilidad relativa o ausencia de patrón
- ACF/PACF: evidencia si hay estructura para modelos AR/MA
- STL: muestra si hay tendencia/estacionalidad explotable

Métricas Clave:

- No fija “valores típicos” únicos; se interpretan visualmente y se usan para justificar el modelado.

🔗 **Conexiones con Otros Notebooks**

- Entrada desde: `01_Construccion_Serie_Tiempo.ipynb`
- Salida hacia: `03_Construir_Serie_Modelar.ipynb` (formaliza la preparación/modelado)

⚠️ **Posibles Problemas y Soluciones**

Error Común 1: No se generan imágenes en `../results/`

- Causa: carpeta no existe o permisos
- Solución: crear carpeta y re-ejecutar

Error Común 2: ACF/PACF falla por NaN

- Causa: serie con nulos
- Solución: imputar/eliminar nulos antes del cálculo

💡 **Consejos Prácticos**

- No te quedes con un solo gráfico: la fuerza del EDA está en la consistencia entre figuras.