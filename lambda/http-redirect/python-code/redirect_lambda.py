# import boto3

def lambda_handler(event, context):
    return {
        'statusCode' : 302,
        'headers': {'Location': 'https://blog.vadlakonda.in'}
    }