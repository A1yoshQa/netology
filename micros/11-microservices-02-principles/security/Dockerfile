FROM python:3.9-alpine
WORKDIR /app

COPY requirements.txt .
RUN pip install --proxy http://172.16.1.10:3128 -r requirements.txt
COPY src ./

CMD [ "python", "./server.py" ]
