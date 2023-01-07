FROM python:3.8-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git -y
COPY requirements.txt /requirements.txt

RUN cd /
RUN pip3 install -U pip && pip3 install -U -r requirements.txt
RUN npm i gunicorn
RUN pip install git+https://github.com/benoitc/gunicorn.git
RUN mkdir /IMDb-Movie-Bot
WORKDIR /IMDb-Movie-Bot
COPY start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]

CMD gunicorn --bind 0.0.0.0:8000 \
        --chdir /code/api \
        --log-level $GUNICORN_LOG_LEVEL \
        --worker-class $GUNICORN_WORKER_CLASS \
        --worker-connections $GUNICORN_WORKER_CONNECTIONS \
        --workers $GUNICORN_WORKERS \
        --limit-request-line $GUNICORN_LIMIT_REQUEST_LINE \
        --timeout $GUNICORN_TIMEOUT app:app
        
ENV GUNICORN_LOG_LEVEL=debug \
    GUNICORN_WORKER_CLASS=sync \
    GUNICORN_WORKER_CONNECTIONS=1000 \
    GUNICORN_WORKERS=3 \
    GUNICORN_LIMIT_REQUEST_LINE=4094 \
    GUNICORN_TIMEOUT=60        
