# base image
FROM python:3.7.2-slim

# install netcat
RUN apt-get update && \
    apt-get -y install netcat && \
    apt-get clean

# set working directory
WORKDIR /usr/src/app

# add and install requirements
# install pipenv
RUN set -ex && pip install pipenv --upgrade

# copy pipfiles
COPY ./Pipfile Pipfile
COPY ./Pipfile.lock Pipfile.lock

# -- Install Python dependencies:
RUN set -ex && pipenv install --deploy --system

# add app
COPY . /usr/src/app

RUN chmod +x /usr/src/app/entrypoint.sh
# run server
#CMD ["ls","-l"]
CMD ["/usr/src/app/entrypoint.sh"]
