FROM ubi8/python-39:latest

# If the container is not run on a registered RHEL system then use this for the base container:
#FROM registry.fedoraproject.org/f35/python3

LABEL maintainer="cversky@redhat.com"

USER root

RUN yum -y --nodocs install opencv-core opencv-contrib  &&\
    yum clean all -y --quiet --allowerasing

RUN python3 -m pip install --upgrade pip && \
    pip3 install --no-cache-dir protobuf==3.20.* mediapipe matplotlib flask

WORKDIR /app

COPY app.py ./
COPY HowsMySalute.py ./
COPY templates/ ./templates/
COPY graphics/ ./static/graphics/

EXPOSE 8080

USER 1001

CMD ["python3","app.py"]
