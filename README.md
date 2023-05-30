# Jenkins Custom Images
A set of Dockerfile builds with Python inside container image


Build Example Command
````
docker build -t mycustomimage:latest -f builds/custom-jenkins-python-310.Dockerfile .
````
 
Jenkins Build Example (Python 3.10)
````shell
VENV_NAME="venv_${JOB_NAME}"
/usr/local/bin/python3.10 -m venv ${VENV_NAME}
. ${VENV_NAME}/bin/activate
touch requirements.txt
echo 'requests'> requirements.txt

# Install the dependencies
pip install -r requirements.txt

touch main.py 
echo "import requests" >> main.py
echo "r = requests.get('http://www.google.com.br')" >> main.py
echo "print(r.status_code)" >> main.py
python3 main.py
deactivate
rm -r $VENV_NAME
````
