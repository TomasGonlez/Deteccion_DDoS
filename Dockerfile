FROM python:3.10

WORKDIR /app

# Copiar requirements e instalar dependencias Python
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Exponer puerto para Jupyter
EXPOSE 8888

# Comando por defecto: iniciar Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]
