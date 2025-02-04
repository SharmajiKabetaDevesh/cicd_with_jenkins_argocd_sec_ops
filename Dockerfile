FROM python:3.13.1-slim-bookworm

WORKDIR  /app


COPY . /app

RUN pip install -r requirements.txt

CMD ["gunicorn","-w","4","-b","0.0.0.0:5000","wsgi:app"]

EXPOSE 5000