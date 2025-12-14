# 01_Cargar_Serie_Tiempo_30s

🎯 **Propósito Principal**

Este notebook construye la serie temporal con frecuencia **cada 30 segundos**, como alternativa intermedia entre 1 minuto y 1 segundo. La idea es evaluar si una resolución más fina que 1 minuto permite ver cambios más rápidos sin caer en los problemas típicos del resampleo por segundo.

📋 **Requisitos Previos**

- `00_Cargar_dataset.ipynb` (opcional)

Datos necesarios:

- `../data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv`

Archivos generados:

- `../results/01_paquetes_cada_30_segundos.png`

🚀 **Cómo Usar Este Notebook**

- Ejecuta en orden
- Evalúa el gráfico: si la señal es interpretable y estable, podrías considerar ajustar el pipeline (pero eso implica rehacer EDA/modelos/detección a 30s)

⏱️ **Tiempos Estimados**

- Ejecución completa: **4–9 minutos**

🔍 **Secciones**

- Igual que la versión por minuto, cambiando la agregación a 30 segundos.

📊 **Productos**

- `../results/01_paquetes_cada_30_segundos.png`