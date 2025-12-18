# README_CONTENDOR

# 🐳 Entorno reproducible con Docker

Este documento describe paso a paso cómo **construir y ejecutar el entorno Docker** del proyecto, permitiendo reproducir íntegramente el análisis realizado en el Trabajo de Síntesis, de forma independiente del sistema operativo.

---

## 🚀 1. Requisitos previos

Antes de iniciar, asegúrate de tener instalado:

### 🔹 Docker Desktop (obligatorio)

[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

Docker se utiliza para encapsular el entorno de ejecución, garantizando consistencia en versiones de Python y dependencias.

- En **Windows**, Docker Desktop utiliza **WSL2** automáticamente.
- En **macOS**, Docker Desktop incluye Docker Engine y Docker Compose.
- En **Linux**, se puede instalar Docker Engine siguiendo la documentación oficial.

### 🔹 Git (opcional, pero recomendado)

[https://git-scm.com/downloads](https://git-scm.com/downloads)

Git permite clonar el repositorio y trabajar localmente con control de versiones.

---

## 📥 2. Clonar el repositorio

Desde una terminal (PowerShell, CMD, Git Bash o Linux/macOS):

```bash
git clone <https://github.com/TomasGonlez/Deteccion_DDoS.git>
cd Deteccion_DDoS
```

---

## 🐳 3. Construir la imagen Docker

Desde la raíz del proyecto:

```bash
docker compose build
```

Este comando:

- Lee el archivo Dockerfile
- Descarga la imagen base de Python
- Instala todas dependencias definidas en requirements.lock
- Construye la imagen del entrono analítico

> [!WARNING]
> La primera ejecución puede tardar algunos minutos.

---

## ▶️ 4. Levantar el contenedor

Para iniciar el entorno de desarrollo con Jupyter Notebook:

```bash
docker compose up
```

Este comando:

- Crea y ejecuta el contendero del proyecto
- Monta el repositorio local dentro del contenedor
- Expone el puerto 8888
- Inicia automáticamente Jupyter Notebook

---

## 📓 5. Acceder a Jupyter Notebook

Una vez levantado el contenedor, abre tu navegador y accede a:

```bash
http://localhost:8888
```

El servidor está configurado sin token, por lo que no se requiere autenticación:

Desde Jupyter se puede acceder a las carpetas principales del proyecto:

- notebooks/
- data/
- results/
- docs/

---

## 🧪 6. Prueba rápida de funcionamiento (sanity check)

Dentro de Jupyter Notebook:

1. Ingresa a la carpeta notebooks/
2. Abre un notebook inicial del proyecto
3. Ejecuta una celda de prueba como la siguiente:

```bash
import os
print(os.getcwd())
print(os.listdir("../data"))
```

Si la carpeta data/processed/ es visible, el entorno esta correctamente montado y operativo.

---

## 🛑 7. Detener el contenedor

Para detener la ejecución del entorno:

- Presionar CTRL + C en la terminal donde está ejecutándose Docker

Para detener y limpiar los contenedores:

```bash
docker compose down
```

---

## ♻️ 8. Reconstruir el entorno (solo si cambian dependencias)

Si se modifica alguno de los siguientes archivos:

- Dockerfile
- requirements.lock

Es necesario reconstruir la imagen del entorno:

```bash
docker compose buil
docker compose up
```

---

## 📦 9. Estructura relevante del proyecto

```
Deteccion_DDoS/
├── data/
│   ├── raw/          # Datos crudos (NO versionados)
│   └── processed/    # Datos procesados y series temporales derivadas (versionados)
├── notebooks/        # Notebooks de análisis y modelado
├── results/          # Gráficos y salidas finales
├── docs/             # Documentación complementaria
├── config
├── requirements
├── requirements.lock
├── Dockerfile
├── docker-compose.yml
├── .gitignore
└── README.md
```

---

## 📂 10. Sobre el dataset

El repositorio **no incluye los datos crudos originales del dataset** CICIDS2017 debido a su tamaño.

Cada usuario debe:

1. Crear la carpeta de datos crudos (si no existe):
    
    ```bash
    mkdir -p data/raw
    ```
    
2. Copiar manualmente los archivos CSV del dataset en:
    
    ```
    data/raw
    ```
    
    Por ejemplo:
    
    ```bash
    data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv
    ```
    

En los notebooks, los datos se cargan utilizando rutas realtivas, por ejemplo:

```python
import pandas as pd

df = pd.read_csv("../data/raw/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv")
```

> [!WARNING]
> Si el dataset no está presente en `data/raw`, aglunos notebooks no podrán ejecutarse y mostrarán errores de archivo no encontrrado.

---

> [!IMPORTANT]
> Los cambios realizados en Jupyter Notebook se guardan directamente en la máquina local del usuario.
> 
> La carpeta `data/raw/` no se versiona en el repositorio.
>
> La carpeta `data/processed/` sí se incluye para garantizar la reproducibilidad del análisis.
>
> El archivo `requirements.lock` define **exactamente** las versiones de dependencias utilizadas en el proyecto.
>
> El uso de Docker asegura que el proyecto pueda ejecutarse de forma consistente en cualquier sistema operativo compatible.
