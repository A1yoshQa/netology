FROM centos:7

RUN yum update -y && \
    yum install -y python3 && \
    pip3 install flask flask-jsonpify flask-restful

RUN mkdir /python_api

COPY repository/python-api.py /python_api

WORKDIR /python_api

CMD ["python3", "python-api.py"]
