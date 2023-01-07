FROM python:3.8-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git -y
COPY requirements.txt /requirements.txt

RUN cd /
RUN pip3 install -U pip && pip3 install -U -r requirements.txt
RUN pip install git+https://github.com/benoitc/gunicorn.git
RUN mkdir /IMDb-Movie-Bot
WORKDIR /IMDb-Movie-Bot
COPY start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]pip install gunicorn
