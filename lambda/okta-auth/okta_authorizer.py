import json
import jwt
import requests
import os

# Constants
OKTA_DOMAIN = os.environ.get('OKTA_DOMAIN') # based on Okta authorization server
AUDIENCE = "api://default"  # Or any custom Audience value
ISSUER = f"{OKTA_DOMAIN}/oauth2/default" 



def lambda_handler(event, context):
    token = get_token_from_event(event)

    if not 'methodArn' in event:
        event['methodArn'] = 'Default Method ARN'
        
    try:

        print(f"event: {event}")
        if not token:
            return generate_policy('anonymous', 'Deny', event['methodArn'])

        # 1. Fetch Okta public keys (JWKS)
        jwks_url = f"{ISSUER}/v1/keys"
        jwks = requests.get(jwks_url).json()

        # 2. Decode and verify the token
        public_keys = {}
        for key in jwks['keys']:
            kid = key['kid']
            public_keys[kid] = jwt.algorithms.RSAAlgorithm.from_jwk(json.dumps(key))

        unverified_header = jwt.get_unverified_header(token)
        rsa_key = public_keys.get(unverified_header['kid'])

        if rsa_key is None:
            raise Exception('Public key not found in JWKS')

        payload = jwt.decode(
            token,
            rsa_key,
            algorithms=['RS256'],
            audience=AUDIENCE,
            issuer=ISSUER
        )

        # 3. Successful validation
        principal_id = payload['sub']
        print(f" Auth response payload: {payload}")

        return generate_policy(principal_id, 'Allow', event['methodArn'])

    except Exception as e:
        print(f"Authorization failed: {str(e)}")
        return generate_policy('anonymous', 'Deny', str(e))


def get_token_from_event(event):
    try:
        #Check for Auth vs auth
        auth_header = event['headers']['Authorization']
        token_parts = auth_header.split()
        if token_parts[0].lower() == 'bearer' and len(token_parts) == 2:
            return token_parts[1]

    except Exception:
        pass
    return None


def generate_policy(principal_id, effect, resource):
    return {
        'principalId': principal_id,
        'policyDocument': {
            'Version': '2012-10-17',
            'Statement': [{
                'Action': 'execute-api:Invoke',
                'Effect': effect,
                'Resource': resource
            }]
        }
    }
