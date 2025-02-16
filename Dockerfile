FROM python:3.13.1-slim-bookworm

WORKDIR  /app


COPY . /app

RUN pip install -r requirements.txt

CMD ["python","app.py"]

EXPOSE 5000