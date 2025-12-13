FROM python:3.10

WORKDIR /app

# Copiar requirements e instalar dependencias Python
COPY requirements.lock.txt /app/requirements.lock.txt
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r /app/requirements.lock.txt 

# -----------------------------
# Añadir configuración permanente de IPython
# -----------------------------

# Crear directorio del perfil de IPython dentro del contenedor
RUN mkdir -p /root/.ipython/profile_default

# Copiar el archivo de configuración al contenedor
COPY config/ipython/ipython_config.py /root/.ipython/profile_default/ipython_config.py


# -----------------------------
# Exponer puerto para Jupyter
# -----------------------------
EXPOSE 8888

# Comando por defecto: iniciar Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]
