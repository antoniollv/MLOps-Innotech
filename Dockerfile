#!/bin/bash
###################################
# MLOPS          #
###################################

FROM python:3.10-slim-buster
#FROM --platform=linux/arm64/v8 python:3.10.13

SHELL ["/bin/bash", "-c"]

#RUN apt update && apt install -y liblapack3 libblas3 libpq-dev python-dev && apt -y clean
WORKDIR /application

COPY docker-requirements.txt /application/docker-requirements.txt

#ADD .pypirc /home/.pypirc
#ADD pip.conf /etc/pip.conf
RUN pip3 install -U pip && pip3 install -r /application/docker-requirements.txt
RUN pip3 install "fastapi[standard]" streamlit altair==4.0 uvicorn
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         ca-certificates \
#         cmake \
#         build-essential \
#         gcc \
#         g++ \
#         git && \
#     rm -rf /var/lib/apt/lists/* && \
#     apt-get install libgomp1 -y


RUN apt-get update \
    && apt-get -y update

RUN apt-get -y install libgomp1

#     apt-get install
# RUN set -ue \
#     ; apt-get -y update \
#     ; apt-get install -y --no-install-recommends --no-install-suggests git \
#     ; rm -rf /var/lib/apt/lists/* \
# ;

# RUN apt-get update && \
#     apt-get -y install curl git gcc && \
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
#     (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile && \
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
#     brew install glpk && \
#     brew install ipopt && \
#     brew install cbc

# Create appuser
RUN useradd -ms /bin/bash appuser

#ADD ./ /ai2o
#COPY . /ai2o
ADD ./ /application


RUN ls -laRt /application
RUN chmod a+rwx -R /application

USER appuser
ENV PYTHONPATH=/application
#ENV PYTHONPATH=/
# ENV CONFIG_DIR=/ai2o/data/cfg/
# ENV CONFIG_FILE_NAME=/ai2o/data/cfg/configuration_docker.yaml

WORKDIR /application
RUN ls /application

EXPOSE 5001/tcp 

#ENTRYPOINT ["./application/entrypoint.sh"]
#CMD ["/ai2o/interface/Instrucciones.py", "--server.headless", "true", "--server.fileWatcherType", "none", "--browser.gatherUsageStats", "false"]
# "fastapi", "run", "src/create_service.py", "--port", "8000" ; 
# "streamlit", "run", "/application/src/create_app.py" ,"--server.port=8080", "--server.enableWebsocketCompression=false","--server.enableCORS=false", "--server.headless=true" ;
CMD ["fastapi", "run", "/application/application/src/create_service.py", "--port", "5001"]
#CMD ["./entrypoint.sh"]
