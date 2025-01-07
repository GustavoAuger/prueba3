# 🚀 Proyecto Infraestructura y Despliegue Automatizado con Terraform y GitHub Actions 🚀  

Este proyecto tiene como objetivo principal implementar una infraestructura en la nube utilizando **Terraform** y automatizar su despliegue mediante **GitHub Actions**. Además, incluye una API sencilla en **Flask** y una aplicación de ejemplo para Docker con HTML, CSS y JavaScript. Para garantizar la seguridad de la infraestructura y las aplicaciones, se integró **Snyk**, una herramienta que analiza posibles vulnerabilidades en el código y en las imágenes Docker, asegurando que todos los recursos sean seguros antes de su despliegue.

# 📑 Tabla de Contenidos

1. 🌟 [Descripción General](#descripción-general)
2. 💻 [Tecnologías Utilizadas](#tecnologías-utilizadas)
3. 🗂 [Estructura del Proyecto](#estructura-del-proyecto)
4. 🌐 [Infraestructura con Terraform](#infraestructura-con-terraform)
5. 🔑 [Variables Secretas Configuradas en tu Repositorio GitHub](#variables-secretas-configuradas-en-tu-repositorio-github)
6. ⚙️ [Pasos del Pipeline](#pasos-del-pipeline)
    - 1️⃣ [🛡️ `scan-terraform`](#scan-terraform)
    - 2️⃣ [⚡ `terraform`](#terraform)
    - 3️⃣ [🚀 `despliegue-EC2`](#despliegue-ec2)
    - 4️⃣ [🛠️🛡️ `ecr-push`](#ecr-push)
7. 📌 [Notas Adicionales](#notas-adicionales)

---

## 🌟 Descripción General

El proyecto se centra en la creación y despliegue de una infraestructura robusta y segura para aplicaciones basadas en contenedores. Se utilizaron prácticas modernas de **IaC (Infrastructure as Code)** con **Terraform**, junto con pipelines **CI/CD** configurados en **GitHub Actions** para garantizar un flujo de trabajo ágil, seguro y automatizado.

Para asegurar la calidad y la seguridad de la infraestructura, se implementó **Snyk**, una herramienta de análisis de vulnerabilidades, que permite detectar configuraciones inseguras y vulnerabilidades tanto en el código como en las imágenes Docker utilizadas en el proyecto. Esto garantiza que la infraestructura y las aplicaciones estén protegidas desde el inicio del ciclo de vida del desarrollo.

La combinación de estas tecnologías permite un despliegue ágil y seguro de los recursos en la nube, asegurando la integridad y seguridad de las aplicaciones contenidas a lo largo de todo el proceso.


---

## 💻 Tecnologías Utilizadas

- **Terraform**: Para definir y desplegar la infraestructura en la nube.
- **GitHub Actions**: Para la automatización de despliegues y validaciones de código.
- **Snyk**: Para analizar la seguridad de los recursos y detectar vulnerabilidades.
- **AWS**: Plataforma en la nube utilizada para desplegar los recursos.
- **Flask**: Framework para la API simple.
- **Docker**: Para contenerizar la aplicación de ejemplo (HTML, CSS, JS).
- **ECR (Elastic Container Registry)**: Para almacenar imágenes Docker.

---

## 🗂 Estructura del Proyecto

- **`/terraform`**: Configuraciones de Terraform para infraestructura.
- **`/github/workflows`**: Definición de workflows de GitHub Actions.
- **`/api`**: Código de la API en Flask.
- **`/landing`**: Aplicación de ejemplo basada en HTML, CSS y JavaScript.
- **`Dockerfile`**: Contenedor Docker para la aplicación de ejemplo en `landing`, donde se define cómo empaquetar y ejecutar la aplicación con Docker.

---

## 🌐 Infraestructura con Terraform

Se utilizó Terraform para definir y desplegar los siguientes recursos en AWS:

- **VPC:** Configuración de una red virtual privada con CIDR específico.
- **Subredes:** Subred pública y privada asociadas a zonas de disponibilidad específicas.
- **Internet Gateway:** Configuración de un gateway para permitir acceso público a la red.
- **Tabla de Rutas:** Definición de rutas necesarias para el tráfico entre los recursos.
- **Grupos de Seguridad:** Creación de reglas de acceso para controlar el tráfico entrante y saliente.
- **Instancia EC2:** Configuración de una instancia con acceso a internet, asociada a las subredes y grupos de seguridad.
- **ECR:** Configuración de un repositorio para almacenar imágenes de Docker.
- **SQS y SNS:** Configuración de colas de mensajes y temas para integración y notificaciones.
- **Lambda Function:** Creación de una función Lambda escrita en Python, configurada con SQS como trigger y SNS como suscriptor.

---

## 🔑 Variables secretas configuradas en tu repositorio GitHub:

   - `AWS_ACCESS_KEY`: ID de tu clave de acceso de AWS.
   - `AWS_SECRET_KEY`: Clave secreta de tu acceso de AWS.
   - `AWS_REGION`: Región AWS (por ejemplo, `us-east-1`).
   - `AWS_ACCOUNT_ID`: ID de tu cuenta AWS.
   - `ECR_REPO`: Nombre de tu repositorio ECR.
   - `EC2_KEY`: Agregar la clave RSA.
   - `EC2_USER`: Agregar el usuario.
   - `SNYK_TOKEN`: Agregar el token de Snyk.
   
## ⚙️ Pasos del pipeline  

### 1. 🛡️ `scan-terraform`
En este job se llevó a cabo un análisis de seguridad del código de infraestructura como código (IaC) escrito en Terraform. Para lograr esto, se utilizó la herramienta **Snyk**, que identifica posibles vulnerabilidades o configuraciones inseguras en los archivos Terraform. Este análisis se enfocó en detectar problemas con severidad alta para garantizar que la infraestructura cumpla con los estándares de seguridad.

Las principales actividades incluyeron:

- Instalar y autenticar Snyk mediante un token seguro.
- Ejecutar un escaneo detallado sobre los archivos Terraform y reportar cualquier hallazgo crítico.

---

### 2. ⚡ `terraform`
Este job estuvo dedicado a la inicialización, planeación y aplicación de los cambios en la infraestructura utilizando Terraform. Este paso asegura que cualquier configuración definida en los módulos de Terraform sea aplicada correctamente en AWS.

Las tareas realizadas fueron:
- Clonar el código del repositorio.
- Configurar las credenciales de AWS mediante secretos almacenados en GitHub.
- Instalar Terraform y preparar el entorno para su ejecución.
- Inicializar el backend remoto para guardar el estado de Terraform en un bucket S3.
- Generar y visualizar un plan detallado de los cambios que se aplicarían a la infraestructura.
- Aplicar automáticamente los cambios validados, desplegando los recursos definidos (como la VPC, subredes, instancias EC2, entre otros).

---

### 3. 🚀 `despliegue-EC2`
En este job se realizó el despliegue de dependencias y configuraciones necesarias en la instancia EC2 creada previamente. Este paso garantiza que la instancia esté lista para ejecutar las aplicaciones o servicios requeridos.

Las actividades específicas fueron:
- Obtener la dirección IP pública de la instancia EC2 a partir de sus etiquetas en AWS.
- Configurar una clave SSH para permitir el acceso seguro a la instancia.
- Establecer una conexión remota con la instancia utilizando SSH.
- Actualizar e instalar las dependencias necesarias, como Python y cualquier otra herramienta o librería requerida para el proyecto.

---

### 4. 🛠️🛡️ `ecr-push`
En este job se construyó una imagen Docker, se escaneó en busca de vulnerabilidades y se subió a Amazon ECR (Elastic Container Registry) para su almacenamiento y posterior uso. Este paso asegura que la imagen esté lista para ser utilizada en despliegues futuros, mientras que se verifica su seguridad antes de subirla a la nube.

Las actividades específicas fueron:
- Clonar el código fuente del repositorio para obtener el contexto necesario para la construcción de la imagen.
- Configurar las credenciales de AWS mediante secretos de GitHub para poder interactuar con Amazon ECR.
- Configurar Docker Buildx, optimizando la construcción y el cacheo de las capas de la imagen Docker.
- Cachear las capas de Docker para acelerar las futuras construcciones y evitar la reconstrucción completa de la imagen en cada ejecución.
- Iniciar sesión en Amazon ECR usando la acción `aws-actions/amazon-ecr-login` para autenticar la subida de la imagen.
- Construir la imagen Docker a partir del Dockerfile y etiquetarla con la URL del repositorio de ECR.
- Instalar y autenticar Snyk, una herramienta de seguridad, para escanear la imagen Docker en busca de vulnerabilidades.
- Subir la imagen Docker a Amazon ECR, para hacerla disponible en la nube para su uso en contenedores o despliegues posteriores.
- Realizar un escaneo de la imagen cargada en ECR para detectar vulnerabilidades de seguridad adicionales que pudieran haber sido pasadas por alto.

---

## 📌 Notas Adicionales

Este proyecto implementa mejores prácticas de infraestructura como código y automatización para garantizar seguridad y eficiencia en la nube. Se recomienda revisar los logs de los workflows en GitHub Actions y las métricas de AWS para asegurar el correcto funcionamiento.

Se creó una infraestructura adicional para manejar el estado de Terraform de forma segura:

1. **Bucket S3**: Se creó `terraform-state-bucket-gustdev` para almacenar el estado de Terraform, habilitando el versionado para gestionar cambios y recuperar versiones anteriores si es necesario.
2. **Tabla DynamoDB**: Se creó `terraform-lock-table` para manejar bloqueos en Terraform y evitar conflictos durante las modificaciones del estado.

Esto asegura que el trabajo con Terraform sea seguro y colaborativo, permitiendo así la destrucción de los recursos de manera local (sin tener que hacerlo manualmente por consola)

Código y construcción completa en el repositorio:

[Enlace al repositorio de Terraform](https://github.com/GustavoAuger/terraformstate)
