# 🚀 Despliegue Automático en Amazon ECS con GitHub Actions 🚀  

Este proyecto implementa un flujo de trabajo automatizado para construir imágenes Docker, subirlas a Amazon Elastic Container Registry (ECR) y desplegar servicios en Amazon Elastic Container Service (ECS). ¡Con este pipeline CI/CD, el despliegue es más rápido, seguro y sin complicaciones!  

---

## 🌟 ¿Qué hace este proyecto?

1. **Automatiza el despliegue de aplicaciones** en Amazon ECS cada vez que se realiza un cambio en el código principal (`master` branch).  
2. **Construye imágenes Docker**, las sube a un repositorio en ECR y actualiza los servicios de ECS para usar la versión más reciente.  
3. **Optimiza el proceso** con capas cacheadas y configuraciones preestablecidas para Docker y AWS.  

Ideal para equipos que buscan **escalar y mantener aplicaciones en la nube** sin perder tiempo en configuraciones manuales. 🚀✨  

---

## 📋 Requisitos previos  

Antes de usar este workflow, asegúrate de tener:  

1. **Cuenta de AWS** con:
   - Repositorio en ECR configurado.
   - Cluster y servicios activos en ECS.
   - Roles de IAM con permisos adecuados para ECR y ECS.  
   
2. **Variables secretas configuradas en tu repositorio GitHub**:
   - `AWS_ACCESS_KEY`: ID de tu clave de acceso de AWS.
   - `AWS_SECRET_KEY`: Clave secreta de tu acceso de AWS.
   - `AWS_REGION`: Región AWS (por ejemplo, `us-east-1`).
   - `AWS_ACCOUNT_ID`: ID de tu cuenta AWS.
   - `ECR_REPO`: Nombre de tu repositorio ECR.
   - `ECS_CLUST`: Nombre de tu clúster ECS.
   - `ECS_SERVICE`: Nombre de tu servicio ECS.

---

## 🌌 ¿Cómo funciona el workflow?  

### 🚦 Desencadenante  
Cada vez que se realiza un **push** a la rama `master`, el pipeline se ejecuta automáticamente.

### ⚙️ Pasos del pipeline  

1. **✔️ Checkout del código fuente**  
   Descarga el repositorio en el entorno del runner para trabajar con el código más reciente.  

2. **🔑 Configuración de credenciales AWS**  
   Configura las credenciales para que el pipeline pueda interactuar con AWS.  

3. **🐳 Configuración de Docker Buildx**  
   Habilita Docker Buildx para construir imágenes multi-plataforma.  

4. **🌀 Cacheo de capas de Docker**  
   Guarda capas intermedias para acelerar las construcciones futuras.  

5. **🔐 Login en Amazon ECR**  
   Autentica el runner con el repositorio de imágenes en ECR.  

6. **⚒️ Construcción de la imagen Docker**  
   Crea una nueva imagen Docker etiquetada como `latest`.  

7. **📤 Subida de la imagen a ECR**  
   Sube la imagen al repositorio ECR configurado.  

8. **📥 Instalación del script ecs-deploy**  
   Descarga e instala `ecs-deploy`, un script ligero para manejar despliegues en ECS.  

9. **🚀 Despliegue en ECS**  
   Actualiza el servicio de ECS para usar la última imagen subida y fuerza un nuevo despliegue.  

---

