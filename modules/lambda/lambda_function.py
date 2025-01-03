import json
import boto3
import logging
import os  

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Inicializar el cliente SNS usando las variables de entorno
sns = boto3.client('sns')

def lambda_handler(event, context):
    try:
        # Obtener el ARN del SNS desde las variables de entorno
        sns_topic_arn = os.environ.get('SNS_TOPIC_ARN')

        # Si el ARN no está configurado, lanzar un error
        if not sns_topic_arn:
            raise ValueError('El ARN del SNS no está configurado en las variables de entorno.')

        # Obtener el mensaje de SQS
        for record in event['Records']:
            # Parsear el mensaje
            message = json.loads(record['body'])
            
            # Extraer la información
            event_id = message['id']
            event_type = message['event']
            timestamp = message['timestamp']
            
            # Crear el mensaje para la notificación
            notification_message = f"""
            Se ha recibido un nuevo evento:
            ID: {event_id}
            Tipo: {event_type}
            Fecha: {timestamp}
            """
            
            # Enviar la notificación a SNS
            response = sns.publish(
                TopicArn=sns_topic_arn,  # Usando la variable de entorno
                Message=notification_message,
                Subject='Nuevo evento recibido'
            )
            
            logger.info(f"Notificación enviada exitosamente: {response['MessageId']}")
            
        return {
            'statusCode': 200,
            'body': json.dumps('Proceso completado exitosamente')
        }
        
    except Exception as e:
        logger.error(f"Error procesando el mensaje: {str(e)}")
        raise e
