python -m venv create_layer
source create_layer/bin/activate
#pip install -r requirements.txt
pip3 install --platform manylinux2014_x86_64 --target create_layer/lib/python3.9 --python-version 3.9 --only-binary=:all: -r requirements.txt