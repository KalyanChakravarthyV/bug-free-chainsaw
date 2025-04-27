#layer_version_arn comes from previous command

aws lambda update-function-configuration \
  --region=ap-south-1 \
  --function-name okta_authorizer \
  --cli-binary-format raw-in-base64-out \
  --layers "$layer_version_arn"