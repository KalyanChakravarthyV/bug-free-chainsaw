aws lambda publish-layer-version \
    --region=ap-south-1 \
    --layer-name libs \
    --zip-file fileb://layer_content.zip \
    --compatible-runtimes python3.9 \
    --compatible-architectures 'x86_64' \


#export layer_version_arn=arn:aws:lambda:ap-south-2:520704029026:layer:libs:4