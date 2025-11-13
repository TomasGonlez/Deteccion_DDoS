🚀 1. Requisitos previos

Antes de iniciar el entorno, asegúrate de tener instalado:

🔹 Docker Desktop

https://www.docker.com/products/docker-desktop/

Este proyecto utiliza Docker para garantizar un entorno reproducible e independiente del sistema operativo.

🔹 Git (opcional, pero recomendado)

https://git-scm.com/downloads

📥 2. Clonar el repositorio

En una terminal (PowerShell, CMD, Git Bash o Linux/macOS):

git clone https://github.com/TU_USUARIO/Deteccion_DDoS.git


Reemplaza TU_USUARIO por tu usuario real de GitHub.

Luego:

cd Deteccion_DDoS

🐳 3. Construir la imagen Docker

Desde la raíz del proyecto:

docker compose build


Este comando:

Lee el Dockerfile

Descarga la imagen base python:3.10

Instala todas las dependencias listadas en requirements.txt

Prepara la imagen del entorno para su ejecución

La primera vez puede demorar unos minutos.

▶️ 4. Levantar el contenedor

Para iniciar el entorno de desarrollo (Jupyter Notebook):

docker compose up


Esto:

Crea y ejecuta el contenedor ddos-dev

Monta el contenido del proyecto en /app

Expone el puerto 8888

Inicia automáticamente Jupyter en el contenedor

📓 5. Acceder a Jupyter Notebook

Cuando el contenedor esté en ejecución, abre tu navegador y visita:

http://localhost:8888


El servidor está configurado sin token, por lo que no necesitarás contraseña para acceder.

Dentro de Jupyter encontrarás todas las carpetas del proyecto:

notebooks/

src/

data/

results/
y más.

🧪 6. Prueba de funcionamiento (sanity check)

Dentro de Jupyter:

Entra a la carpeta notebooks/

Abre el archivo 00_sanity_check.ipynb

Ejecuta las celdas:

import os
print(os.getcwd())
print(os.listdir("../data"))


Si ya tienes un archivo en data/raw/, prueba:

import pandas as pd
pd.read_csv("../data/raw/tu_archivo.csv").head()


Si esto funciona ⇒ el entorno está operativo.

🛑 7. Detener el contenedor

Para detener el entorno, presiona:

CTRL + C


en la terminal donde está corriendo.

Para apagar y limpiar los contenedores ejecutados:

docker compose down

♻️ 8. Reconstruir el entorno (solo si cambias dependencias)

Si editas el Dockerfile o el requirements.txt, necesitas:

docker compose build
docker compose up


para actualizar el contenedor.

📦 9. Estructura del proyecto
Deteccion_DDoS/
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/
├── src/
│   ├── ingestion/
│   ├── preprocessing/
│   ├── modeling/
│   ├── detection/
│   ├── evaluation/
│   └── pipeline/
├── results/
├── configs/
├── artifacts/
├── docs/
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── .gitignore

📣 Notas importantes

Los cambios realizados en Jupyter se guardan directamente en tu máquina, no dentro del contenedor.

Las carpetas data/, results/ y artifacts/ no se incluyen en el repositorio (ignoradas por .gitignore).

El entorno Docker asegura que el proyecto funcione igual en cualquier PC.