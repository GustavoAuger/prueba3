provider "aws" {
  region  = "us-east-1"
  #Sprofile = "gustavodev"  # Perfil configurado con las credenciales de AWS uso local
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-gustdev"    # Nombre de tu bucket S3
    key            = "terraform/state/mi-proyecto.tfstate" # Ruta donde se guardará el estado
    region         = "us-east-1"  # Región de tu bucket S3
    encrypt        = true  # Habilitar cifrado
    dynamodb_table = "terraform-lock-table"  # Tabla de DynamoDB para el bloqueo del estado
    #profile        = "gustavodev" # Perfil configurado con las credenciales de AWS uso local
  }
}

# Módulo VPC
module "vpc_prueba3" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  environment = "desarrollo"
  name = "vpc-prueba3"  
}

# Módulo Subnet
module "subnet_prueba3" {
  source = "./modules/subnet"
  vpc_id = module.vpc_prueba3.vpc_id
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone_public = "us-east-1a"
  availability_zone_private = "us-east-1b"
  environment = "desarrollo"
}

# Módulo Internet Gateway
module "internet_gateway_prueba3" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc_prueba3.vpc_id
  environment = "desarrollo"
  name = "internet-gateway-prueba3"  # Nombre del Internet Gateway
}

# Módulo Routing
module "route_prueba3" {
  source = "./modules/route"
  vpc_id = module.vpc_prueba3.vpc_id
  public_subnet_id = module.subnet_prueba3.subnet_publica_id
  gateway_id = module.internet_gateway_prueba3.igw_id  
  environment = "desarrollo"
  name = "route-table-prueba3"  # Nombre descriptivo de la tabla de rutas
}

# Módulo Security Group
module "security_group_prueba3" {
  source       = "./modules/security_group"
  vpc_id       = module.vpc_prueba3.vpc_id
  environment  = "desarrollo"
  name = "security-group-prueba3"          
  description  = "Grupo de seguridad para la prueba 3"  # Descripción del Security Group
  allowed_cidrs = ["0.0.0.0/0"]                
}
# Módulo ec2
module "ec2_prueba3" {
  source             = "./modules/ec2"
  ami_id             = "ami-0e2c8caa4b6378d8c"  
  instance_type      = "t2.micro"
  public_subnet_id   = module.subnet_prueba3.subnet_publica_id
  security_group_id  = module.security_group_prueba3.sg_id  # Referencia al output del security group
  name               = "ec2-prueba3" 
  key_name           = "EC2"  # Nombre del par de claves
  environment        = "desarrollo"
}

# Módulo sns
module "sns" {
  source        = "./modules/sns"
  sns_topic_name = "sns-prueba3"
  sns_protocol   = "email"
  sns_endpoint   = "gauger.gac@gmail.com"
  environment    = "desarrollo"
}
# Módulo sqs
module "sqs" {
  source          = "./modules/sqs"
  sqs_queue_arn   = "sqs-prueba3"  
  environment     = "desarrollo"
}
# Módulo lambda
module "lambda" {
  source         = "./modules/lambda"
  sns_topic_arn  = module.sns.sns_topic_arn
  sqs_queue_arn  = module.sqs.sqs_queue_arn  
  environment    = "desarrollo"
}

# Módulo ECR
module "ecr_prueba3" {
  source          = "./modules/ecr"  
  ecr_name        = "landing-page-repo"  # Nombre del repositorio ECR
  environment     = "desarrollo"  
  region          = "us-east-1"  
}

